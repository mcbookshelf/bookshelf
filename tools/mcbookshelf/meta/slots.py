from dataclasses import dataclass, replace

from . import model, rules, syntax
from .diagnostics import Diagnostics
from .resolver import TypeResolver
from .storages import Storages
from .syntax import Kind, PrimitiveKind, Role


@dataclass
class SlotBuilder:
    """Builds the contexts, inputs and outputs of one feature."""

    namespace: str
    registry: str
    name: str
    types: TypeResolver
    storages: Storages
    report: Diagnostics

    @property
    def definition(self) -> rules.Registry:
        return rules.REGISTRIES[self.registry]

    def slots(self, node: syntax.Feature) -> tuple[model.Slot, ...]:
        """The lines of a feature: two of the same kind on the same storage are the same line."""
        drafts: dict[tuple[Role, Kind, model.Target | None], model.Slot] = {}
        for line in node.lines:
            if isinstance(line, syntax.Slot) and (draft := self.draft(line)) is not None:
                key = (draft.role, draft.kind, draft.target)
                drafts[key] = _merge(drafts.get(key), draft)
        slots = tuple(self.finish(slot) for slot in drafts.values())
        self.validate_slots(slots, node.line)
        return slots

    def draft(self, line: syntax.Slot) -> model.Slot | None:
        kind = line.kind
        if not self.validate_allowed(kind, line.role, line.line):
            return None
        if line.storage is not None and kind not in rules.STORAGES:
            self.report.error(f"a {kind} writes nowhere, it takes no storage target", line.line)
        target = self.target(line.storage, line.role, line.line) if kind in rules.STORAGES else None
        slot_type = self.types.resolve(line.type, line.fields, line.line)
        description = line.description or self.types.alias_description(line.type)
        return model.Slot(line.role, kind, target, slot_type, description, line.line)

    def finish(self, slot: model.Slot) -> model.Slot:
        """Check a line once it is whole, and give it the type it has by default."""
        kind, value, line = slot.kind, slot.type, slot.line
        if slot.target is not None:
            self.types.validate_data_type(value, line)
            self.storages.add(slot.target, value, line)
            if kind is Kind.ARGUMENTS and value and not isinstance(value, syntax.Struct):
                message = f"'{value}' is not a type arguments take, they need a struct"
                self.report.error(message, line)
            return slot
        value = value or self.default_type(kind, line)
        self.validate_kind_type(kind, value, line)
        return replace(slot, type=value)

    def target(self, storage: syntax.Storage | None, role: Role, line: int) -> model.Target:
        namespace = self.namespace
        id_ = f"{namespace}:{_group(self.name) or self.name}"
        keys: tuple[str, ...] = ("in" if role is Role.INPUT else "out",)
        if storage is not None and storage.id:
            id_ = storage.id
            if id_.partition(":")[0] != namespace:
                self.report.error(f"'{id_}' does not have the same namespace as the module", line)
        if storage is not None and storage.path:
            keys = tuple(storage.path.split("/"))
        return model.Target(id=id_, keys=keys)

    def validate_allowed(self, kind: Kind, role: Role, line: int) -> bool:
        kinds = self.definition.allowed(role)
        if kind in kinds:
            return True
        if not kinds:
            self.report.error(f"a {self.registry} declares no {role}", line)
        else:
            accepted = ", ".join(sorted(str(k) for k in kinds))
            message = f"a {self.registry} takes no {kind} as {role}, only {accepted}"
            self.report.error(message, line)
        return False

    def validate_slots(self, slots: tuple[model.Slot, ...], line: int) -> None:
        requires = self.definition.requires
        outputs = [s.kind for s in slots if s.role is Role.OUTPUT]
        macros = [s for s in slots if s.kind in rules.MACROS]

        if requires is not None and requires not in outputs:
            self.report.error(f"a {self.registry} must declare 'output {requires}'", line)

        if len(macros) > 1:
            self.report.error(
                "a feature takes one macro: declared, or derived from its arguments",
                macros[1].line,
            )

    def result_type(self, line: int) -> PrimitiveKind:
        result = self.definition.result
        if result is None:
            self.report.error(f"a {self.registry} returns no result", line)
            return PrimitiveKind.INT
        return result

    def default_type(self, kind: Kind, line: int) -> syntax.Type | None:
        if kind is Kind.RESULT:
            return syntax.Primitive(kind=self.result_type(line))
        if kind in rules.CONTEXT_TYPES:
            return rules.CONTEXT_TYPES[kind][0]
        return None

    def validate_kind_type(self, kind: Kind, value: syntax.Type | None, line: int) -> None:
        if kind in rules.UNTYPED:
            if value is not None:
                detail = ", it is always 0 or 1" if kind is Kind.SUCCESS else ""
                self.report.error(f"a {kind} carries no type{detail}", line)

        elif value is None:
            self.report.error(f"'{kind}' needs a type", line)

        elif kind is Kind.MACRO:
            if not isinstance(value, syntax.Struct):
                self.report.error(f"'{value}' is not a type a macro takes", line)
            self.types.validate_data_type(value, line)

        elif kind is Kind.RESULT:
            result = self.result_type(line)
            if not (isinstance(value, syntax.Primitive) and value.kind is result):
                message = f"'{value}' is not a type this result takes, it is a {result}"
                self.report.error(message, line)

        elif not syntax.accepts(value, rules.CONTEXT_TYPES[kind]):
            self.report.error(f"'{value}' is not a type a {kind} takes", line)


def validate_groups(features: tuple[model.Feature, ...], report: Diagnostics) -> None:
    """The features of a group share one input and one output."""
    firsts: dict[tuple[str, str], model.Feature] = {}
    for feature in features:
        if not (group := _group(feature.name)):
            continue
        first = firsts.setdefault((feature.resource, group), feature)
        for role in (Role.INPUT, Role.OUTPUT):
            if _interface(feature, role) != _interface(first, role):
                message = (
                    f"'{feature.name}' does not have the {role} of '{first.name}': "
                    "the features of a group share it, move it out of the group otherwise"
                )
                report.error(message, feature.line)


def _merge(previous: model.Slot | None, slot: model.Slot) -> model.Slot:
    """A line replaces the same line written before it; two structs add up their fields."""
    if previous is None:
        return slot
    if isinstance(previous.type, syntax.Struct) and isinstance(slot.type, syntax.Struct):
        entries = {e.name: e for e in (*previous.type.entries, *slot.type.entries)}
        merged = replace(slot.type, entries=tuple(entries.values()))
        return replace(slot, type=merged, description=slot.description or previous.description)
    return slot


def _group(name: str) -> str:
    """The group of a feature: the folder it lies in, empty for a feature on its own."""
    return name.rpartition("/")[0]


def _interface(feature: model.Feature, role: Role) -> frozenset[tuple[str, str]]:
    return frozenset(
        (slot.target.display, str(slot.type))
        for slot in feature.of(role)
        if slot.target is not None
    )

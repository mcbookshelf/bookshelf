from dataclasses import dataclass, field, replace
from pathlib import Path
from typing import Any

from mcbookshelf import constants
from mcbookshelf.references import groups

from . import model, rules, syntax
from .diagnostics import Diagnostics, MetadataError
from .syntax import Kind, PrimitiveKind, Role

INDEX_URL = f"{constants.DOCS_PAGES_URL}/index.html"


def build_module(document: syntax.Module, name: str, file: Path | None = None) -> model.Module:
    """Build a module model from a parsed document, raising every error found at once."""
    report = Diagnostics(file)
    module = _Builder(name, report).module(document)
    if report.items:
        raise MetadataError(report.items)
    return module


def build_bundle(document: syntax.Module, name: str, file: Path | None = None) -> model.Bundle:
    """Build a bundle model from a parsed document, raising every error found at once."""
    report = Diagnostics(file)
    bundle = _Builder(name, report).bundle(document)
    if report.items:
        raise MetadataError(report.items)
    return bundle


def _anchor(name: str, resource: str, *, shared: bool) -> str:
    anchor = name.replace("/", "-").replace("_", "-")
    return f"{anchor}-{resource.replace('/', '-')}" if shared else anchor


def _group(name: str) -> str:
    """The group of a feature: the folder it lies in, empty for a feature on its own."""
    return name.rpartition("/")[0]


def _interface(feature: model.Feature, role: Role) -> frozenset[tuple[str, str]]:
    return frozenset(
        (slot.target.display, str(slot.type))
        for slot in feature.of(role)
        if slot.target is not None
    )


def _module_url(namespace: str) -> str:
    return f"{constants.DOCS_PAGES_URL}/modules/{model.short(namespace)}.html"


@dataclass(frozen=True, slots=True)
class _Value:

    value: Any
    line: int


@dataclass
class _FeatureBuilder:

    module: _Builder
    registry: str
    name: str

    @property
    def report(self) -> Diagnostics:
        return self.module.report

    @property
    def definition(self) -> rules.Registry:
        return rules.REGISTRIES[self.registry]

    def slots(self, node: syntax.Feature) -> tuple[model.Slot, ...]:
        slots = tuple(slot for line in node.slots if (slot := self.slot(line)) is not None)
        self.validate_slots(slots, node.line)
        return slots

    def slot(self, slot: syntax.Slot) -> model.Slot | None:
        resolved = self.declaration(slot)
        if resolved is None:
            return None

        declaration, description = resolved
        kind = declaration.kind
        description = description or self.module.alias_description(declaration.type)
        slot_type = self.module.resolve(declaration.type, slot.line) if declaration.type else None

        if not self.validate_allowed(kind, slot.role, slot.line):
            return None
        if declaration.storage is not None and kind not in rules.STORAGES:
            self.report.error(f"a {kind} writes nowhere, it takes no storage target", slot.line)

        if kind in rules.STORAGES:
            target = self.target(declaration.storage, slot.role, slot.line)
            self.module.validate_data_type(slot_type, slot.line)
            self.module.add_storage(target, slot_type, slot.line)
            if kind is Kind.ARGUMENTS and not isinstance(slot_type, syntax.Struct):
                self.report.error(
                    f"'{slot_type}' is not a type arguments take, they need a struct",
                    slot.line,
                )
            return model.Slot(slot.role, kind, target, slot_type, description, slot.line)

        slot_type = slot_type or self.default_type(kind, slot.line)
        self.validate_kind_type(kind, slot_type, slot.line)
        return model.Slot(slot.role, kind, None, slot_type, description, slot.line)

    def declaration(self, slot: syntax.Slot) -> tuple[syntax.Declaration, str | None] | None:
        if isinstance(slot.value, syntax.Declaration):
            return slot.value, slot.value.description
        variable = self.module.lookup(slot.value.name, slot.value.line, slot=True)
        if variable is None or not isinstance(variable.value, syntax.Declaration):
            return None
        return variable.value, slot.value.description or variable.description

    def target(self, storage: syntax.Storage | None, role: Role, line: int) -> model.Target:
        namespace = self.module.id
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
                "a feature takes one macro: declared, or derived from one arguments slot",
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
                always = ", it is always 0 or 1" if kind is Kind.SUCCESS else ""
                self.report.error(f"a {kind} carries no type{always}", line)

        elif value is None:
            self.report.error(f"'{kind}' needs a type", line)

        elif kind is Kind.MACRO:
            if not isinstance(value, syntax.Struct):
                self.report.error(f"'{value}' is not a type a macro takes", line)
            self.module.validate_data_type(value, line)

        elif kind is Kind.RESULT:
            result = self.result_type(line)
            if not (isinstance(value, syntax.Primitive) and value.kind is result):
                message = f"'{value}' is not a type this result takes, it is a {result}"
                self.report.error(message, line)

        elif not syntax.accepts(value, rules.CONTEXT_TYPES[kind]):
            self.report.error(f"'{value}' is not a type a {kind} takes", line)


@dataclass
class _Builder:

    id: str
    report: Diagnostics
    variables: dict[str, syntax.Variable] = field(default_factory=dict)
    storages: dict[str, model.Storage] = field(default_factory=dict)

    # --- documents ---------------------------------------------------------- --

    def bundle(self, document: syntax.Module) -> model.Bundle:
        if document.features:
            self.report.error("a bundle declares no feature", document.features[0].line)
        if document.variables:
            self.report.error("a bundle declares no variable", document.variables[0].line)
        properties = self.properties(document.properties, rules.BUNDLE_PROPERTIES, 1)

        return model.Bundle(
            id=self.id,
            name=properties["name"].value,
            slug=properties["slug"].value,
            version=properties["version"].value,
            description=self.description(document),
            documentation=properties["documentation"].value or INDEX_URL,
            tags=properties["tags"].value,
        )

    def module(self, document: syntax.Module) -> model.Module:
        properties = self.properties(document.properties, rules.MODULE_PROPERTIES, 1)
        documentation = properties["documentation"].value or _module_url(self.id)
        self.define(document.variables)

        features = {}
        names = [self.feature_name(node) for node in document.features]
        folders = groups(names)
        for node, name in zip(document.features, names, strict=True):
            if name in folders:
                message = f"'{name}' is also the folder of other features, which share its files"
                self.report.error(message, node.line)
            key = (rules.REGISTRIES[node.registry].resource, name)
            if key in features:
                first = features[key].line
                message = f"{key[0]} {name} is already declared on line {first}"
                self.report.error(message, node.line)
                continue
            shared = names.count(name) > 1
            features[key] = self.feature(node, name, documentation, shared=shared)
        self.validate_groups(tuple(features.values()))

        return model.Module(
            id=self.id,
            name=properties["name"].value,
            slug=properties["slug"].value,
            version=properties["version"].value,
            description=self.description(document),
            documentation=documentation,
            tags=properties["tags"].value,
            weak_dependencies=properties["weak_dependencies"].value,
            features=tuple(features.values()),
            storages=dict(sorted(self.storages.items())),
        )

    def description(self, document: syntax.Module) -> str:
        if document.description is None:
            self.report.error("missing description: write it with '>' on the first line", 1)
            return ""
        return document.description

    def properties(
        self,
        nodes: tuple[syntax.Property, ...],
        fields: dict[str, rules.Field],
        line: int,
    ) -> dict[str, _Value]:
        """Read every known property; a missing or invalid one gets its default."""
        values: dict[str, _Value] = {}
        for node in nodes:
            spec = fields.get(node.key)
            if spec is None:
                self.report.error(f"unknown property '{node.key}'", node.line)
            elif node.key in values:
                first = values[node.key].line
                self.report.error(f"'{node.key}' is already declared on line {first}", node.line)
            else:
                try:
                    value = spec.parse(node.value)
                except ValueError as error:
                    self.report.error(str(error), node.line)
                    value = spec.default
                values[node.key] = _Value(value, node.line)

        for key, spec in fields.items():
            if key not in values:
                if spec.required:
                    self.report.error(f"missing property '{key}'", line)
                values[key] = _Value(spec.default, line)

        return values

    # --- features ----------------------------------------------------------- --

    def feature_name(self, node: syntax.Feature) -> str:
        namespace, sep, name = node.id.partition(":")
        if not sep:
            name = node.id
        elif namespace != self.id:
            self.report.error(f"'{node.id}' is not in the namespace of the module", node.line)
        if name.startswith("__"):
            self.report.error("a feature id cannot start with '__'", node.line)
        return name

    def feature(
        self,
        node: syntax.Feature,
        name: str,
        documentation: str,
        *,
        shared: bool,
    ) -> model.Feature:
        properties = self.properties(node.properties, rules.FEATURE_PROPERTIES, node.line)
        created = model.Stamp(*properties["created"].value)
        updated = model.Stamp(*properties["updated"].value)
        if created.minecraft_version and updated.minecraft_version and updated.date < created.date:
            message = f"updated on {updated.date}, before created on {created.date}"
            self.report.error(message, properties["updated"].line)

        slots = _FeatureBuilder(self, node.registry, name).slots(node)
        resource = rules.REGISTRIES[node.registry].resource
        anchor = _anchor(name, resource, shared=shared)

        return model.Feature(
            module=self.id,
            resource=resource,
            name=name,
            description=node.description,
            documentation=f"{documentation}#{anchor}",
            anchor=anchor,
            authors=properties["authors"].value,
            contributors=properties["contributors"].value,
            created=created,
            updated=updated,
            slots=slots,
            line=node.line,
            deprecated=properties["deprecated"].value,
            experimental=properties["experimental"].value,
        )

    def validate_groups(self, features: tuple[model.Feature, ...]) -> None:
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
                    self.report.error(message, feature.line)

    # --- variables ---------------------------------------------------------- --

    def define(self, nodes: tuple[syntax.Variable, ...]) -> None:
        for node in nodes:
            if node.name in self.variables:
                first = self.variables[node.name].line
                self.report.error(f"'${node.name}' is already declared on line {first}", node.line)
                continue
            self.variables[node.name] = node

    def lookup(self, name: str, line: int, *, slot: bool) -> syntax.Variable | None:
        variable = self.variables.get(name)
        if variable is None:
            self.report.error(f"unknown name '${name}'", line)
            return None

        if isinstance(variable.value, syntax.Declaration) != slot:
            expected, found = ("slot", "type") if slot else ("type", "slot")
            declared = f"it is declared on line {variable.line}"
            self.report.error(f"'${name}' is a {found}, not a {expected}: {declared}", line)
            return None

        return variable

    # --- types -------------------------------------------------------------- --

    def resolve(self, value: syntax.Type, line: int, stack: tuple[str, ...] = ()) -> syntax.Type:
        match value:
            case syntax.Reference():
                return self.expand_reference(value, line, stack)
            case syntax.List(element=el):
                return replace(value, element=self.resolve(el, line, stack))
            case syntax.Tuple(elements=els):
                return replace(value, elements=tuple(self.resolve(e, line, stack) for e in els))
            case syntax.Union(members=members):
                return replace(value, members=tuple(self.resolve(m, line, stack) for m in members))
            case syntax.Struct(entries=entries):
                return replace(value, entries=tuple(self.resolve_entry(e, stack) for e in entries))
        return value

    def resolve_entry(self, entry: syntax.Entry, stack: tuple[str, ...]) -> syntax.Entry:
        description = entry.description or self.alias_description(entry.type)
        resolved = self.resolve(entry.type, entry.line, stack)
        return replace(entry, type=resolved, description=description)

    def alias_description(self, value: syntax.Type | None) -> str | None:
        if not isinstance(value, syntax.Reference):
            return None
        variable = self.variables.get(value.name)
        if variable is None or isinstance(variable.value, syntax.Declaration):
            return None
        return variable.description

    def expand_reference(
        self,
        reference: syntax.Reference,
        line: int,
        stack: tuple[str, ...],
    ) -> syntax.Type:
        name = reference.name
        if name in stack:
            path = " > ".join(f"${s}" for s in stack)
            self.report.error(f"'${name}' refers to itself through {path}", line)
            return rules.ANY

        variable = self.lookup(name, line, slot=False)
        if variable is None or isinstance(variable.value, syntax.Declaration):
            return rules.ANY
        resolved = self.resolve(variable.value, variable.line, (*stack, name))
        if not reference.attributes:
            return resolved

        if isinstance(resolved, syntax.Union):
            self.report.error(f"'${name}' cannot take an attribute, it is a '{resolved}'", line)
            return resolved

        return replace(resolved, attributes=(*reference.attributes, *resolved.attributes))

    def validate_data_type(self, value: syntax.Type | None, line: int) -> None:
        match value:
            case syntax.Primitive(kind=kind) if kind in rules.CONTEXT_ONLY:
                self.report.error(f"'{kind}' is not a data type", line)
            case syntax.Array(element=element) | syntax.List(element=element):
                self.validate_data_type(element, line)
            case syntax.Tuple(elements=elements) | syntax.Union(members=elements):
                for element in elements:
                    self.validate_data_type(element, line)
            case syntax.Struct(entries=entries):
                for entry in entries:
                    self.validate_data_type(entry.type, entry.line)

    # --- storages ----------------------------------------------------------- --

    def add_storage(self, target: model.Target, value: syntax.Type | None, line: int) -> None:
        if value is None:
            self.report.error("a storage needs a type", line)
            return

        *parents, name = target.keys
        entry = syntax.Entry(name=name, type=value, optional=True, line=line)
        for parent in reversed(parents):
            struct = syntax.Struct(entries=(entry,), line=line)
            entry = syntax.Entry(name=parent, type=struct, optional=True, line=line)

        declared = syntax.Struct(entries=(entry,), line=line)
        storage = self.storages.get(target.id)
        self.storages[target.id] = replace(
            storage,
            struct=self.merge_storage(storage.struct, declared, target.id),
        ) if storage else model.Storage(target.id, declared)

    def merge_storage(self, first: syntax.Struct, second: syntax.Struct, id_: str) -> syntax.Struct:
        entries = list(first.entries)
        names = {e.name: i for i, e in enumerate(entries)}

        for entry in second.entries:
            index = names.get(entry.name)
            if index is None:
                names[entry.name] = len(entries)
                entries.append(entry)
                continue

            previous = entries[index]
            if isinstance(previous.type, syntax.Struct) and isinstance(entry.type, syntax.Struct):
                merged = self.merge_storage(previous.type, entry.type, id_)
                entries[index] = replace(previous, type=merged)
            elif previous.type != entry.type:
                self.report.error(
                    f"'{entry.name}' of storage {id_} is already declared "
                    f"as '{previous.type}' on line {previous.line}",
                    entry.line,
                )

        return replace(first, entries=tuple(entries))

import re
from collections.abc import Callable, Iterator
from dataclasses import dataclass, field, replace
from itertools import product
from pathlib import Path
from typing import Any

from mcbookshelf import constants
from mcbookshelf.references import groups

from . import model, rules, syntax
from .diagnostics import Diagnostics, MetadataError
from .syntax import Kind, PrimitiveKind, Role

INDEX_URL = f"{constants.DOCS_PAGES_URL}/index.html"

# a '$list' or '$list.key' in an id, a doc or a metadata value
TEXT_REFERENCE = re.compile(r"\$([A-Za-z_][A-Za-z0-9_]*)(?:\.([A-Za-z_][A-Za-z0-9_]*))?")

MISSING_METADATA = "'{}' is missing: write it in the feature, in the lines it pastes or in the head"

type Text = Callable[[str, int], str]


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


def _structs(value: syntax.Type) -> int:
    """How many times a type, as written, holds the word `struct`."""
    match value:
        case syntax.Struct():
            return 1
        case syntax.List(element=element):
            return _structs(element)
        case syntax.Tuple(elements=elements) | syntax.Union(members=elements):
            return sum(map(_structs, elements))
    return 0


def _texts(node: Any, text: Text) -> Any:  # noqa: ANN401
    """A line or a field with its texts rewritten: its value, its doc and the ones of its fields."""
    match node:
        case syntax.Metadata(value=str() as value):
            return replace(node, value=text(value, node.line))
        case syntax.Slot() | syntax.Field():
            description = node.description and text(node.description, node.line)
            fields = tuple(_texts(f, text) for f in node.fields)
            return replace(node, description=description, fields=fields)
    return node


def _merge(previous: model.Slot | None, slot: model.Slot) -> model.Slot:
    """A line replaces the same line written before it; two structs add up their fields."""
    if previous is None:
        return slot
    if isinstance(previous.type, syntax.Struct) and isinstance(slot.type, syntax.Struct):
        entries = {e.name: e for e in (*previous.type.entries, *slot.type.entries)}
        merged = replace(slot.type, entries=tuple(entries.values()))
        return replace(slot, type=merged, description=slot.description or previous.description)
    return slot


@dataclass(frozen=True, slots=True)
class _Value:

    value: Any
    line: int


@dataclass(slots=True)
class _List:
    """A list: its items in the order they are written, with the text each gives for a key."""

    line: int
    items: dict[str, dict[str, str]] = field(default_factory=dict)
    keys: set[str] = field(default_factory=set)


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
        slot_type = self.module.resolve(line.type, line.fields, line.line)
        description = line.description or self.module.alias_description(line.type)
        return model.Slot(line.role, kind, target, slot_type, description, line.line)

    def finish(self, slot: model.Slot) -> model.Slot:
        """Check a line once it is whole, and give it the type it has by default."""
        kind, value, line = slot.kind, slot.type, slot.line
        if slot.target is not None:
            self.module.validate_data_type(value, line)
            self.module.add_storage(slot.target, value, line)
            if kind is Kind.ARGUMENTS and value and not isinstance(value, syntax.Struct):
                message = f"'{value}' is not a type arguments take, they need a struct"
                self.report.error(message, line)
            return slot
        value = value or self.default_type(kind, line)
        self.validate_kind_type(kind, value, line)
        return replace(slot, type=value)

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
    definitions: dict[str, syntax.Definition] = field(default_factory=dict)
    lists: dict[str, _List] = field(default_factory=dict)
    types: dict[str, syntax.Type] = field(default_factory=dict)
    building: list[str] = field(default_factory=list)
    storages: dict[str, model.Storage] = field(default_factory=dict)

    # --- documents ---------------------------------------------------------- --

    def bundle(self, document: syntax.Module) -> model.Bundle:
        if document.features:
            self.report.error("a bundle declares no feature", document.features[0].line)
        if document.definitions:
            self.report.error("a bundle declares no '$' name", document.definitions[0].line)
        if document.metadata:
            self.report.error("a bundle carries no metadata", document.metadata[0].line)
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
        for line in document.metadata:
            if line.key == "contributors":
                message = "'contributors' is written on features, not in the head"
                self.report.error(message, line.line)
        self.define(document.definitions)

        features = {}
        head = document.metadata
        nodes = [node for feature in document.features for node in self.repeat(feature, head)]
        names = [self.feature_name(node) for node in nodes]
        folders = groups(names)
        for node, name in zip(nodes, names, strict=True):
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
        nodes: tuple[syntax.Property | syntax.Metadata, ...],
        fields: dict[str, rules.Field],
        line: int,
        missing: str = "missing property '{}'",
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
                    value = spec.parse(node.value or "")
                except ValueError as error:
                    self.report.error(str(error), node.line)
                    value = spec.default
                values[node.key] = _Value(value, node.line)

        for key, spec in fields.items():
            if key not in values:
                if spec.required:
                    self.report.error(missing.format(key), line)
                values[key] = _Value(spec.default, line)

        return values

    # --- features ----------------------------------------------------------- --

    def repeat(
        self,
        node: syntax.Feature,
        head: tuple[syntax.Metadata, ...],
    ) -> Iterator[syntax.Feature]:
        """A feature with the lines it inherits and pastes, once per item of the lists of its id."""
        lines = (*head, *self.lines(node.lines))
        names: list[str] = []
        for match in TEXT_REFERENCE.finditer(node.id):
            if match[1] not in self.lists:
                self.report.error(f"'${match[1]}' is not a list", node.line)
            elif match[1] not in names:
                names.append(match[1])

        def check(value: str, line: int) -> str:
            for match in TEXT_REFERENCE.finditer(value):
                self.validate_reference(match[1], match[2], names, node.id, line)
            return value

        if node.description:
            check(node.description, node.line)
        for line in lines:
            _texts(line, check)

        # the leftmost list changes last
        for items in product(*(self.lists[name].items.items() for name in names)):
            chosen = dict(zip(names, items, strict=True))

            def text(value: str, _line: int, chosen: dict[str, Any] = chosen) -> str:
                return self.substitute(value, chosen)

            yield replace(
                node,
                id=text(node.id, node.line),
                description=node.description and text(node.description, node.line),
                lines=tuple(_texts(line, text) for line in lines),
            )

    def lines(self, body: tuple[Any, ...], stack: tuple[str, ...] = ()) -> Iterator[syntax.Line]:
        """The lines of a block, the pasted ones in place of their paste."""
        for line in body:
            if not isinstance(line, syntax.Paste):
                yield line
            elif line.name in stack:
                path = " > ".join(f"${s}" for s in stack)
                self.report.error(f"'${line.name}' pastes itself through {path}", line.line)
            elif (definition := self.lookup(line.name, line.line, "lines")) is not None:
                yield from self.lines(definition.body, (*stack, line.name))

    def validate_reference(
        self,
        name: str,
        key: str | None,
        names: list[str],
        feature: str,
        line: int,
    ) -> None:
        """A list written in a text is one of the id, and its key one every item gives."""
        found = self.lists.get(name)
        if found is None:
            return
        if name not in names:
            self.report.error(f"the list '${name}' is not in the id of '{feature}'", line)
        elif key in found.keys:
            missing = [f"'{item}'" for item, values in found.items.items() if key not in values]
            if missing:
                items = f"item{'s' if len(missing) > 1 else ''} {', '.join(missing)}"
                self.report.error(f"'${name}.{key}' is not defined for the {items}", line)

    def substitute(self, value: str, chosen: dict[str, tuple[str, dict[str, str]]]) -> str:
        """Replace `$list` by its item and `$list.key` by the text the item gives for the key."""

        def replacement(match: re.Match[str]) -> str:
            name, key = match[1], match[2]
            if name not in chosen:
                return match[0]
            item, values = chosen[name]
            if key is None:
                return item
            # a dot which opens no key of the list is text
            return values.get(key, match[0]) if key in self.lists[name].keys else f"{item}.{key}"

        return TEXT_REFERENCE.sub(replacement, value)

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
        # a metadata line replaces the same one written before it: the head, then the pasted lines
        metadata = {line.key: line for line in node.lines if isinstance(line, syntax.Metadata)}
        valued = tuple(line for line in metadata.values() if line.key in rules.FEATURE_METADATA)
        values = self.properties(valued, rules.FEATURE_METADATA, node.line, MISSING_METADATA)

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
            authors=values["authors"].value,
            contributors=values["contributors"].value,
            created=model.Stamp(*values["since"].value),
            slots=slots,
            line=node.line,
            deprecated="deprecated" in metadata,
            experimental="experimental" in metadata,
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

    # --- definitions -------------------------------------------------------- --

    def define(self, nodes: tuple[syntax.Definition | syntax.Items, ...]) -> None:
        for node in nodes:
            if isinstance(node, syntax.Items):
                self.define_items(node)
            elif (first := self.declared(node.name)) is not None:
                self.report.error(f"'${node.name}' is already declared on line {first}", node.line)
            else:
                self.definitions[node.name] = node
        # every type is built once, where it is declared: an error in it is reported there
        for name, definition in self.definitions.items():
            if definition.type is not None:
                self.type_of(name, definition.line)

    def define_items(self, node: syntax.Items) -> None:
        if node.name in self.definitions:
            first = self.definitions[node.name].line
            self.report.error(f"'${node.name}' is already declared on line {first}", node.line)
            return
        found = self.lists.setdefault(node.name, _List(node.line))
        values: dict[str, str] = {}
        for item in node.properties:
            if item.key in values:
                self.report.error(f"'{item.key}' is already given to these items", item.line)
            values[item.key] = item.value
        for item in node.items:
            if item in found.items:
                self.report.error(f"'{item}' is already an item of '${node.name}'", node.line)
            else:
                found.items[item] = values
        found.keys.update(values)

    def declared(self, name: str) -> int | None:
        """The line a name is declared on, if it is."""
        if name in self.definitions:
            return self.definitions[name].line
        return self.lists[name].line if name in self.lists else None

    def lookup(self, name: str, line: int, wanted: str) -> syntax.Definition | None:
        """Find a definition used as `wanted`: lines, or a type."""
        definition = self.definitions.get(name)
        if definition is None:
            if name in self.lists:
                declared = f"it is declared on line {self.lists[name].line}"
                self.report.error(f"'${name}' is a list, not {wanted}: {declared}", line)
            else:
                self.report.error(f"unknown name '${name}'", line)
            return None

        # a definition without a type is lines
        shape = "lines" if definition.type is None else "a type"
        if shape != wanted:
            declared = f"it is declared on line {definition.line}"
            self.report.error(f"'${name}' is {shape}, not {wanted}: {declared}", line)
            return None

        return definition

    # --- types -------------------------------------------------------------- --

    def type_of(self, name: str, line: int) -> syntax.Type:
        """The type a definition stands for, built once."""
        if name in self.building:
            path = " > ".join(f"${s}" for s in self.building)
            self.report.error(f"'${name}' refers to itself through {path}", line)
            return rules.ANY
        if name not in self.types:
            definition = self.lookup(name, line, "a type")
            if definition is None:
                return rules.ANY
            self.building.append(name)
            built = self.resolve(definition.type, definition.body, definition.line)
            self.building.pop()
            self.types[name] = built or rules.ANY
        return self.types[name]

    def resolve(
        self,
        value: syntax.Type | None,
        fields: tuple[Any, ...],
        line: int,
    ) -> syntax.Type | None:
        """Build the type of a line from what is written on it and the fields under it."""
        if value is None:
            # nothing after the colon: a struct, or nothing at all
            return self.struct(fields, line) if fields else None
        words = _structs(value)
        if words > 1:
            message = "a line has one 'struct', since one block of fields follows it"
            self.report.error(f"{message}: name the others with '$'", line)
        elif fields and not words:
            self.report.error(f"these fields belong to no struct: '{value}' holds none", line)
        return self.expand(value, fields, line)

    def expand(self, value: syntax.Type, fields: tuple[Any, ...], line: int) -> syntax.Type:
        match value:
            case syntax.Reference():
                return self.expand_reference(value)
            case syntax.List(element=el):
                return replace(value, element=self.expand(el, fields, line))
            case syntax.Tuple(elements=els):
                return replace(value, elements=tuple(self.expand(e, fields, line) for e in els))
            case syntax.Union(members=members):
                return replace(value, members=tuple(self.expand(m, fields, line) for m in members))
            case syntax.Struct():
                return replace(self.struct(fields, line), attributes=value.attributes)
        return value

    def struct(self, fields: tuple[Any, ...], line: int) -> syntax.Struct:
        """A struct from the fields of a block: a pasted struct adds its own fields."""
        entries: dict[str, syntax.Entry] = {}
        own: dict[str, int] = {}
        for item in fields:
            if isinstance(item, syntax.Paste):
                pasted = self.type_of(item.name, item.line)
                if isinstance(pasted, syntax.Struct):
                    entries.update((e.name, e) for e in pasted.entries)
                elif item.name in self.definitions and pasted is not rules.ANY:
                    self.report.error(f"'${item.name}' is a type, not a struct", item.line)
            elif not isinstance(item, syntax.Field):
                continue
            elif item.name in own:
                message = f"'{item.name}' is already declared on line {own[item.name]}"
                self.report.error(message, item.line)
            else:
                own[item.name] = item.line
                entries[item.name] = self.entry(item)
        return syntax.Struct(entries=tuple(entries.values()), line=line)

    def entry(self, item: syntax.Field) -> syntax.Entry:
        built = self.resolve(item.type, item.fields, item.line)
        return syntax.Entry(
            name=item.name,
            type=built or rules.ANY,
            optional=item.optional,
            description=item.description or self.alias_description(item.type),
            line=item.line,
        )

    def alias_description(self, value: syntax.Type | None) -> str | None:
        """The doc a line or a field takes from the type it uses when it has none."""
        if not isinstance(value, syntax.Reference):
            return None
        definition = self.definitions.get(value.name)
        return definition.description if definition else None

    def expand_reference(self, reference: syntax.Reference) -> syntax.Type:
        name, line = reference.name, reference.line
        resolved = self.type_of(name, line)
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

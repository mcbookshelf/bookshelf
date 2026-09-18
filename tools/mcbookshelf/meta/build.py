import re
import warnings
from collections.abc import Iterable
from dataclasses import dataclass, field, replace
from datetime import datetime
from pathlib import Path
from typing import NoReturn

from mcbookshelf import constants

from . import models, syntax
from .errors import MetadataError, MetadataWarning, locate
from .syntax import Kind, PrimitiveKind

STAMP = re.compile(r"^(\d{4}/\d{2}/\d{2}) (\S+)$")
SLUG = re.compile(r"^[a-z][a-z0-9-]*$")
VERSION = re.compile(r"^\d+\.\d+\.\d+$")
INDEX_URL = f"{constants.DOCS_PAGES_URL}/index.html"

BUNDLE_REQUIRED = ("name", "slug", "version", "tags")
MODULE_REQUIRED = ("name", "slug", "version")
FEATURE_REQUIRED = ("authors", "created", "updated")

ROOTS = {models.Role.INPUT: "in", models.Role.OUTPUT: "out"}

BUNDLE_KEYS = frozenset({"name", "slug", "version", "tags", "documentation"})

MODULE_KEYS = frozenset({"name", "slug", "version", "documentation", "tags", "weak_dependencies"})

FEATURE_KEYS = frozenset({"authors", "created", "updated", "deprecated", "experimental"})

KINDS = {
    models.Role.CONTEXT: frozenset({
        Kind.EXECUTOR, Kind.POSITION, Kind.ROTATION, Kind.DIMENSION, Kind.STATE,
    }),
    models.Role.INPUT: frozenset({Kind.MACRO, Kind.STATE}),
    models.Role.OUTPUT: frozenset({Kind.STATE, Kind.RESULT, Kind.SUCCESS}),
}

ENTITY = frozenset({PrimitiveKind.PLAYER, PrimitiveKind.ENTITY})

DIMENSIONS = frozenset({
    PrimitiveKind.OVERWORLD, PrimitiveKind.NETHER, PrimitiveKind.END, PrimitiveKind.ANY,
})

NUMBERS = frozenset({
    PrimitiveKind.BYTE, PrimitiveKind.SHORT, PrimitiveKind.INT, PrimitiveKind.LONG,
    PrimitiveKind.FLOAT, PrimitiveKind.DOUBLE, PrimitiveKind.NUMBER,
})

CONTEXT_ONLY = (ENTITY | DIMENSIONS | {PrimitiveKind.XY, PrimitiveKind.XYZ}) - {PrimitiveKind.ANY}

ACCEPTED: dict[Kind, tuple[frozenset[PrimitiveKind], bool]] = {
    Kind.EXECUTOR: (ENTITY, True),
    Kind.POSITION: (ENTITY | {PrimitiveKind.XYZ}, False),
    Kind.ROTATION: (ENTITY | {PrimitiveKind.XY}, False),
    Kind.DIMENSION: (DIMENSIONS, False),
    Kind.RESULT: (NUMBERS, False),
    Kind.SUCCESS: (NUMBERS, False),
}


def build_module(
    document: syntax.Module, directory: str, file: Path | None = None,
) -> models.Module:
    """Build a module model from a parsed document."""
    return _Builder(directory, file).module(document)


def build_bundle(
    document: syntax.Module, directory: str, file: Path | None = None,
) -> models.Bundle:
    """Build a bundle model from a parsed document."""
    return _Builder(directory, file).bundle(document)


def _feature_name(node: syntax.Feature) -> str:
    """The name of a feature, written with or without the namespace of the module."""
    return node.id.partition(":")[2] or node.id


def _anchor(name: str, kind: str, *, shared: bool) -> str:
    """The anchor of a feature in the docs: its name, plus its kind when the name is shared."""
    anchor = name.replace("/", "-").replace("_", "-")
    return f"{anchor}-{kind.replace('/', '-')}" if shared else anchor


def _module_url(namespace: str) -> str:
    short = namespace[3:]
    return f"{constants.DOCS_PAGES_URL}/modules/{short}.html"


@dataclass
class _Builder:
    """Build the models of one file, gathering its storages and the variables it uses."""

    id: str
    file: Path | None
    storages: dict[str, models.Storage] = field(default_factory=dict)
    variables: dict[str, syntax.Variable] = field(default_factory=dict)
    used: set[str] = field(default_factory=set)

    def fail(self, message: str, line: int) -> NoReturn:
        raise MetadataError(message, file=self.file, line=line)

    def warn(self, message: str, line: int) -> None:
        warning = MetadataWarning(f"{locate(self.file, line)}: {message}")
        warnings.warn(warning, stacklevel=2)

    def bundle(self, document: syntax.Module) -> models.Bundle:
        if document.features:
            self.fail("a bundle declares no feature", document.features[0].line)
        if document.variables:
            self.fail("a bundle declares no variable", document.variables[0].line)
        if document.description is None:
            self.fail("missing description: write it with '>' on the first line", 1)
        values = self.properties(document.properties, BUNDLE_KEYS, BUNDLE_REQUIRED, 1)
        return models.Bundle(
            id=self.id,
            name=values["name"],
            slug=values["slug"],
            version=values["version"],
            description=document.description,
            documentation=values.get("documentation", INDEX_URL),
            tags=self.split(values["tags"]),
        )

    def module(self, document: syntax.Module) -> models.Module:
        values = self.properties(document.properties, MODULE_KEYS, MODULE_REQUIRED, 1)
        if document.description is None:
            self.fail("missing description: write it with '>' on the first line", 1)
        self.variables = self.declared(document.variables)
        documentation = values.get("documentation", _module_url(self.id))

        names = [_feature_name(node) for node in document.features]
        features: list[models.Feature] = []
        seen: dict[tuple[str, str], models.Feature] = {}
        for node in document.features:
            shared = names.count(_feature_name(node)) > 1
            feature = self.feature(node, documentation, shared=shared)
            key = (feature.kind, feature.name)
            if key in seen:
                declared = f"{feature.kind} {feature.name} is already declared"
                self.fail(f"{declared} on line {seen[key].line}", node.line)
            seen[key] = feature
            features.append(feature)
        self.finish_variables(document.variables)

        return models.Module(
            id=self.id,
            name=values["name"],
            slug=values["slug"],
            version=values["version"],
            description=document.description,
            documentation=documentation,
            tags=self.split(values.get("tags", "")),
            weak_dependencies=self.split(values.get("weak_dependencies", "")),
            features=tuple(features),
            storages=dict(sorted(self.storages.items())),
        )

    def feature(self, node: syntax.Feature, documentation: str, *, shared: bool) -> models.Feature:
        namespace, sep, _ = node.id.partition(":")
        if sep and namespace != self.id:
            self.fail(f"'{node.id}' is not in the namespace of the module", node.line)
        name = _feature_name(node)
        if name.startswith("__"):
            self.fail("a feature id cannot start with '__'", node.line)
        properties = node.properties
        values = self.properties(properties, FEATURE_KEYS, FEATURE_REQUIRED, node.line)
        created = self.stamp(values["created"], properties["created"].line)
        updated = self.stamp(values["updated"], properties["updated"].line)
        if updated.date < created.date:
            message = f"updated on {updated.date}, before created on {created.date}"
            self.fail(message, properties["updated"].line)

        local = tuple(s for s in node.slots if isinstance(s, syntax.Variable))
        scope = {**self.variables, **self.declared(local)}
        slots = tuple(
            self.slot(slot, name, scope)
            for slot in node.slots
            if isinstance(slot, syntax.Input | syntax.Context | syntax.Output)
        )
        self.finish_variables(local)

        kind = models.REGISTRIES.get(node.registry, node.registry)
        anchor = _anchor(name, kind, shared=shared)
        return models.Feature(
            kind=kind,
            name=name,
            description=node.description,
            documentation=f"{documentation}#{anchor}",
            anchor=anchor,
            authors=self.split(values["authors"]),
            created=created,
            updated=updated,
            slots=slots,
            line=node.line,
            deprecated=values.get("deprecated") == "true",
            experimental=values.get("experimental") == "true",
        )

    def stamp(self, value: str, line: int) -> models.Stamp:
        match = STAMP.match(value)
        if match is None:
            self.fail(f"'{value}' is not a date and a Minecraft version, '2022/04/14 1.18.2'", line)
        try:
            datetime.strptime(match[1], "%Y/%m/%d")  # noqa: DTZ007
        except ValueError:
            self.fail(f"'{match[1]}' is not an existing date", line)
        return models.Stamp(date=match[1], minecraft_version=match[2])

    def declared(self, nodes: tuple[syntax.Variable, ...]) -> dict[str, syntax.Variable]:
        """Map variables by name, refusing a name declared twice."""
        variables: dict[str, syntax.Variable] = {}
        for node in nodes:
            if node.name in variables:
                previous = variables[node.name].line
                self.fail(f"'{node.name}' is already declared on line {previous}", node.line)
            variables[node.name] = node
        return variables

    def finish_variables(self, nodes: tuple[syntax.Variable, ...]) -> None:
        """Warn about variables no slot used; a storage they name is still declared."""
        for node in nodes:
            if node.name in self.used:
                continue
            self.warn(f"'{node.name}' is never referenced", node.line)
            storage = node.declaration.kind
            if isinstance(storage, syntax.Storage) and storage.id and storage.path:
                self.check_namespace(storage.id, node.line)
                target = models.Target(storage.id, tuple(storage.path.split("/")))
                self.check_data(node.declaration.type, node.line)
                self.add_storage(target, node.declaration.type, node.line)

    def properties(
        self,
        properties: dict[str, syntax.Property],
        allowed: frozenset[str],
        required: Iterable[str],
        line: int,
    ) -> dict[str, str]:
        """Read the properties of a head or a feature, checking each one known."""
        values: dict[str, str] = {}
        for key, node in properties.items():
            if key == "description":
                self.fail("write the description with '>' instead", node.line)
            if key not in allowed:
                self.fail(f"unknown property '{key}'", node.line)
            if not node.value:
                self.fail(f"'{key}' needs a value", node.line)
            values[key] = node.value
        for key in required:
            if key not in values:
                self.fail(f"missing property '{key}'", line)
        for key, value in values.items():
            self.check_property(key, value, properties[key].line)
        return values

    def check_property(self, key: str, value: str, line: int) -> None:
        match key:
            case "slug":
                self.check_slug(value, line)
            case "version":
                self.check_version(value, line)
            case "tags":
                self.check_tags(value, line)
            case "deprecated" | "experimental":
                self.check_flag(value, line)

    def check_slug(self, value: str, line: int) -> None:
        if not SLUG.match(value):
            self.fail(f"'{value}' is not a slug: lowercase, digits, dashes", line)

    def check_version(self, value: str, line: int) -> None:
        if not VERSION.match(value):
            self.fail(f"'{value}' is not a version, as in '5.0.0'", line)

    def check_tags(self, value: str, line: int) -> None:
        for tag in self.split(value):
            if tag != "*" and not SLUG.match(tag):
                self.fail(f"'{tag}' is not a tag: lowercase, digits, dashes", line)

    def check_flag(self, value: str, line: int) -> None:
        if value not in ("true", "false"):
            self.fail(f"'{value}' is not 'true' or 'false'", line)

    def slot(
        self,
        node: syntax.Input | syntax.Context | syntax.Output,
        feature: str,
        scope: dict[str, syntax.Variable],
    ) -> models.Slot:
        match node:
            case syntax.Context():
                role = models.Role.CONTEXT
            case syntax.Input():
                role = models.Role.INPUT
            case syntax.Output():
                role = models.Role.OUTPUT
        value = node.value
        description = value.description
        if isinstance(value, syntax.Reference):
            variable = scope.get(value.name)
            if variable is None:
                self.fail(f"unknown variable '{value.name}'", value.line)
            self.used.add(value.name)
            description = description or variable.declaration.description
            declaration = variable.declaration
        else:
            declaration = value

        kind = declaration.kind
        if isinstance(kind, syntax.Storage):
            if role is models.Role.CONTEXT:
                self.fail("a context cannot be a storage", node.line)
            target = self.target(kind, feature, role, node.line)
            self.check_data(declaration.type, node.line)
            self.add_storage(target, declaration.type, node.line)
            return models.Slot(role, None, target, declaration.type, description, node.line)

        if kind not in KINDS[role]:
            self.fail(f"'{kind}' is not allowed as {role}", node.line)
        self.check_kind(kind, declaration.type, node.line)
        return models.Slot(role, kind, None, declaration.type, description, node.line)

    def add_storage(self, target: models.Target, value: syntax.Type | None, line: int) -> None:
        """Record what a slot writes at a target, merged with the rest of that storage."""
        if value is None:
            self.fail("a storage needs a type", line)
        *parents, name = target.keys
        entry = syntax.Entry(name=name, type=value, optional=True, line=line)
        for parent in reversed(parents):
            struct = syntax.Struct(entries=(entry,), line=line)
            entry = syntax.Entry(name=parent, type=struct, optional=True, line=line)
        declared = syntax.Struct(entries=(entry,), line=line)
        storage = self.storages.get(target.id)
        if storage is None:
            self.storages[target.id] = models.Storage(target.id, declared)
        else:
            merged = self.merge(storage.struct, declared, target.id)
            self.storages[target.id] = replace(storage, struct=merged)

    def target(
        self, storage: syntax.Storage, feature: str, role: models.Role, line: int,
    ) -> models.Target:
        """The place a storage slot writes: the feature id under `in` or `out` by default."""
        id_ = storage.id or f"{self.id}:{feature}"
        self.check_namespace(id_, line)
        keys = tuple(storage.path.split("/")) if storage.path else (ROOTS[role],)
        return models.Target(id=id_, keys=keys)

    def merge(self, first: syntax.Struct, second: syntax.Struct, id_: str) -> syntax.Struct:
        """Merge two declarations of a storage, refusing an entry typed twice differently."""
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
                merged = self.merge(previous.type, entry.type, id_)
                entries[index] = replace(previous, type=merged)
            elif str(previous.type) != str(entry.type):
                self.fail(
                    f"'{entry.name}' of storage {id_} is already declared "
                    f"as '{previous.type}' on line {previous.line}",
                    entry.line,
                )
        return syntax.Struct(entries=tuple(entries), line=first.line)

    def check_namespace(self, id_: str, line: int) -> None:
        if id_.partition(":")[0] != self.id:
            self.fail(f"'{id_}' is not in the namespace of the module", line)

    def check_kind(self, kind: Kind, value: syntax.Type | None, line: int) -> None:
        """Check the type a slot of some kind takes: none for a state, a struct for a macro."""
        if kind is Kind.STATE:
            if value is not None:
                self.fail("a state carries no type", line)
            return
        if value is None:
            self.fail(f"'{kind}' needs a type", line)
        if kind is Kind.MACRO:
            if not isinstance(value, syntax.Struct):
                self.fail(f"'{value}' is not a type a macro takes", line)
            self.check_data(value, line)
            return
        accepted, arrays = ACCEPTED[kind]
        if not self.accepts(value, accepted, arrays=arrays):
            self.fail(f"'{value}' is not a type a {kind} takes", line)

    def check_data(self, value: syntax.Type | None, line: int) -> None:
        """Check a type that goes into a storage: no context type, arrays as Minecraft has them."""
        match value:
            case syntax.Primitive(kind=kind) if kind in CONTEXT_ONLY:
                self.fail(f"'{kind}' is not a data type", line)
            case syntax.Array(element=element):
                self.check_data(element, line)
                primitive = isinstance(element, syntax.Primitive)
                if not (primitive and element.kind.array):
                    self.fail(f"'{element}[]' is not a Minecraft array", line)
            case syntax.List(element=element):
                self.check_data(element, line)
            case syntax.Tuple(elements=elements) | syntax.Union(members=elements):
                for element in elements:
                    self.check_data(element, line)
            case syntax.Struct(entries=entries):
                for entry in entries:
                    self.check_data(entry.type, entry.line)

    @staticmethod
    def split(value: str) -> tuple[str, ...]:
        return tuple(part.strip() for part in value.split(",") if part.strip())

    @staticmethod
    def accepts(
        value: syntax.Type, kinds: frozenset[syntax.PrimitiveKind], *, arrays: bool = False,
    ) -> bool:
        match value:
            case syntax.Primitive(kind=kind):
                return kind in kinds
            case syntax.Array(element=element) if arrays:
                return _Builder.accepts(element, kinds)
            case syntax.Union(members=members):
                return all(_Builder.accepts(m, kinds, arrays=arrays) for m in members)
        return False

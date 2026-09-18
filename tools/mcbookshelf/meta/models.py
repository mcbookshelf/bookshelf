from dataclasses import dataclass
from enum import StrEnum

from mcbookshelf import constants

from . import syntax

type Version = tuple[int, int, int]

REGISTRIES = {
    "function": "tags/function",
    "function_tag": "tags/function",
    "block_tag": "tags/block",
    "entity_type_tag": "tags/entity_type",
}


class Role(StrEnum):

    CONTEXT = "context"
    INPUT = "input"
    OUTPUT = "output"


@dataclass(frozen=True, slots=True)
class Stamp:

    date: str
    minecraft_version: str


@dataclass(frozen=True, slots=True)
class Bundle:

    id: str
    name: str
    slug: str
    version: str
    description: str
    documentation: str
    tags: tuple[str, ...]

    @property
    def short(self) -> str:
        return self.id[4:]

    @property
    def suite(self) -> bool:
        return "*" in self.tags


@dataclass(frozen=True, slots=True)
class Module:

    id: str
    name: str
    slug: str
    version: str
    description: str
    documentation: str
    tags: tuple[str, ...]
    weak_dependencies: tuple[str, ...]
    features: tuple[Feature, ...]
    storages: dict[str, Storage]

    @property
    def short(self) -> str:
        return self.id[3:]

    @property
    def names(self) -> set[str]:
        return {f.name for f in self.features}

    @property
    def functions(self) -> tuple[Feature, ...]:
        return tuple(f for f in self.features if f.kind == "tags/function")

    @property
    def released(self) -> bool:
        return parse_version(self.version) >= (1, 0, 0)

    @property
    def experimental(self) -> set[str]:
        return {f.name for f in self.features if f.experimental}

    def find(self, name: str, kind: str | None = None) -> Feature:
        """Find a feature by name, and by kind when several share the name."""
        kind = REGISTRIES.get(kind, kind) if kind else None
        matches = [f for f in self.features if f.name == name and kind in (None, f.kind)]
        if len(matches) == 1:
            return matches[0]
        kinds = ", ".join(f.kind for f in self.features if f.name == name)
        if not matches:
            declared = f" of kind '{kind}' (declared: {kinds})" if kinds else ""
            raise LookupError(f"No feature '{name}' in {self.id}/module.bs{declared}")
        raise LookupError(
            f"'{name}' names several features of {self.id} ({kinds}): "
            "write the kind first, as in `predicate bs.x:id`",
        )


@dataclass(frozen=True, slots=True)
class Feature:

    kind: str
    name: str
    description: str | None
    documentation: str
    anchor: str
    authors: tuple[str, ...]
    created: Stamp
    updated: Stamp
    slots: tuple[Slot, ...]
    line: int
    deprecated: bool = False
    experimental: bool = False

    def of(self, role: Role) -> tuple[Slot, ...]:
        return tuple(s for s in self.slots if s.role is role)

    @property
    def is_tag(self) -> bool:
        return self.kind.startswith("tags/")

    @property
    def inputs(self) -> tuple[Slot, ...]:
        return self.of(Role.INPUT)

    @property
    def input_storage(self) -> Slot | None:
        return next((s for s in self.inputs if s.target is not None), None)

    @property
    def input_macro(self) -> Slot | None:
        return next((s for s in self.inputs if s.kind is syntax.Kind.MACRO), None)

    @property
    def macro_struct(self) -> syntax.Struct | None:
        if slot := self.input_macro:
            return slot.type if isinstance(slot.type, syntax.Struct) else None
        if self.kind != "tags/function":
            return None
        if (slot := self.input_storage) and isinstance(slot.type, syntax.Struct):
            return derive_macro(slot.type)
        return None


@dataclass(frozen=True, slots=True)
class Storage:

    id: str
    struct: syntax.Struct


@dataclass(frozen=True, slots=True)
class Slot:

    role: Role
    kind: syntax.Kind | None
    target: Target | None
    type: syntax.Type | None
    description: str | None
    line: int


@dataclass(frozen=True, slots=True)
class Target:

    id: str
    keys: tuple[str, ...]

    @property
    def display(self) -> str:
        return f"{self.id} {'.'.join(self.keys)}"


def parse_version(text: str) -> Version:
    major, minor, patch = (int(p) for p in text.split("."))
    return major, minor, patch


def feature_id(module: Module, feature: Feature, *, macro: bool = False) -> str:
    tag = "#" if feature.is_tag else ""
    return f"{tag}{module.id}:{feature.name}{constants.MACRO_SUFFIX if macro else ''}"


def is_string(value: syntax.Type) -> bool:
    if isinstance(value, syntax.Primitive):
        return value.kind is syntax.PrimitiveKind.STRING
    if isinstance(value, syntax.Union):
        return any(is_string(m) for m in value.members)
    return False


def derive_macro(struct: syntax.Struct) -> syntax.Struct:
    required = tuple(e for e in struct.entries if not e.optional)
    optional = tuple(
        syntax.Entry(name=e.name, type=e.type, description=e.description, line=e.line)
        for e in struct.entries
        if e.optional
    )
    if not optional:
        return syntax.Struct(entries=required, line=struct.line)
    with_entry = syntax.Entry(
        name="with",
        type=syntax.Struct(entries=optional, line=struct.line),
        optional=True,
        description="optional arguments",
        line=struct.line,
    )
    return syntax.Struct(entries=(*required, with_entry), line=struct.line)

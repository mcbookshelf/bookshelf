from dataclasses import dataclass
from functools import cached_property

from mcbookshelf import constants
from mcbookshelf.version import Version

from . import syntax
from .rules import REGISTRIES
from .syntax import Role


@dataclass(frozen=True, slots=True)
class Stamp:

    date: str
    minecraft_version: str


@dataclass(frozen=True, slots=True)
class Storage:

    id: str
    struct: syntax.Struct


@dataclass(frozen=True, slots=True)
class Slot:

    role: Role
    kind: syntax.Kind
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


@dataclass(frozen=True)
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
        return short(self.id)

    @cached_property
    def names(self) -> frozenset[str]:
        return frozenset(f.name for f in self.features)

    @cached_property
    def functions(self) -> tuple[Feature, ...]:
        return tuple(f for f in self.features if f.resource == "tags/function")

    @property
    def released(self) -> bool:
        return Version.parse(self.version) >= (1, 0, 0)

    @cached_property
    def experimental(self) -> frozenset[str]:
        return frozenset(f.name for f in self.features if f.experimental)

    def find(self, name: str, resource: str | None = None) -> Feature:
        """Find a feature by name, and by resource when several share the same name."""
        resource = REGISTRIES[resource].resource if resource in REGISTRIES else resource
        found = [f for f in self.features if f.name == name and resource in (None, f.resource)]

        if len(found) == 1:
            return found[0]

        kinds = ", ".join(f.resource for f in self.features if f.name == name)

        if not found:
            declared = f" of kind '{resource}' (declared: {kinds})" if kinds else ""
            raise LookupError(f"No feature '{name}' in {self.id}/module.bs{declared}")

        raise LookupError(
            f"'{name}' names several features of {self.id} ({kinds}): "
            "write the kind first, as in `predicate bs.foo:bar`",
        )


@dataclass(frozen=True, slots=True)
class Feature:

    module: str
    resource: str
    name: str
    description: str | None
    documentation: str
    anchor: str
    authors: tuple[str, ...]
    contributors: tuple[str, ...]
    created: Stamp
    updated: Stamp
    slots: tuple[Slot, ...]
    line: int
    deprecated: bool = False
    experimental: bool = False

    def of(self, role: Role) -> tuple[Slot, ...]:
        return tuple(s for s in self.slots if s.role is role)

    @property
    def tag(self) -> bool:
        return self.resource.startswith("tags/")

    @property
    def id(self) -> str:
        return f"{'#' if self.tag else ''}{self.module}:{self.name}"

    @property
    def macro_id(self) -> str:
        return f"{self.id}{constants.MACRO_SUFFIX}"

    @property
    def aliases(self) -> tuple[str, ...]:
        """The other ids the feature answers to: its macro form, when it takes one."""
        return (self.macro_id,) if self.macro_struct else ()

    @property
    def inputs(self) -> tuple[Slot, ...]:
        return self.of(Role.INPUT)

    @property
    def macro(self) -> Slot | None:
        return next((s for s in self.inputs if s.kind is syntax.Kind.MACRO), None)

    @property
    def arguments(self) -> Slot | None:
        return next((s for s in self.inputs if s.kind is syntax.Kind.ARGUMENTS), None)

    @property
    def macro_struct(self) -> syntax.Struct | None:
        if (slot := self.macro) and isinstance(slot.type, syntax.Struct):
            return slot.type
        if (slot := self.arguments) and isinstance(slot.type, syntax.Struct):
            return _derive_macro(slot.type)
        return None


def short(module_id: str) -> str:
    """A module id without its `bs.` namespace."""
    return module_id[3:]


def _derive_macro(struct: syntax.Struct) -> syntax.Struct:
    required = tuple(e for e in struct.entries if not e.optional)
    if optional := tuple(
        syntax.Entry(name=e.name, type=e.type, description=e.description, line=e.line)
        for e in struct.entries
        if e.optional
    ):
        with_ = syntax.Entry(
            name="with",
            type=syntax.Struct(entries=optional, line=struct.line),
            description="optional arguments, `{}` for none",
            line=struct.line,
        )
        return syntax.Struct(entries=(*required, with_), line=struct.line)

    return syntax.Struct(entries=required, line=struct.line)

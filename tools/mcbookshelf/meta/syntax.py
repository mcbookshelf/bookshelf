from dataclasses import dataclass, field, replace
from enum import StrEnum

type Type = Primitive | Array | List | Tuple | Struct | Union | Reference
type Line = Metadata | Slot | Paste
type Member = Field | Paste


def attributed(attributes: tuple[str, ...]) -> str:
    """Write attributes as a prefix: `#[id="block"] `, or nothing."""
    return "".join(f"{a} " for a in attributes)


def bounded(bounds: Range | None) -> str:
    """Write a range as a suffix: ` @ 0..9`, or nothing."""
    return "" if bounds is None else f" @ {bounds}"


class Role(StrEnum):
    """What a line of a feature is: a context is written `@executor`, the others by their role."""

    CONTEXT = "context"
    INPUT = "input"
    OUTPUT = "output"


class Kind(StrEnum):

    EXECUTOR = "executor"
    POSITION = "position"
    ROTATION = "rotation"
    DIMENSION = "dimension"
    ARGUMENTS = "arguments"
    STORAGE = "storage"
    MACRO = "macro"
    STATE = "state"
    RESULT = "result"
    SUCCESS = "success"


class PrimitiveKind(StrEnum):

    ANY = "any"
    BOOLEAN = "boolean"
    BYTE = "byte"
    DOUBLE = "double"
    FLOAT = "float"
    INT = "int"
    LONG = "long"
    NUMBER = "number"
    SHORT = "short"
    STRING = "string"
    OVERWORLD = "overworld"
    NETHER = "nether"
    END = "end"
    ENTITY = "entity"
    PLAYER = "player"
    XY = "xy"
    XYZ = "xyz"


@dataclass(frozen=True, slots=True, kw_only=True)
class Node:

    line: int = field(default=0, compare=False)


@dataclass(frozen=True, slots=True, kw_only=True)
class Property(Node):

    key: str
    value: str


@dataclass(frozen=True, slots=True, kw_only=True)
class Metadata(Node):
    """A metadata line, in the head or in a feature: a flag has no value."""

    key: str
    value: str | None = None


@dataclass(frozen=True, slots=True, kw_only=True)
class Paste(Node):
    """A `$name` alone on its line: the lines or the fields of that definition."""

    name: str


@dataclass(frozen=True, slots=True, kw_only=True)
class Field(Node):
    """A field as written: the fields under it are the ones of the `struct` in its type."""

    name: str
    type: Type
    optional: bool = False
    description: str | None = None
    fields: tuple[Member, ...] = ()


@dataclass(frozen=True, slots=True, kw_only=True)
class Definition(Node):
    """A `$name`: a type, with the fields under it as its body, or feature lines."""

    name: str
    type: Type | None = None
    description: str | None = None
    body: tuple[Line | Member, ...] = ()


@dataclass(frozen=True, slots=True, kw_only=True)
class Items(Node):
    """Some items of a list, `$name[a, b]`, with the properties they share."""

    name: str
    items: tuple[str, ...]
    properties: tuple[Property, ...] = ()


@dataclass(frozen=True, slots=True, kw_only=True)
class Reference(Node):

    name: str
    attributes: tuple[str, ...] = ()

    def __str__(self) -> str:
        return f"{attributed(self.attributes)}${self.name}"


@dataclass(frozen=True, slots=True, kw_only=True)
class Slot(Node):
    """A context, an input or an output as written."""

    role: Role
    kind: Kind
    type: Type | None = None
    storage: Storage | None = None
    description: str | None = None
    fields: tuple[Member, ...] = ()


@dataclass(frozen=True, slots=True, kw_only=True)
class Storage(Node):

    id: str | None = None
    path: str | None = None


@dataclass(frozen=True, slots=True, kw_only=True)
class Primitive(Node):

    kind: PrimitiveKind
    range: Range | None = None
    attributes: tuple[str, ...] = ()

    def __str__(self) -> str:
        return f"{attributed(self.attributes)}{self.kind}{bounded(self.range)}"


@dataclass(frozen=True, slots=True, kw_only=True)
class Array(Node):

    element: Primitive
    size: Range | None = None
    attributes: tuple[str, ...] = ()

    def __str__(self) -> str:
        return f"{attributed(self.attributes)}{self.element}[]{bounded(self.size)}"


@dataclass(frozen=True, slots=True, kw_only=True)
class List(Node):

    element: Type
    size: Range | None = None
    attributes: tuple[str, ...] = ()

    def __str__(self) -> str:
        return f"{attributed(self.attributes)}[{self.element}]{bounded(self.size)}"


@dataclass(frozen=True, slots=True, kw_only=True)
class Tuple(Node):

    elements: tuple[Type, ...]
    attributes: tuple[str, ...] = ()

    def __str__(self) -> str:
        return f"{attributed(self.attributes)}[{', '.join(str(e) for e in self.elements)}]"


@dataclass(frozen=True, slots=True, kw_only=True)
class Struct(Node):
    """As written, the word `struct`: the builder gives it the fields under its line."""

    entries: tuple[Entry, ...] = ()
    attributes: tuple[str, ...] = ()

    def __str__(self) -> str:
        inner = f" {{ {', '.join(str(e) for e in self.entries)} }}" if self.entries else ""
        return f"{attributed(self.attributes)}struct{inner}"


@dataclass(frozen=True, slots=True, kw_only=True)
class Entry(Node):
    """A field of a built struct."""

    name: str
    type: Type
    optional: bool = False
    description: str | None = None

    def __str__(self) -> str:
        return f"{self.name}{'?' if self.optional else ''}: {self.type}"


@dataclass(frozen=True, slots=True, kw_only=True)
class Union(Node):

    members: tuple[Type, ...]

    def __str__(self) -> str:
        return " | ".join(str(m) for m in self.members)


@dataclass(frozen=True, slots=True, kw_only=True)
class Range(Node):

    min: int | float | None = None
    max: int | float | None = None
    operator: str = ".."

    @property
    def exact(self) -> bool:
        return self.operator == ".." and self.min is not None and self.min == self.max

    def __str__(self) -> str:
        if self.exact:
            return str(self.min)
        low = "" if self.min is None else self.min
        high = "" if self.max is None else self.max
        return f"{low}{self.operator}{high}"


@dataclass(frozen=True, slots=True, kw_only=True)
class Feature(Node):

    registry: str
    id: str
    description: str | None = None
    lines: tuple[Line, ...] = ()


@dataclass(frozen=True, slots=True, kw_only=True)
class Module(Node):

    description: str | None = None
    lines: tuple[Property | Metadata | Definition | Items | Feature, ...] = ()

    @property
    def properties(self) -> tuple[Property, ...]:
        return tuple(s for s in self.lines if isinstance(s, Property))

    @property
    def metadata(self) -> tuple[Metadata, ...]:
        return tuple(s for s in self.lines if isinstance(s, Metadata))

    @property
    def definitions(self) -> tuple[Definition | Items, ...]:
        return tuple(s for s in self.lines if isinstance(s, Definition | Items))

    @property
    def features(self) -> tuple[Feature, ...]:
        return tuple(s for s in self.lines if isinstance(s, Feature))


def accepts(value: Type, accepted: tuple[Type, ...]) -> bool:
    """Whether a type is one of the accepted ones, or a union of them."""
    members = value.members if isinstance(value, Union) else (value,)
    return all(
        (replace(member, size=None) if isinstance(member, Array) else member) in accepted
        for member in members
    )


def is_string(value: Type) -> bool:
    """Whether a type is a string, or a union with a string in it."""
    if isinstance(value, Primitive):
        return value.kind is PrimitiveKind.STRING
    if isinstance(value, Union):
        return any(is_string(m) for m in value.members)
    return False

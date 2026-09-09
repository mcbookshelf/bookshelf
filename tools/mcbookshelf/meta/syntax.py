from dataclasses import dataclass, field
from enum import StrEnum

type Slot = Input | Context | Output | Variable | Property
type Type = Primitive | Array | List | Tuple | Struct | Union
type Value = Declaration | Reference


def bounded(bounds: Range | None) -> str:
    """Write a range as a suffix: ` @ 0..9`, or nothing."""
    return "" if bounds is None else f" @ {bounds}"


@dataclass(frozen=True, slots=True, kw_only=True)
class Node:

    line: int


class Kind(StrEnum):

    EXECUTOR = "executor"
    POSITION = "position"
    ROTATION = "rotation"
    DIMENSION = "dimension"
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

    @property
    def array(self) -> bool:
        return self in {PrimitiveKind.INT, PrimitiveKind.BYTE, PrimitiveKind.LONG}


@dataclass(frozen=True, slots=True, kw_only=True)
class Union(Node):

    members: tuple[Type, ...]

    def __str__(self) -> str:
        return " | ".join(str(m) for m in self.members)


@dataclass(frozen=True, slots=True, kw_only=True)
class Array(Node):

    element: Type
    size: Range | None = None

    def __str__(self) -> str:
        return f"{self.element}[]{bounded(self.size)}"


@dataclass(frozen=True, slots=True, kw_only=True)
class Primitive(Node):

    kind: PrimitiveKind
    range: Range | None = None

    def __str__(self) -> str:
        return f"{self.kind}{bounded(self.range)}"


@dataclass(frozen=True, slots=True, kw_only=True)
class List(Node):

    element: Type
    size: Range | None = None

    def __str__(self) -> str:
        return f"[{self.element}]{bounded(self.size)}"


@dataclass(frozen=True, slots=True, kw_only=True)
class Tuple(Node):

    elements: tuple[Type, ...]

    def __str__(self) -> str:
        return f"[{', '.join(str(e) for e in self.elements)}]"


@dataclass(frozen=True, slots=True, kw_only=True)
class Struct(Node):

    entries: tuple[Entry, ...]

    def __str__(self) -> str:
        return f"{{ {', '.join(str(e) for e in self.entries)} }}"


@dataclass(frozen=True, slots=True, kw_only=True)
class Entry(Node):

    name: str
    type: Type
    optional: bool = False
    description: str | None = None

    def __str__(self) -> str:
        return f"{self.name}{'?' if self.optional else ''}: {self.type}"


@dataclass(frozen=True, slots=True, kw_only=True)
class Range(Node):

    min: int | float | None = None
    max: int | float | None = None

    @property
    def exact(self) -> bool:
        return self.min is not None and self.min == self.max

    def __str__(self) -> str:
        if self.exact:
            return str(self.min)
        low = "" if self.min is None else self.min
        high = "" if self.max is None else self.max
        return f"{low}..{high}"


@dataclass(frozen=True, slots=True, kw_only=True)
class Storage(Node):

    id: str | None = None
    path: str | None = None


@dataclass(frozen=True, slots=True, kw_only=True)
class Declaration(Node):

    kind: Kind | Storage
    type: Type | None = None
    description: str | None = None


@dataclass(frozen=True, slots=True, kw_only=True)
class Reference(Node):

    name: str
    description: str | None = None


@dataclass(frozen=True, slots=True, kw_only=True)
class Context(Node):

    value: Value


@dataclass(frozen=True, slots=True, kw_only=True)
class Input(Node):

    value: Value


@dataclass(frozen=True, slots=True, kw_only=True)
class Output(Node):

    value: Value


@dataclass(frozen=True, slots=True, kw_only=True)
class Variable(Node):

    name: str
    declaration: Declaration


@dataclass(frozen=True, slots=True, kw_only=True)
class Property(Node):

    key: str
    value: str


@dataclass(frozen=True, slots=True, kw_only=True)
class Feature(Node):

    registry: str
    id: str
    description: str | None = None
    slots: tuple[Slot, ...] = ()

    @property
    def properties(self) -> dict[str, Property]:
        return {s.key: s for s in self.slots if isinstance(s, Property)}


@dataclass(frozen=True, slots=True, kw_only=True)
class Module(Node):

    description: str | None = None
    slots: tuple[Feature | Variable | Property, ...] = field(default=())

    @property
    def features(self) -> tuple[Feature, ...]:
        return tuple(s for s in self.slots if isinstance(s, Feature))

    @property
    def variables(self) -> tuple[Variable, ...]:
        return tuple(s for s in self.slots if isinstance(s, Variable))

    @property
    def properties(self) -> dict[str, Property]:
        return {s.key: s for s in self.slots if isinstance(s, Property)}

import re
from collections.abc import Callable
from dataclasses import dataclass
from datetime import datetime
from typing import Any

from .syntax import Array, Kind, Primitive, PrimitiveKind, Role

STAMP = re.compile(r"^(\d{4}/\d{2}/\d{2}) (\S+)$")
SLUG = re.compile(r"^[a-z][a-z0-9-]*$")
VERSION = re.compile(r"^\d+\.\d+\.\d+$")


@dataclass(frozen=True, slots=True)
class Field:
    """How a property reads: `parse` raises a ValueError on a bad value, which gets the default."""

    parse: Callable[[str], Any]
    required: bool = False
    default: Any = ""


def names(value: str) -> tuple[str, ...]:
    return tuple(part.strip() for part in value.split(",") if part.strip())


def slug(value: str) -> str:
    if not SLUG.match(value):
        raise ValueError(f"'{value}' is not a slug: lowercase, digits, dashes")
    return value


def version(value: str) -> str:
    if not VERSION.match(value):
        raise ValueError(f"'{value}' is not a version, as in '5.0.0'")
    return value


def tags(value: str) -> tuple[str, ...]:
    found = names(value)
    if bad := [tag for tag in found if tag != "*" and not SLUG.match(tag)]:
        listed = ", ".join(f"'{tag}'" for tag in bad)
        verb = "is not a tag" if len(bad) == 1 else "are not tags"
        raise ValueError(f"{listed} {verb}: lowercase, digits, dashes")
    return found


def boolean(value: str) -> bool:
    if value not in ("true", "false"):
        raise ValueError(f"'{value}' is not 'true' or 'false'")
    return value == "true"


def stamp(value: str) -> tuple[str, str]:
    """A date and the Minecraft version of that day, as in `2022/04/14 1.18.2`."""
    match = STAMP.match(value)
    if match is None:
        expected = "a date and a Minecraft version, '2022/04/14 1.18.2'"
        raise ValueError(f"'{value}' is not {expected}")
    try:
        datetime.strptime(match[1], "%Y/%m/%d")  # noqa: DTZ007
    except ValueError:
        raise ValueError(f"'{match[1]}' is not an existing date") from None
    return match[1], match[2]


BUNDLE_PROPERTIES = {
    "name": Field(str, required=True),
    "slug": Field(slug, required=True),
    "version": Field(version, required=True),
    "tags": Field(tags, required=True, default=()),
    "documentation": Field(str),
}

MODULE_PROPERTIES = {
    "name": Field(str, required=True),
    "slug": Field(slug, required=True),
    "version": Field(version, required=True),
    "documentation": Field(str),
    "tags": Field(tags, default=()),
    "weak_dependencies": Field(names, default=()),
}

FEATURE_PROPERTIES = {
    "authors": Field(names, required=True, default=()),
    "created": Field(stamp, required=True, default=("", "")),
    "updated": Field(stamp, required=True, default=("", "")),
    "contributors": Field(names, default=()),
    "deprecated": Field(boolean, default=False),
    "experimental": Field(boolean, default=False),
}


@dataclass(frozen=True, slots=True)
class Registry:

    resource: str
    contexts: frozenset[Kind] = frozenset()
    inputs: frozenset[Kind] = frozenset()
    outputs: frozenset[Kind] = frozenset()
    requires: Kind | None = None
    result: PrimitiveKind | None = None

    def allowed(self, role: Role) -> frozenset[Kind]:
        match role:
            case Role.CONTEXT:
                return self.contexts
            case Role.INPUT:
                return self.inputs
            case Role.OUTPUT:
                return self.outputs


UNTYPED = frozenset({Kind.STATE, Kind.SUCCESS})
STORAGES = frozenset({Kind.STORAGE, Kind.ARGUMENTS})
MACROS = frozenset({Kind.MACRO, Kind.ARGUMENTS})

ANY = Primitive(kind=PrimitiveKind.ANY)
ENTITY = Primitive(kind=PrimitiveKind.ENTITY)
PLAYER = Primitive(kind=PrimitiveKind.PLAYER)

CONTEXTS = frozenset({Kind.EXECUTOR, Kind.POSITION, Kind.ROTATION, Kind.DIMENSION, Kind.STATE})
INPUTS = frozenset({Kind.STATE, Kind.ARGUMENTS, Kind.MACRO, Kind.STORAGE})
OUTPUTS = frozenset({Kind.STATE, Kind.SUCCESS, Kind.RESULT, Kind.STORAGE})

CONTEXT_ONLY = frozenset({
    PrimitiveKind.ENTITY,
    PrimitiveKind.PLAYER,
    PrimitiveKind.XYZ,
    PrimitiveKind.XY,
    PrimitiveKind.OVERWORLD,
    PrimitiveKind.NETHER,
    PrimitiveKind.END,
})

CONTEXT_TYPES = {
    Kind.EXECUTOR: (Array(element=ENTITY), PLAYER, ENTITY, Array(element=PLAYER)),
    Kind.POSITION: (Primitive(kind=PrimitiveKind.XYZ), PLAYER, ENTITY),
    Kind.ROTATION: (Primitive(kind=PrimitiveKind.XY), PLAYER, ENTITY),
    Kind.DIMENSION: (
        ANY,
        Primitive(kind=PrimitiveKind.OVERWORLD),
        Primitive(kind=PrimitiveKind.NETHER),
        Primitive(kind=PrimitiveKind.END),
    ),
}

REGISTRIES = {
    "block_tag": Registry("tags/block"),
    "entity_type_tag": Registry("tags/entity_type"),
    "function": Registry(
        "tags/function",
        contexts=CONTEXTS,
        inputs=INPUTS,
        outputs=OUTPUTS,
        result=PrimitiveKind.INT,
    ),
    "predicate": Registry(
        "predicate",
        contexts=CONTEXTS,
        inputs=frozenset({Kind.STATE, Kind.STORAGE}),
        outputs=frozenset({Kind.SUCCESS}),
        requires=Kind.SUCCESS,
    ),
    "loot_table": Registry(
        "loot_table",
        contexts=CONTEXTS,
        inputs=frozenset({Kind.STATE, Kind.STORAGE}),
        outputs=frozenset({Kind.STATE}),
    ),
    "context_int_provider": Registry(
        "context_int_provider",
        contexts=CONTEXTS,
        inputs=frozenset({Kind.STATE, Kind.STORAGE}),
        outputs=frozenset({Kind.RESULT}),
        requires=Kind.RESULT,
        result=PrimitiveKind.INT,
    ),
    "context_float_provider": Registry(
        "context_float_provider",
        contexts=CONTEXTS,
        inputs=frozenset({Kind.STATE, Kind.STORAGE}),
        outputs=frozenset({Kind.RESULT}),
        requires=Kind.RESULT,
        result=PrimitiveKind.FLOAT,
    ),
}

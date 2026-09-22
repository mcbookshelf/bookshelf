import re
from dataclasses import dataclass

from .syntax import Array, Kind, Primitive, PrimitiveKind, Role

STAMP = re.compile(r"^(\d{4}/\d{2}/\d{2}) (\S+)$")
SLUG = re.compile(r"^[a-z][a-z0-9-]*$")
VERSION = re.compile(r"^\d+\.\d+\.\d+$")

BUNDLE_PROPERTIES = {
    "name": True,
    "slug": True,
    "version": True,
    "tags": True,
    "documentation": False,
}

MODULE_PROPERTIES = {
    "name": True,
    "slug": True,
    "version": True,
    "documentation": False,
    "tags": False,
    "weak_dependencies": False,
}

FEATURE_PROPERTIES = {
    "authors": True,
    "created": True,
    "updated": True,
    "contributors": False,
    "deprecated": False,
    "experimental": False,
}


@dataclass(frozen=True, slots=True)
class Registry:

    kind: str
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

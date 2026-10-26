from collections.abc import Callable, Iterable
from typing import Literal

from beet import Context, ContextIntProvider, EntityTypeTag, Predicate

from mcbookshelf.minecraft.condition import (
    Condition,
    component,
    entity_type,
    flag,
    gamemode,
    nbt,
)
from mcbookshelf.minecraft.entity import (
    MAX_CUBE_SIZE,
    Entity,
    by_trait,
    cube_size_provider,
    get_entities,
)
from mcbookshelf.minecraft.math import (
    Expression,
    btree,
    cond,
    const,
    first,
    fixed_target,
    ref,
    score,
)
from mcbookshelf.pipeline.plugins import Generated, generator

UNIT = 4000
COARSE = 10
FIELD = 1 << 15
MICRO = 1_000_000
PUBLIC = "bs.hitbox:get_entity"
PRIVATE = "bs.hitbox:_get_entity"

VARIANTS: dict[str, Callable[[Entity], bool]] = {
    "sized": lambda _: True,
    "solid": lambda e: e.collidable,
    "pushable": lambda e: e.pushable,
    "targetable": lambda e: e.pickable,
    "living": lambda e: e.living,
}

EXCEPTIONS: dict[str, dict[str, Condition]] = {
    "minecraft:player": {name: gamemode("survival", "creative", "adventure") for name in VARIANTS},
    "minecraft:happy_ghast": {"solid": flag("is_baby", value=False)},
}


@generator
def beet_default(ctx: Context) -> Generated:
    entities = get_entities(ctx.cache["minecraft"]).values()
    packed = dimensions(entities)
    empty = {entity_id for entity_id, value in packed.items() if value.json() == "0"}
    sized = [entity for entity in entities if entity.id not in empty]

    living = sorted(entity.id for entity in entities if entity.living)
    yield f"{PRIVATE}/living", EntityTypeTag({"values": living})
    tree = btree(sized, lambda e: packed[e.id], lambda found: entity_type(e.id for e in found))
    yield f"{PRIVATE}/dimensions", ContextIntProvider(tree.json())
    yield f"{PRIVATE}/cube_size", ContextIntProvider(cube_size_provider().json())
    yield f"{PRIVATE}/width", ContextIntProvider(unpack("width").json())
    yield f"{PRIVATE}/height", ContextIntProvider(unpack("height").json())

    for name, keep in VARIANTS.items():
        kept = {entity.id for entity in sized if keep(entity)}
        yield f"{PUBLIC}/{name}", Predicate(candidates(kept, name).json())


def candidates(kept: set[str], name: str) -> Condition:
    """The entities a variant returns a box for: its types, the exceptions only in their case."""
    cases = {key: c[name] for key, c in EXCEPTIONS.items() if key in kept and name in c}
    test = entity_type(kept - cases.keys())
    for entity_id, case in cases.items():
        test = test | (entity_type([entity_id]) & case)
    return test


def dimensions(entities: Iterable[Entity]) -> dict[str, Expression]:
    """The packed dimensions of each entity: its own for special ones, `default` for the others."""
    def registry(key: int) -> Callable[[Entity], Expression]:
        if not 0 < key < FIELD:
            raise ValueError(f"registry ids go from 1 to {FIELD - 1}, not {key}")
        return lambda _: const(key)

    def cube(step: float) -> Callable[[Entity], Expression]:
        coarse, rest = divmod(round(step * UNIT), COARSE)
        if rest or MAX_CUBE_SIZE * coarse >= FIELD:
            raise ValueError(f"a cube {step} blocks wide per size does not pack in coarse steps")
        value = ref(f"{PRIVATE}/cube_size", "int") * -(coarse * (FIELD + 1))
        return lambda _: value

    special = {
        "minecraft:area_effect_cloud": registry(1),
        "minecraft:armor_stand": registry(2),
        "minecraft:camel_husk": registry(3),
        "minecraft:camel": registry(3),
        "minecraft:goat": registry(4),
        "minecraft:interaction": registry(5),
        "minecraft:item_frame": registry(6),
        "minecraft:glow_item_frame": registry(6),
        "minecraft:mannequin": mannequin,
        "minecraft:painting": registry(7),
        "minecraft:phantom": registry(8),
        "minecraft:player": player,
        "minecraft:pufferfish": pufferfish,
        "minecraft:salmon": salmon,
        "minecraft:slime": cube(0.52),
        "minecraft:magma_cube": cube(0.52),
        "minecraft:sulfur_cube": cube(0.49),
    }
    return {entity.id: special.get(entity.id, default)(entity) for entity in entities}


def player(_: Entity) -> Expression:
    return first(
        (flag("is_sneaking"), pack(0.6, 1.5)),
        (flag("is_swimming") | flag("is_fall_flying"), pack(0.6, 0.6)),
        default=pack(0.6, 1.8),
    )


def mannequin(_: Entity) -> Expression:
    return first(
        (flag("is_sneaking"), pack(0.6, 1.5)),
        (nbt('{pose:"standing"}'), pack(0.6, 1.8)),
        default=pack(0.6, 0.6),
    )


def pufferfish(entity: Entity) -> Expression:
    test = lambda state: nbt(f"{{PuffState:{state}}}")  # noqa: E731
    return by_trait(entity, "puff_state", test, lambda found: pack(*found))


def salmon(entity: Entity) -> Expression:
    test = lambda name: component("minecraft:salmon/size", name)  # noqa: E731
    return by_trait(entity, "type", test, lambda found: pack(*found))


def default(entity: Entity) -> Expression:
    adult, baby = entity.ages()
    if adult == baby:
        return pack(*adult)
    return cond(Condition(f"{PRIVATE}/is_baby"), pack(*baby), pack(*adult))


def pack(width: float, height: float) -> Expression:
    """Width and height in steps of 1/UNIT blocks, or negated in COARSE steps."""
    w, h = round(width * UNIT), round(height * UNIT)
    if (w or not h) and w < FIELD and h < FIELD:
        return const(w * FIELD + h)
    if w % COARSE or h % COARSE or w // COARSE >= FIELD or h // COARSE >= FIELD:
        raise ValueError(f"{width} x {height} does not pack")
    return const(-(w // COARSE * FIELD + h // COARSE))


def unpack(field: Literal["width", "height"]) -> Expression:
    """The scaled width or height of the packed size in `#d bs.ctx`, in MICRO steps."""
    value = score("bs.ctx", fixed_target("#d"))
    steps = abs(value) // FIELD if field == "width" else abs(value) % FIELD
    micro = steps * cond(value.le(-1), MICRO * COARSE // UNIT, MICRO // UNIT)
    stored = score("bs.ctx", fixed_target("#s"))
    scale = cond(stored.ge(1), stored.to_float() / MICRO, 1.0)
    return (micro.to_float() * scale).round().to_int()

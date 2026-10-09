from collections.abc import Callable

from beet import Context, ContextFloatProvider, ContextIntProvider, Predicate

from mcbookshelf.minecraft import condition
from mcbookshelf.minecraft.math import (
    Expression,
    cond,
    fixed_target,
    float_storage,
    max_,
    min_,
    ref,
    score,
)
from mcbookshelf.pipeline.plugins import Generated, generator

BLOCK_BOXES = 24
ENTITY_BOXES = 8
MARGIN = 2**-16


@generator
def beet_default(_: Context) -> Generated:
    overlap = blocks(lambda box: entities(lambda entity: overlaps(entity, box)))
    yield "bs.hitbox:_is_in_block/inside", Predicate(blocks(contains).json())
    yield "bs.hitbox:_is_in_entity/inside", Predicate(entities(holds).json())
    yield "bs.hitbox:_overlaps/cube", Predicate(entities(in_cube).json())
    yield "bs.hitbox:_overlaps/overlap", Predicate(overlap.json())
    for axis, name in enumerate("xyz"):
        first, last = cells(axis)
        yield f"bs.hitbox:_overlaps/blocks/min_{name}", ContextIntProvider(first.json())
        yield f"bs.hitbox:_overlaps/blocks/max_{name}", ContextIntProvider(last.json())
        for entity in range(ENTITY_BOXES):
            start, end = span(entity, axis)
            yield cell_bound(entity, axis), ContextFloatProvider(start.json())
            yield cell_bound(entity, axis + 3), ContextFloatProvider(end.json())


def ctx(name: str) -> Expression:
    return score("bs.ctx", fixed_target(name))


def rel(axis: int) -> Expression:
    return float_storage("bs.hitbox:", f"rel[{axis}]")


def block_bound(box: int, index: int) -> Expression:
    return float_storage("bs.hitbox:get_block", f"out[{box}][{index}]")


def entity_bound(box: int, index: int) -> Expression:
    return float_storage("bs.hitbox:get_entity", f"out[{box}][{index}]")


def cell_bound(entity: int, index: int) -> str:
    """The provider of an entity box bound in the cell, named as in `out[entity][index]`."""
    return f"bs.hitbox:_overlaps/{entity}{index}"


def chain(count: str, size: int, test: Callable[[int], condition.Condition]) -> condition.Condition:
    """Whether one of the first boxes passes the test, stopping past the box count."""
    found = test(size - 1)
    for box in reversed(range(size - 1)):
        found = test(box) | (ctx(count).ge(box + 2) & found)
    return found


def blocks(test: Callable[[int], condition.Condition]) -> condition.Condition:
    """Whether a block output box passes the test, for `#n` boxes."""
    return chain("#n", BLOCK_BOXES, test)


def entities(test: Callable[[int], condition.Condition]) -> condition.Condition:
    """Whether an entity output box passes the test, for `#m` boxes."""
    return chain("#m", ENTITY_BOXES, test)


def contains(box: int) -> condition.Condition:
    """Whether the position in `#x`, `#y` and `#z`, in 2^-14 steps, is in the block box."""
    def check(axis: int) -> condition.Condition:
        steps = ctx(f"#{'xyz'[axis]}").floor_mod(16384)
        position = steps.to_float() / 16384 + 2**-15
        return position.between(block_bound(box, axis), block_bound(box, axis + 3))

    return condition.all_of(*(check(axis) for axis in range(3)))


def holds(box: int) -> condition.Condition:
    """Whether the entity box holds the position minus the entity in `rel`, faces included."""
    return condition.all_of(*(
        rel(axis).between(entity_bound(box, axis), entity_bound(box, axis + 3)) for axis in range(3)
    ))


def span(entity: int, axis: int) -> tuple[Expression, Expression]:
    """Where the entity box starts and ends in the cell `#i`, `#j` and `#k`, `rel` being cell 0."""
    corner = rel(axis) + ctx(f"#{'ijk'[axis]}").to_float()
    start = entity_bound(entity, axis) - corner
    end = entity_bound(entity, axis + 3) - corner
    return start + MARGIN, end - MARGIN


def within(
    entity: int, axis: int, low: Expression | float, high: Expression | float,
) -> condition.Condition:
    """Whether the entity box overlaps the range in the cell, the checks including their bound."""
    return ref(cell_bound(entity, axis)).le(high) & ref(cell_bound(entity, axis + 3)).ge(low)


def overlaps(entity: int, box: int) -> condition.Condition:
    """Whether the entity box overlaps the block box."""
    def check(axis: int) -> condition.Condition:
        return within(entity, axis, block_bound(box, axis), block_bound(box, axis + 3))

    return condition.all_of(*(check(axis) for axis in range(3)))


def in_cube(entity: int) -> condition.Condition:
    """Whether the entity box overlaps the unit cube of a full block."""
    return condition.all_of(*(within(entity, axis, 0.0, 1.0) for axis in range(3)))


def extreme(index: int, pick: Callable[..., Expression]) -> Expression:
    """The lowest or highest bound among the `#m` entity boxes."""
    value = entity_bound(ENTITY_BOXES - 1, index)
    for entity in reversed(range(ENTITY_BOXES - 1)):
        here = entity_bound(entity, index)
        value = cond(ctx("#m").ge(entity + 2), pick(here, value), here)
    return value


def cells(axis: int) -> tuple[Expression, Expression]:
    """The first and last cells the entity boxes reach, counted from the cell `rel` is for."""
    start = extreme(axis, min_) - rel(axis)
    end = extreme(axis + 3, max_) - rel(axis)
    return ((start + MARGIN).ceil() - 1).to_int(), (end - MARGIN).floor().to_int()

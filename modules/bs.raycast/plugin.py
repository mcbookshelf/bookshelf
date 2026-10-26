from collections.abc import Callable
from dataclasses import dataclass
from itertools import product

from beet import Context, ContextFloatProvider, ContextIntProvider

from mcbookshelf.minecraft.condition import Condition
from mcbookshelf.minecraft.math import (
    Expression,
    add,
    btree,
    cond,
    context_target,
    fixed_target,
    float_storage,
    max_,
    min_,
    ref,
    score,
)
from mcbookshelf.pipeline.plugins import Generated, generator

type Term = Callable[[int], Expression]

MISS = 2**31 - 1
BLOCK_BOXES = 24
ENTITY_BOXES = 8
FLAGS = 2**27
LONGEST = 2.0**25
JOIN = 19
MIRRORS = {
    "boxes": "_boxes",
    "octant": "_octant",
    "mask": "_pierce/mask",
    "shapes": "_pierce/shapes",
}
CONTEXT = {"boxes": "#b", "mask": "#m", "count": "#c", "limit": "#l"}


@dataclass(frozen=True)
class Boxes:
    """The boxes of a block or an entity, as bs.hitbox returns them."""

    kind: str
    storage: str
    size: int

    def bound(self, box: int, index: int) -> Expression:
        return float_storage(self.storage, f"out[{box}][{index}]")

    def flag(self, box: int) -> Expression:
        return self.bound(box, 6).to_int()

    def hit(self, box: int) -> Expression:
        """Entry * 64 + face axis * 16 + flag, or MISS when the ray does not cross the box."""
        return ref(f"bs.raycast:_{self.kind}/{box}", "int")

    def exit(self, box: int) -> Expression:
        return ref(f"bs.raycast:_pierce/{self.kind}/{box}", "int")

    def slab_id(self, box: int, axis: int, *, enter: bool, sign: str = "") -> str:
        return f"bs.raycast:_{self.kind}/{box}{('xyz' if enter else 'ijk')[axis]}{sign}"

    def fold(self, pick: Callable[..., Expression], term: Term, empty: int) -> Expression:
        return fold(pick, term, empty, ctx("boxes"), self.size)

    def first(self, value: Term) -> Expression:
        """The value of the first box left in the mask, the one on its highest bit."""
        bits = list(range(BLOCK_BOXES - self.size, BLOCK_BOXES))
        mask = ctx("mask")
        return btree(bits, lambda b: value(23 - b), lambda bs: mask.le(2 ** (max(bs) + 1) - 1))


BLOCK = Boxes("b", "bs.hitbox:get_block", BLOCK_BOXES)
ENTITY = Boxes("e", "bs.hitbox:get_entity", ENTITY_BOXES)


@generator
def beet_default(_: Context) -> Generated:
    yield from mirrors()
    for box in range(BLOCK_BOXES):
        yield from block_box(box)
    for box in range(ENTITY_BOXES):
        yield from entity_box(box)
    yield "bs.raycast:_e/hit", provider(ENTITY.fold(min_, ENTITY.hit, MISS))
    yield from cast()
    yield from sweep()
    for boxes in (BLOCK, ENTITY):
        yield from pierce(boxes)
    yield from pierce_block()
    yield from pierce_entity()


def mirrors() -> Generated:
    """The scores read the most, and the values of the ray as floats."""
    for name, mirror in MIRRORS.items():
        yield f"bs.raycast:{mirror}", provider(data(name))
    for name in ("lx", "ly", "lz", "dx", "dy", "dz", "max"):
        yield f"bs.raycast:_{name}", float_provider(data(name).to_float())
    for a in "xyz":
        yield f"bs.raycast:_o{a}", float_provider((ctx(f"e{a}") - ctx(a)).to_float() / 16384.0)
        yield f"bs.raycast:_p{a}", float_provider(ray(f"l{a}") - ray(f"d{a}"))


def block_box(box: int) -> Generated:
    """The slabs of a box of the block, by axis and sign, then its hit and exit for each octant."""
    for axis, sign, enter in product(range(3), (0, 1), (True, False)):
        slab = block_slab(box, axis, sign, enter=enter)
        yield BLOCK.slab_id(box, axis, enter=enter, sign="pn"[sign]), float_provider(slab)
    flag = BLOCK.flag(box)
    hits = octants(lambda o: hit(block_slabs(box, o), block_slabs(box, o, enter=False), flag))
    yield f"bs.raycast:_b/{box}", provider(hits)
    exits = octants(lambda o: min_(*block_slabs(box, o, enter=False)).to_int())
    yield f"bs.raycast:_pierce/b/{box}", provider(exits)


def entity_box(box: int) -> Generated:
    """The slabs of a box of the entity, then its hit and exit."""
    for axis, enter in product(range(3), (True, False)):
        slab = entity_slab(box, axis, enter=enter)
        yield ENTITY.slab_id(box, axis, enter=enter), float_provider(slab)
    left = entity_slabs(box, enter=False)
    yield f"bs.raycast:_e/{box}", provider(hit(entity_slabs(box), left, ENTITY.flag(box)))
    yield f"bs.raycast:_pierce/e/{box}", provider(min_(*left).to_int())


def cast() -> Generated:
    """The nearest box of the block, and the length the ray stops at."""
    yield "bs.raycast:_cast/hit", provider(BLOCK.fold(min_, BLOCK.hit, MISS))
    nearest = ref("bs.raycast:_cast/hit", "int")
    yield "bs.raycast:_cast/stop", provider(cond(nearest.le(MISS - 1), -(2**31), ctx("max")))


def sweep() -> Generated:
    """Group the table of a block or an entity into shapes, over its count of boxes."""
    limit, count = ctx("limit"), ctx("count")

    def grown(j: int) -> Expression:
        entry, exit_ = ctx(f"entry{j}"), ctx(f"exit{j}")
        return cond(entry.le(limit), cond(exit_.ge(limit + 1), exit_, -MISS), -entry)

    yield "bs.raycast:_pierce/start", provider(fold(min_, lambda j: ctx(f"entry{j}"), MISS, count))
    yield "bs.raycast:_pierce/grow", provider(fold(max_, grown, -MISS, count))


def pierce(boxes: Boxes) -> Generated:
    """The boxes the ray crosses as a mask, and the keys of the first one left, for the table."""
    path = f"bs.raycast:_pierce/{boxes.kind}"
    mask = boxes.fold(add, lambda k: cond(crosses(boxes.hit(k)), bit(k), 0), 0)
    yield f"{path}/mask", provider(mask)
    yield f"{path}/in", provider(boxes.first(lambda k: entry_key(boxes.hit(k))))
    yield f"{path}/out", provider(boxes.first(lambda k: exit_key(boxes.flag(k), boxes.exit(k))))


def pierce_block() -> Generated:
    """The hit of a block with every flag, the exit of a single box, and the shapes of the table."""
    flagged = BLOCK.fold(add, lambda k: cond(marked(k), digit(BLOCK.flag(k)), 0), 0)
    yield "bs.raycast:_pierce/b/flags", provider(flagged)
    nearest = BLOCK.fold(min_, lambda k: cond(marked(k), BLOCK.hit(k), MISS), MISS)
    yield "bs.raycast:_pierce/b/near", provider(nearest)
    yield "bs.raycast:_pierce/b/all", provider(ctx("block") // 16 * 16 + flags())
    yield "bs.raycast:_pierce/b/exit", provider(BLOCK.first(BLOCK.exit))

    shapes = ctx("shapes")
    starts, ends = lambda i: ctx(f"start{i}"), lambda i: ctx(f"end{i}")
    later, _ = next_and_exit(starts, ends, ctx("block"), shapes, BLOCK_BOXES)
    yield "bs.raycast:_pierce/b/next", provider(later)

    _, shaped = next_and_exit(starts, ends, ctx("hit"), shapes, BLOCK_BOXES)
    cell = min_(ctx("lx"), ctx("ly"), ctx("lz"))
    left = cond(shapes.le(-1), cell, cond(shapes.eq(0), ctx("end0"), shaped))
    yield "bs.raycast:_pierce/b/leave", provider(left)


def pierce_entity() -> Generated:
    """The exit of an entity with a single shape, and the shapes kept on its scores."""
    left = ENTITY.fold(max_, lambda k: cond(crosses(ENTITY.hit(k)), ENTITY.exit(k), -1), -1)
    yield "bs.raycast:_pierce/e/exit", provider(left)

    shapes, at = own("shapes"), own("hit")
    starts, ends = lambda i: own(f"s{i}"), lambda i: own(f"e{i}")
    later, left = next_and_exit(starts, ends, at, shapes, ENTITY_BOXES)
    yield "bs.raycast:_pierce/e/next", provider(later)
    yield "bs.raycast:_pierce/e/leave", provider(left)

    digits = fold(add, lambda i: digit(starts(i) // FLAGS), 0, -shapes, ENTITY_BOXES)
    yield "bs.raycast:_pierce/e/flags", provider(digits)
    first = fold(min_, lambda i: starts(i).floor_mod(FLAGS), MISS, -shapes, ENTITY_BOXES)
    yield "bs.raycast:_pierce/e/hit", provider(first * 16 + flags())


def next_and_exit(
    starts: Term,
    ends: Term,
    at: Expression,
    count: Expression,
    size: int,
) -> tuple[Expression, Expression]:
    """The entry of the next shape after the hit, MISS without one, and the exit of the hit one."""

    def later(i: int) -> Expression:
        entry = order(starts(i))
        return cond(entry.le(at), MISS, entry)

    def left(i: int) -> Expression:
        return cond(order(starts(i)).eq(at), leave(ends(i)), -1)

    entry = cond(count.le(0), MISS, fold(min_, later, MISS, count, size))
    return entry, fold(max_, left, -1, count, size)


def provider(expression: Expression) -> ContextIntProvider:
    return ContextIntProvider(expression.json())


def float_provider(expression: Expression) -> ContextFloatProvider:
    return ContextFloatProvider(expression.json())


def data(name: str) -> Expression:
    """The score #raycast.<name>, or its letter in the contextual objective."""
    if name in CONTEXT:
        return score("bs.ctx", fixed_target(CONTEXT[name]))
    return score("bs.data", fixed_target(f"#raycast.{name}"))


def ctx(name: str) -> Expression:
    """A score of the ray, through its mirror when it has one."""
    if name in MIRRORS:
        return ref(f"bs.raycast:{MIRRORS[name]}", "int")
    return data(name)


def ray(name: str) -> Expression:
    """A value of the ray as a float, in a provider of its own."""
    return ref(f"bs.raycast:_{name}")


def own(name: str) -> Expression:
    """A score of the entity, as bs.raycast.<name>."""
    return score(f"bs.raycast.{name}", context_target())


def fold(
    pick: Callable[..., Expression],
    term: Term,
    empty: int,
    count: Expression,
    size: int = BLOCK_BOXES,
) -> Expression:
    """Pick among the first `count` terms."""
    value = term(size - 1)
    for i in reversed(range(size - 1)):
        value = pick(term(i), cond(count.ge(i + 2), value, empty))
    return value


def octants(value: Term) -> Expression:
    """The value for the octant of the ray: a box only reads the bounds it needs."""
    return btree(list(range(1, 9)), value, lambda os: ctx("octant").le(max(os)))


def block_slab(box: int, axis: int, sign: int, *, enter: bool) -> Expression:
    """Where the ray crosses a plane of the box, from the grid lengths l and p and the delta d."""
    a = "xyz"[axis]
    if sign:
        return ray(f"l{a}") - ray(f"d{a}") * BLOCK.bound(box, axis + 3 if enter else axis)
    return ray(f"p{a}") + ray(f"d{a}") * BLOCK.bound(box, axis if enter else axis + 3)


def block_slabs(box: int, octant: int, *, enter: bool = True) -> list[Expression]:
    """The slabs of the box for the octant of the ray: each axis only depends on its sign."""
    signs = ["pn"[(octant - 1) >> axis & 1] for axis in range(3)]
    return [ref(BLOCK.slab_id(box, axis, enter=enter, sign=signs[axis])) for axis in range(3)]


def entity_slab(box: int, axis: int, *, enter: bool) -> Expression:
    """Where the ray crosses a plane of the box, from the entity relative to the origin."""
    a = "xyz"[axis]
    start, delta = ray(f"o{a}"), ray(f"d{a}")
    ahead = (start + ENTITY.bound(box, axis if enter else axis + 3)) * delta
    behind = -((start + ENTITY.bound(box, axis + 3 if enter else axis)) * delta)
    return cond(ctx(f"u{a}").ge(0), ahead, behind)


def entity_slabs(box: int, *, enter: bool = True) -> list[Expression]:
    return [ref(ENTITY.slab_id(box, axis, enter=enter)) for axis in range(3)]


def hit(entered: list[Expression], left: list[Expression], flag: Expression) -> Expression:
    """Entry * 64 + face axis * 16 + flag, axis 3 for an origin inside, or MISS out of reach."""
    crossed = max_(*entered, 0.0).le(min_(*left, ray("max")))
    axes = (max_(e, -LONGEST).to_int() * 4 + axis for axis, e in enumerate(entered))
    return cond(crossed, max_(*axes, 3) * 16 + flag, MISS)


def crosses(hit: Expression) -> Condition:
    return hit.le(MISS - 1)


def marked(box: int) -> Condition:
    return (ctx("mask") // bit(box)).floor_mod(2).eq(1)


def bit(box: int) -> int:
    """The bit of a box in the mask, the first box on the highest bit."""
    return 2 ** (23 - box)


def entry_key(hit: Expression) -> Expression:
    return hit.floor_mod(16) * FLAGS + hit // 16


def exit_key(flag: Expression, exit_: Expression) -> Expression:
    return flag * FLAGS + exit_ * 4 + JOIN


def order(key: Expression) -> Expression:
    """A start key in the order of a hit: entry * 4 + face axis, then flag."""
    return key.floor_mod(FLAGS) * 16 + key // FLAGS


def leave(key: Expression) -> Expression:
    """The exit length of an end key."""
    return (key.floor_mod(FLAGS) - JOIN) // 4


def digit(flag: Expression) -> Expression:
    """1, 32, 1024 or 32768 for the flag 1, 2, 4 or 8: a sum counts each flag in base 32."""
    return cond(flag.le(2), cond(flag.le(1), 1, 32), cond(flag.le(4), 1024, 32768))


def flags() -> Expression:
    """The flags present in #raycast.count, as bits."""
    count = ctx("count")
    return add(*(cond((count // 32**i).floor_mod(32).ge(1), 2**i, 0) for i in range(4)))

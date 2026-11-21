import struct
from collections.abc import Callable, Iterable, Iterator
from itertools import product

from beet import BlockTag, Context, ContextIntProvider, Function

from mcbookshelf.minecraft import condition, snbt
from mcbookshelf.minecraft.block import Block, Shape, State, block_table, changing, get_blocks
from mcbookshelf.minecraft.math import (
    Expression,
    add,
    btree,
    clamp,
    cond,
    const,
    fixed_target,
    int_storage,
    ref,
    score,
)
from mcbookshelf.pipeline.plugins import Generated, generator

type Groups = dict[tuple[Shape, bool], int]
type StateKey = tuple[tuple[str, str], ...]


CUBE = ((0.0, 0.0, 0.0, 1.0, 1.0, 1.0),)

OFFSETS = [(struct.unpack("f", struct.pack("f", n / 15))[0] - 0.5) * 0.5 for n in range(16)]
OFFSET = "bs.hitbox:_get_block/offset"
SMALL_OFFSET = ("minecraft:pointed_dripstone", "minecraft:sulfur_spike")
SMALL_OFFSETS = [min(max(offset, -0.125), 0.125) for offset in OFFSETS[3:13]]

SHAPES: dict[str, Callable[[State], Shape]] = {
    "outline": lambda state: state.shape,
    "collision": lambda state: state.collision_shape,
}

TAGS: dict[str, Callable[[Block], bool]] = {
    "has_fluid": lambda block: all(s.fluid for s in block.states),
    "has_no_collision": lambda block: all(not s.collision_shape for s in block.states),
    "has_no_outline": lambda block: all(not s.shape for s in block.states),
    "has_shape_offset": lambda block: block.has_shape_offset,
    "has_visual_offset": lambda block: block.has_visual_offset,
    "is_full_cube_collision": lambda block: all(s.collision_shape == CUBE for s in block.states),
    "is_full_cube_outline": lambda block: all(s.shape == CUBE for s in block.states),
    "is_waterloggable": lambda block: "waterlogged" in dict(block.properties),
}


@generator
def beet_default(ctx: Context) -> Generated:
    blocks = list(get_blocks(ctx.cache["minecraft"]).values())
    providers, table = block_table(blocks, SHAPES, {
        name: lambda b, name=name: TAGS[f"has_no_{name}"](b) or TAGS[f"is_full_cube_{name}"](b)
        for name in SHAPES
    })

    groups = {}
    for block in filter(lambda b: b.has_shape_offset, blocks):
        small = block.id in SMALL_OFFSET
        offsets = SMALL_OFFSETS if small else OFFSETS
        for state, raw in product(block.states, ("shape", "collision_shape")):
            shape = getattr(state, raw)
            if shape and (shape, small) not in groups:
                groups[shape, small] = len(table)
                table.extend(_moved(shape, x, z) for x in offsets for z in offsets)

    shapes = snbt.dumps([[list(box) for box in shape or ()] for shape in table])
    load = f"data modify storage bs.hitbox: table set value {shapes}"
    yield "bs.hitbox:get_block/__load__", Function(["", load])

    x = score("bs.ctx", fixed_target("#x"))
    z = score("bs.ctx", fixed_target("#z"))
    seed = add(*(cond(_seed_bit(x, i).eq(_seed_bit(z, i)), 0, 2**i) for i in range(28)))
    yield "bs.hitbox:_get_block/seed", ContextIntProvider(seed.json())

    for axis, index, factor in (("x", 0, 3129871), ("z", 2, 116129781)):
        position = int_storage("bs.hitbox:", f"pos[{index}]").floor_mod(2**28)
        seed = _safe_mul(position, factor, 28)
        yield f"bs.hitbox:_get_block/seed_{axis}", ContextIntProvider(seed.json())

    for name, value in _offsets():
        yield f"{OFFSET}/{name}".rstrip("/"), ContextIntProvider(value.json())

    for name, value in SHAPES.items():
        offset = [b for b in blocks if b.has_shape_offset and all(value(s) for s in b.states)]
        first = btree(offset, lambda b, value=value: _first_offset(b, value, groups), _block)
        index = cond(_block(offset), add(first, ref(OFFSET, "int")), providers[name])
        yield f"bs.hitbox:_get_block/{name}/index", ContextIntProvider(index.json())

    for tag, test in TAGS.items():
        yield f"bs.hitbox:{tag}", BlockTag({"values": [b.id for b in blocks if test(b)]})


def _moved(shape: Shape, x: float, z: float) -> Shape:
    return tuple((x1 + x, y1, z1 + z, x2 + x, y2, z2 + z) for x1, y1, z1, x2, y2, z2 in shape)


def _block(blocks: Iterable[Block]) -> condition.Condition:
    return condition.block(block.id for block in blocks)


def _seed_bit(value: Expression, i: int) -> Expression:
    return (value // 2**i if i else value).floor_mod(2)


def _first_offset(block: Block, value: Callable[[State], Shape], starts: Groups) -> Expression:
    small = block.id in SMALL_OFFSET
    names = changing(block, tuple(value(state) for state in block.states))
    keys = {
        tuple((n, state.get(n)) for n in names): starts[value(state), small]
        for state in block.states
    }

    def test(half: list[tuple[StateKey, int]]) -> condition.Condition:
        states = (condition.all_of(*(condition.block_state(*p) for p in key)) for key, _ in half)
        return condition.any_of(*states)

    return btree(keys.items(), lambda key: const(key[1]), test)


def _offsets() -> Iterator[tuple[str, Expression]]:
    """The offset to use, from the seed in `#s`: x uses its bits 16 to 19, and z 24 to 27."""
    seed = score("bs.ctx", fixed_target("#s"))
    for axis, bits in (("x", 20), ("z", 28)):
        # The 4 highest bits of (part * part * 42317861 + part * 11) modulo 2^bits
        part = seed.floor_mod(2**bits) if axis == "x" else seed
        factor = (_safe_mul(part, 42317861, bits) + 11).floor_mod(2**bits)
        yield f"f{axis}", factor
        yield axis, _safe_mul(part, ref(f"{OFFSET}/f{axis}", "int"), bits) // 2 ** (bits - 4)
    x, z = ref(f"{OFFSET}/x", "int"), ref(f"{OFFSET}/z", "int")
    small = (clamp(x, 3, 12) - 3) * 10 + clamp(z, 3, 12) - 3
    yield "", cond(condition.block(SMALL_OFFSET), small, x * 16 + z)


def _safe_mul(a: Expression, b: Expression | int, bits: int) -> Expression:
    """The product of two numbers below 2^bits, modulo 2^bits, by halves to stay in int range."""
    half = 2 ** (bits // 2)
    low_a, high_a = a % half, a // half
    low_b, high_b = b % half, b // half
    cross = (high_a * low_b + low_a * high_b) % half
    return (low_a * low_b + cross * half) % 2**bits

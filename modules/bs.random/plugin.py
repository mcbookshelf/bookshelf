import itertools
import math

from beet import Context

from mcbookshelf.meta import Module
from mcbookshelf.minecraft.number import (
    Expression,
    Operand,
    add,
    btree,
    clamp,
    cond,
    counted,
    max_,
    min_,
    ref,
    score,
    storage,
    uniform,
    weighted,
)
from mcbookshelf.pipeline.plugins import Generated, generator

UNITS = 1024
PRIME = 46337
DIMS = {1: (1.0, 0.0, 3.16), 2: (0.5, 15 / 71, 99.0), 3: (0.5, 1 / 6, 107.0)}
COORDS = [score("bs.ctx", f"#{axis}") for axis in "xyz"]
OFFSETS = [score("bs.ctx", f"#{axis}") for axis in "uvw"]
SEED = score("bs.ctx", "#h")


@generator
def beet_default(ctx: Context) -> Generated:
    module: Module = ctx.meta["module"]
    yield f"{module.id}:geometric", geometric(storage(f"{module.id}:geometric", "in.probability"))
    yield f"{module.id}:poisson", poisson(storage(f"{module.id}:poisson", "in.lambda"))
    yield from simplex_noise(f"{module.id}:_simplex_noise", clamped=True)
    yield from simplex_noise(f"{module.id}:_fractal_noise", clamped=False)
    yield from weighted_choice(module.id)


def geometric(p: Expression) -> Expression:
    """The bits of a geometric variable are independent: bit k is set with odds of (1 - p)^2^k."""
    def bit(k: int) -> Expression:
        odds = (1.0 - p) ** float(2**k)
        return cond((odds - uniform(0.0, 1.0) * (1.0 + odds)).ge(1e-9), 2**k, 0)

    return add(1, *map(bit, range(16)))


def poisson(lam: Expression) -> Expression:
    """Pick from the distribution of lambda, rounded to a tenth, up to 10."""
    tenths = clamp((lam * 10.0).round().to_int(), 0, 100)

    def distribution(step: int) -> Expression:
        mean = step / 10
        weights = [round(1e6 * math.exp(-mean) * mean**k / math.factorial(k)) for k in range(40)]
        return weighted(*((k, w) for k, w in enumerate(weights) if w > 0), kind="int")

    return btree(range(101), distribution, lambda half: tenths.le(half[-1]))


def weighted_choice(module: str) -> Generated:
    """Each weight draws the key u^(1 / weight): the largest key wins, by weight / total."""
    size, block, group = 256, 64, 8
    levels = 2**31 // size - 1
    folder = f"{module}:_weighted_choice"
    length, draw = ref(f"{folder}/n", "int"), ref(f"{folder}/u")
    blocks = [ref(f"{folder}/{b}", "int") for b in range(size // block)]

    def key(k: int, missing: float | None = None) -> Expression:
        """Key of a weight packed above its index: only a weight of 0 has a key of 0."""
        weight = storage(f"{module}:weighted_choice", f"in.weights[{k}]", fallback=missing)
        return (draw ** (1.0 / weight) * levels).to_int() * size + k

    def first_group(start: int) -> Expression:
        """Best key of a group of the first block: one test when full, one by weight otherwise."""
        end = start + group
        partial = counted(
            length,
            range(start, end - 1),
            key,
            lambda first, has_more, rest: max_(first, cond(has_more, rest, -1)),
        )
        if start:
            partial = cond(length.ge(start + 1), partial, -1)
        return cond(length.ge(end), max_(*map(key, range(start, end))), partial)

    def later_group(start: int) -> Expression:
        """Best key of a group of the other blocks: a weight past the end reads as 0, slowly."""
        keys = max_(*(key(k, 0.0) for k in range(start, start + group)))
        return keys if start % block == 0 else cond(length.ge(start + 1), keys, -1)

    def reached(low: int, high: int) -> Expression:
        """Best key of blocks low to high, low being reached: no block past the end is read."""
        if high - low == 1:
            return blocks[low]
        mid = (low + high) // 2
        upper = max_(*blocks[low:mid], reached(mid, high))
        return cond(length.ge(mid * block + 1), upper, reached(low, mid))

    yield f"{folder}/n", score("bs.ctx", "#n")
    yield f"{folder}/u", uniform(2 / levels, 1.0)
    for b in range(len(blocks)):
        starts = range(b * block, (b + 1) * block, group)
        yield f"{folder}/{b}", max_(*map(later_group if b else first_group, starts))
    yield f"{folder}/index", min_(reached(0, len(blocks)) % size, length - 1)


def corner_hash(steps: tuple[int, ...]) -> Expression:
    """Hash of the corner of the cell that is `steps` cells further on each axis."""
    def mix(value: Expression, salt: Operand) -> Expression:
        return (value**2 + salt).floor_mod(PRIME)

    column, *rows = (coord // UNITS + step for coord, step in zip(COORDS, steps, strict=False))
    hashed = mix(mix(column.floor_mod(PRIME), SEED // PRIME), 12345)
    for index, row in enumerate(rows):
        if index:
            hashed = mix(hashed, 4321)
        hashed = (hashed + row).floor_mod(23167)
    return mix(mix(hashed, SEED.floor_mod(PRIME)), 6789)


def corner_noise(steps: tuple[int, ...], hashed: Expression) -> Expression:
    """What a corner adds: its falloff times its gradient along the offset from it."""
    dims = len(steps)
    radius, unskew, _ = DIMS[dims]
    first = OFFSETS[:dims] if dims > 1 else [COORDS[0].floor_mod(UNITS)]
    skew = sum(steps) * unskew
    offset = [
        axis.to_float() + (skew - step) * UNITS
        for axis, step in zip(first, steps, strict=True)
    ]
    angle = hashed.to_float() * (2 * math.pi / PRIME)
    cos, sin = angle.cos(), angle.sin()
    match offset:
        case [x]:
            slope = x * cos
        case [x, y]:
            slope = x * cos + y * sin
        case [x, y, z]:
            height = (hashed * 28638).floor_mod(PRIME).to_float() * (2 / PRIME) - 1.0
            slope = (1.0 - height**2.0).sqrt() * (x * cos + y * sin) + z * height
    falloff = max_(radius * UNITS**2 - add(*(axis**2.0 for axis in offset)), 0.0) ** 4.0
    return falloff * slope


def simplex_corners(dims: int, corners: dict[tuple[int, ...], Expression]) -> list[Expression]:
    """Corners around the point: one more step each time, on the largest fraction first."""
    x, y, z = (coord.floor_mod(UNITS) for coord in COORDS)
    first, last = corners[(0,) * dims], corners[(1,) * dims]
    match dims:
        case 1:
            return [first, last]
        case 2:
            return [first, cond((x - y).ge(1), corners[1, 0], corners[0, 1]), last]
    x_ge_y, x_ge_z, y_ge_z = (x - y).ge(0), (x - z).ge(0), (y - z).ge(0)
    one_step = cond(
        x_ge_y,
        cond(x_ge_z, corners[1, 0, 0], corners[0, 0, 1]),
        cond(y_ge_z, corners[0, 1, 0], corners[0, 0, 1]),
    )
    two_steps = cond(
        x_ge_y,
        cond(y_ge_z, corners[1, 1, 0], corners[1, 0, 1]),
        cond(x_ge_z, corners[1, 1, 0], corners[0, 1, 1]),
    )
    return [first, one_step, two_steps, last]


def simplex_noise(folder: str, *, clamped: bool) -> Generated:
    """Noise in 1, 2 and 3 dimensions, each corner hash in its own file as it is read often."""
    for dims in (1, 2, 3):
        corners = {}
        for steps in itertools.product((0, 1), repeat=dims):
            hashed = corner_hash(steps)
            if dims > 1:
                name = f"{folder}/{dims}d/h{sum(step << axis for axis, step in enumerate(steps))}"
                yield name, hashed
                hashed = ref(name, "int")
            corners[steps] = corner_noise(steps, hashed)
        noise = add(*simplex_corners(dims, corners)) * (DIMS[dims][2] / UNITS**9)
        yield f"{folder}/{dims}d/noise", clamp(noise, -1.0, 1.0) if clamped else noise

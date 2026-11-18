import math

from beet import Context, ContextFloatProvider, ContextIntProvider

from mcbookshelf.meta import Module
from mcbookshelf.minecraft.math import (
    Expression,
    add,
    binomial,
    btree,
    clamp,
    cond,
    fixed_target,
    float_storage,
    int_storage,
    max_,
    score,
    uniform,
    weighted,
)
from mcbookshelf.pipeline.plugins import Generated, generator

# Lattice hash: every product stays below 2^31, as an overflow fails the whole provider
PRIME = 46337
ROW = 31337
# Simplex unskew factor, matching the 15/41 skew of the mcfunction side
UNSKEW = 15 / 71
# Simplex peaks near 0.0101 with these gradients and falloff
SCALE = 99.0
GEOMETRIC_BITS = 16
POISSON_MAX = 10
POISSON_WEIGHT = 1_000_000


@generator
def beet_default(ctx: Context) -> Generated:
    module: Module = ctx.meta["module"]

    def read(feature: str, key: str, kind: str = "int") -> Expression:
        storage = int_storage if kind == "int" else float_storage
        return storage(f"{module.id}:{feature}", f"in.{key}")

    providers = {
        "uniform": uniform(read("uniform", "min"), read("uniform", "max")),
        "binomial": binomial(read("binomial", "trials"), read("binomial", "probability", "float")),
        "geometric": geometric(read("geometric", "probability", "float")),
        "normal": normal(read("normal", "mean", "float"), read("normal", "spread", "float")),
        "poisson": poisson(read("poisson", "lambda", "float")),
    }
    for name, provider in providers.items():
        yield f"{module.id}:{name}", ContextIntProvider(provider.json())
    yield f"{module.id}:_simplex", ContextFloatProvider(simplex().json())


def geometric(p: Expression) -> Expression:
    """The bits of a geometric variable are independent: bit k is set with q^2^k / (1 + q^2^k)."""
    def bit(k: int) -> Expression:
        q = (1.0 - p) ** float(2**k)
        return cond((q - uniform(0.0, 1.0) * (1.0 + q)).ge(1e-9), 2**k, 0)
    return add(1, *(bit(k) for k in range(GEOMETRIC_BITS)))


def normal(mean: Expression, spread: Expression) -> Expression:
    """The sum of 12 uniform values has a mean of 6 and a deviation of 1."""
    total = add(*(uniform(0.0, 1.0) for _ in range(12)))
    return (mean + spread * (total - 6.0)).round().to_int()


def poisson(lam: Expression) -> Expression:
    """Pick from the distribution of each lambda, by steps of 0.1."""
    step = clamp((lam * 10.0).round().to_int(), 0, POISSON_MAX * 10)

    def distribution(tenths: int) -> Expression:
        mean = tenths / 10
        weights = [
            (k, round(POISSON_WEIGHT * math.exp(-mean) * mean**k / math.factorial(k)))
            for k in range(4 * POISSON_MAX)
        ]
        return weighted(*((k, w) for k, w in weights if w > 0), kind="int")

    return btree(
        range(POISSON_MAX * 10 + 1),
        distribution,
        lambda half: step.le(half[-1]),
    )


def simplex() -> Expression:
    """Add the 3 corners of the cell, from the offsets and hash computed by the function."""
    def read(name: str) -> Expression:
        return score("bs.ctx", fixed_target(f"#{name}"))

    def corner(x: Expression, y: Expression, key: int) -> Expression:
        c = (read("a") + key).floor_mod(PRIME)
        b = (c * c + 12345).floor_mod(PRIME)
        angle = (b * b + c).floor_mod(PRIME).to_float() * (2 * math.pi / PRIME)
        falloff = max_(0.5 - x**2.0 - y**2.0, 0.0) ** 4.0
        return falloff * (x * angle.cos() + y * angle.sin())

    def x0() -> Expression:
        return read("u").to_float() / 1024.0

    def y0() -> Expression:
        return read("v").to_float() / 1024.0

    middle = cond(
        read("c").eq(1),
        corner(x0() - 1.0 + UNSKEW, y0() + UNSKEW, ROW),
        corner(x0() + UNSKEW, y0() - 1.0 + UNSKEW, 1),
    )
    far = corner(x0() - 1.0 + 2 * UNSKEW, y0() - 1.0 + 2 * UNSKEW, ROW + 1)
    return clamp((corner(x0(), y0(), 0) + middle + far) * SCALE, -1.0, 1.0)


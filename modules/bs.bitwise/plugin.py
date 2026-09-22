from beet import Context, ContextIntProvider

from mcbookshelf.meta import Module
from mcbookshelf.minecraft.math import Expression, add, btree, cond, int_storage, max_, min_, mul

INT_MIN = -(2**31)


def beet_default(ctx: Context) -> None:
    """Generate the number providers of the bitwise module."""
    module: Module = ctx.meta["module"]

    def read(feature: str, key: str) -> Expression:
        return int_storage(f"{module.id}:{feature}", f"in.{key}")

    for name, provider in {
        "not": bitwise_not(read("not", "n")),
        "and": bitwise_and(read("and", "a"), read("and", "b")),
        "or": bitwise_or(read("or", "a"), read("or", "b")),
        "xor": bitwise_xor(read("xor", "a"), read("xor", "b")),
        "bit_count": bit_count(read("bit_count", "n")),
        "bit_length": bit_length(read("bit_length", "n")),
        "shift_left": shift_left(read("shift_left", "n"), read("shift_left", "by")),
        "shift_right": shift_right(read("shift_right", "n"), read("shift_right", "by")),
    }.items():
        ctx.data[f"{module.id}:{name}"] = ContextIntProvider(provider.json())


def bit(x: Expression, i: int) -> Expression:
    return (x // 2**i if i else x).floor_mod(2)


def sign(x: Expression) -> Expression:
    return (x // 2**30) // 2


def bitwise_not(n: Expression) -> Expression:
    return -1 - n


def bitwise_and(a: Expression, b: Expression) -> Expression:
    return add(
        *(mul(2**i, bit(a, i), bit(b, i)) for i in range(31)),
        cond(a.le(-1) & b.le(-1), INT_MIN, 0),
    )


def bitwise_or(a: Expression, b: Expression) -> Expression:
    return add(
        *(mul(2**i, max_(bit(a, i), bit(b, i))) for i in range(31)),
        cond(a.le(-1) | b.le(-1), INT_MIN, 0),
    )


def bitwise_xor(a: Expression, b: Expression) -> Expression:
    return add(
        *(cond(bit(a, i).eq(bit(b, i)), 0, 2**i) for i in range(31)),
        cond(sign(a).eq(sign(b)), 0, INT_MIN),
    )


def bit_count(n: Expression) -> Expression:
    return n - add(*(n // 2**k for k in range(1, 31))) + cond(n.le(-1), 3, 0)


def bit_length(n: Expression) -> Expression:
    return cond(n.le(-1), 32, btree(n, [(2**k - 1, k) for k in range(31)], 31))


def shift_left(n: Expression, by: Expression) -> Expression:
    kept = 2 ** min_(by, 30) * n.floor_mod(2 ** (31 - by))
    top = mul(INT_MIN, (n // 2 ** (31 - by)).floor_mod(2))
    return cond(by.le(0), n, kept + top)


def shift_right(n: Expression, by: Expression) -> Expression:
    return cond(by.ge(31), sign(n), n // 2**by)

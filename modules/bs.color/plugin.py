from beet import Context, ContextFloatProvider, ContextIntProvider

from mcbookshelf.meta import Module
from mcbookshelf.minecraft.math import (
    Expression,
    add,
    clamp,
    cond,
    float_storage,
    int_storage,
    mul,
    ref,
)
from mcbookshelf.pipeline.plugins import Generated, generator

TO_LMS = (
    (0.4122214708, 0.5363325363, 0.0514459929),
    (0.2119034982, 0.6806995451, 0.1073969566),
    (0.0883024619, 0.2817188376, 0.6299787005),
)
FROM_LMS = (
    (4.0767416621, -3.3077115913, 0.2309699292),
    (-1.2684380046, 2.6097574011, -0.3413193965),
    (-0.0041960863, -0.7034186147, 1.7076147010),
)
SHIFTS = (16, 8, 0)
CONES = ("long", "medium", "short")
CHANNELS = ("red", "green", "blue")


@generator
def beet_default(ctx: Context) -> Generated:
    module: Module = ctx.meta["module"]

    def inputs(name: str) -> tuple[Expression, Expression, Expression]:
        storage = f"{module.id}:{name}"
        ratio = clamp(float_storage(storage, "in.ratio"), 0.0, 1.0)
        return int_storage(storage, "in.from"), int_storage(storage, "in.to"), ratio

    yield f"{module.id}:mix", ContextIntProvider(mix(*inputs("mix")).json())

    start, end, ratio = inputs("mix_oklab")
    private = f"{module.id}:_mix_oklab"
    for name, color in (("from", start), ("to", end)):
        for cone, value in zip(CONES, cones(color), strict=True):
            yield f"{private}/{name}_{cone}", ContextFloatProvider(value.json())
    for cone in CONES:
        mixed = between(ref(f"{private}/from_{cone}"), ref(f"{private}/to_{cone}"), ratio) ** 3
        yield f"{private}/{cone}", ContextFloatProvider(mixed.json())
    long, medium, short = (ref(f"{private}/{cone}") for cone in CONES)
    for name, (x, y, z) in zip(CHANNELS, FROM_LMS, strict=True):
        value = x * long + y * medium + z * short
        yield f"{private}/{name}", ContextFloatProvider(value.json())
    red, green, blue = (curved(ref(f"{private}/{name}")) for name in CHANNELS)
    packed = pack(red, green, blue, mixed_byte(start, end, ratio, 24))
    yield f"{module.id}:mix_oklab", ContextIntProvider(packed.json())


def channel(color: Expression, shift: int) -> Expression:
    """One of the four bytes of a color, from 0 to 255."""
    return (color // 2**shift if shift else color).floor_mod(256)


def between(a: Expression, b: Expression, ratio: Expression) -> Expression:
    return a + (b - a) * ratio


def pack(red: Expression, green: Expression, blue: Expression, alpha: Expression) -> Expression:
    """An integer from its four bytes: the alpha is signed, for it to stay in range."""
    signed = (alpha + 128).floor_mod(256) - 128
    return add(blue, mul(green, 2**8), mul(red, 2**16), mul(signed, 2**24))


def mixed_byte(start: Expression, end: Expression, ratio: Expression, shift: int) -> Expression:
    a, b = channel(start, shift).to_float(), channel(end, shift).to_float()
    return between(a, b, ratio).round().to_int()


def mix(start: Expression, end: Expression, ratio: Expression) -> Expression:
    """Each channel taken between the two colors."""
    red, green, blue = (mixed_byte(start, end, ratio, shift) for shift in SHIFTS)
    return pack(red, green, blue, mixed_byte(start, end, ratio, 24))


def linear(byte: Expression) -> Expression:
    """A channel without the sRGB curve, from 0 to 1."""
    value = byte.to_float() / 255.0
    return cond(byte.le(10), value / 12.92, ((value + 0.055) / 1.055) ** 2.4)


def curved(value: Expression) -> Expression:
    """A channel with the sRGB curve, as a byte."""
    value = clamp(value, 0.0, 1.0)
    curve = cond(value.le(0.0031308), value * 12.92, value ** (1 / 2.4) * 1.055 - 0.055)
    return (curve * 255.0).round().to_int()


def cones(color: Expression) -> tuple[Expression, ...]:
    """The cube roots of the cone responses of a color: Oklab is a weighted sum of them."""
    red, green, blue = (linear(channel(color, shift)) for shift in SHIFTS)
    return tuple((r * red + g * green + b * blue) ** (1 / 3) for r, g, b in TO_LMS)

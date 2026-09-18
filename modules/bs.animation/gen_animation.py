from __future__ import annotations

from typing import TYPE_CHECKING

from beet import Context, JsonFile, NamespaceFileScope

from bookshelf.services.minecraft.math import (
    Expression,
    Operand,
    istorage,
    storage,
    switch,
)

if TYPE_CHECKING:
    from collections.abc import Callable, ClassVar


class ContextFloatProvider(JsonFile):
    """Class representing a context float provider."""

    scope: ClassVar[NamespaceFileScope] = ("context_float_provider",)
    extension: ClassVar[str] = ".json"


class ContextIntProvider(JsonFile):
    """Class representing a context int provider."""

    scope: ClassVar[NamespaceFileScope] = ("context_int_provider",)
    extension: ClassVar[str] = ".json"


def beet_default(ctx: Context) -> None:
    """Generate files used by the animation module.

    Track compound format, stored on the entity:
    - id:    user label, several tracks may share it
    - run:   callback command, executed once per step
    - k:     curve id (bezier 0, bspline 1, catmull_rom 2, hermite 3, linear 4, step 5)
    - r:     points consumed per segment (3, 1, 1, 2, 1, 1)
    - n:     segment count, capped by the duration list
    - p0:    points, padded for catmull_rom and bspline
    - d0:    duration, total (scalar) or per segment (list)
    - p:     rotating window, p[0..3] is the current segment
    - d:     rotates with p when a list, d[0] is the current segment
    - i:     current segment index
    - t:     progress inside the segment, 0 to 1
    - s:     step, ticks advanced per game tick (play)
    - v:     interval, ticks between process steps (play)
    - l:     present only when looping (play)
    - w:     absolute game tick of the next process step, absent when stopped
    """
    if ContextFloatProvider not in ctx.data.extend_namespace:
        ctx.data.extend_namespace.append(ContextFloatProvider)
    if ContextIntProvider not in ctx.data.extend_namespace:
        ctx.data.extend_namespace.append(ContextIntProvider)

    ns = ctx.directory.name

    def read(
        key: str,
        fallback: Operand | None = None,
        fn: Callable[[str, str, Operand | None], Expression] = storage,
    ) -> Expression:
        return fn(f"{ns}:", f"stack[-1].{key}", fallback)

    k = read("_[0].k", fn=istorage)
    t = read("_[0].t", fallback=0.0)

    n = read("_[0].n")
    d = read("_[0].d")
    v = read("_[0].v", fallback=1.0)
    s = read("_[0].s", fallback=1.0)

    d0 = read("_[0].d[0]", fallback=d / n)
    dl = read("_[0].d[-1]", fallback=d0)
    dr = read("_[0].d[1]", fallback=d0)
    first = read("_[0].d0[0]", fallback=d0)
    step = read("step", fallback=s * v)

    ctx.data[f"{ns}:internal/advance"] = ContextFloatProvider((t + step / d0).node)
    ctx.data[f"{ns}:internal/cl"] = ContextFloatProvider(((t - 1) * (dl / d0)).node)
    ctx.data[f"{ns}:internal/cr"] = ContextFloatProvider((1 + t * (dr / d0)).node)
    ctx.data[f"{ns}:internal/ce"] = ContextFloatProvider(((t - 1) * (d0 / first)).node)
    ctx.data[f"{ns}:internal/cs"] = ContextFloatProvider((1 + t * (first / d0)).node)

    for axis in range(4):
        p0, p1, p2, p3 = (read(f"_[0].p[{i}][{axis}]") for i in range(4))
        provider = switch(k, {
            0: create_bezier_expression(p0, p1, p2, p3, t),
            1: create_bspline_expression(p0, p1, p2, p3, t),
            2: create_catmull_rom_expression(p0, p1, p2, p3, t),
            3: create_hermite_expression(p0, p1, p2, p3, t),
            4: create_linear_expression(p0, p1, t),
            5: p0,
        })

        ctx.data[f"{ns}:eval/{axis}"] = ContextFloatProvider(provider.node)


def create_bezier_expression(
    p0: Expression,
    p1: Expression,
    p2: Expression,
    p3: Expression,
    t: Expression,
) -> Expression:
    """Build a cubic Bezier curve expression."""
    return p0 + t * (3 * (1 - t) * ((p1 - p0) + t * (p2 - p1)) + t**2 * (p3 - p0))


def create_bspline_expression(
    p0: Expression,
    p1: Expression,
    p2: Expression,
    p3: Expression,
    t: Expression,
) -> Expression:
    """Build a uniform cubic B-spline expression."""
    return p1 + (1 / 6) * (
        (1 - t) ** 3 * (p0 - p1)
        + ((1 + t) ** 3 - 4 * t**3) * (p2 - p1)
        + t**3 * (p3 - p1)
    )


def create_catmull_rom_expression(
    p0: Expression,
    p1: Expression,
    p2: Expression,
    p3: Expression,
    t: Expression,
) -> Expression:
    """Build a Catmull-Rom spline expression."""
    return p1 + t * (
        0.5 * (1 - t) ** 2 * (p1 - p0)
        + (7 / 6 - 1.5 * (t - 2 / 3) ** 2) * (p2 - p1)
        + (0.5 * (t - 0.5) ** 2 - 0.125) * (p3 - p1)
    )


def create_hermite_expression(
    p0: Expression,
    p1: Expression,
    p2: Expression,
    p3: Expression,
    t: Expression,
) -> Expression:
    """Build a cubic Hermite expression."""
    return p0 + t * (
        (1 - t) ** 2 * p1
        + (1.125 - 2 * (t - 0.75) ** 2) * (p2 - p0)
        + ((t - 0.5) ** 2 - 0.25) * p3
    )


def create_linear_expression(
    p0: Expression,
    p1: Expression,
    t: Expression,
) -> Expression:
    """Build a linear interpolation expression."""
    return p0 + t * (p1 - p0)

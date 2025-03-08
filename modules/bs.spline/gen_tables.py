from beet import Context, Function

from bookshelf.helpers import render_snbt


def beet_default(ctx: Context) -> None:
    """Generate lookup tables used by the spline module."""
    ctx.template.add_package(__name__)
    namespace = ctx.directory.name

    with ctx.override(generate_namespace=namespace):
        for kind, generator in [
            ("bezier", gen_bezier_table),
            ("bspline", gen_bspline_table),
            ("catmull_rom", gen_catmull_rom_table),
            ("hermite", gen_hermite_table),
        ]:
            ctx.generate(f"import/{kind}_table",
                kind=kind,
                values=render_snbt(generator()),
                render=Function(source_path="lookup_table.jinja"),
            )


def gen_bezier_table() -> list[tuple[float, float, float, float]]:
    """Generate scaled Bernstein coefficients for the Bezier curve."""
    return [{
        "a": (-t**3+3*t**2-3*t+1) * 1000,
        "b": (3*t**3-6*t**2+3*t) * 1000,
        "c": (-3*t**3+3*t**2) * 1000,
        "d": (t**3) * 1000,
    } for t in (i / 1000 for i in range(1000))]


def gen_bspline_table() -> list[tuple[float, float, float, float]]:
    """Generate scaled Bernstein coefficients for the B-Spline curve."""
    return [{
        "a": (-1*t**3+3*t**2-3*t+1) * 1000 / 6,
        "b": (3*t**3-6*t**2+4) * 1000 / 6,
        "c": (-3*t**3+3*t**2+3*t+1) * 1000 / 6,
        "d": (t**3) * 1000 / 6,
    } for t in (i / 1000 for i in range(1000))]


def gen_catmull_rom_table() -> list[tuple[float, float, float, float]]:
    """Generate scaled Bernstein coefficients for the Catmull-Rom curve."""
    return [{
        "a": (-1*t**3+2*t**2-1*t) * 1000 / 2,
        "b": (3*t**3-5*t**2+2) * 1000 / 2,
        "c": (-3*t**3+4*t**2+t) * 1000 / 2,
        "d": (t**3-t**2) * 1000 / 2,
    } for t in (i / 1000 for i in range(1000))]


def gen_hermite_table() -> list[tuple[float, float, float, float]]:
    """Generate scaled Bernstein coefficients for the Hermite curve."""
    return [{
        "a": (2*t**3-3*t**2+1) * 1000,
        "b": (t**3-2*t**2+t) * 1000,
        "c": (-2*t**3+3*t**2) * 1000,
        "d": (t**3-t**2) * 1000,
    } for t in (i / 1000 for i in range(1000))]

import unicodedata

from beet import Context, Function

from bookshelf.helpers import render_snbt

ITERATION = 8
MAX = 2**ITERATION


def beet_default(ctx: Context) -> None:
    """Generate functions used by the bs.string module."""
    with ctx.override(generate_namespace=ctx.directory.name):
        for a in range(64):
            gen_concat_functions(a+1,ctx)
        for i in range(ITERATION):
            a = (2**(i+1))
            gen_concat_functions(a,ctx)

        ctx.generate("import/char_table",
            upper=render_snbt({chr(c): chr(c).upper() for c in range(0x110000) if chr(c).islower()}),
            lower=render_snbt({chr(c): chr(c).lower() for c in range(0x110000) if chr(c).isupper()}),
            render=Function(source_path="char_table.jinja"),
        )


def gen_concat_functions(n : int ,ctx: Context) -> None:
    """Generate concat functions."""
    ctx.generate(f"concat/pair/{n}",
        a=n,
        max=MAX,
        render=Function(source_path="pair.jinja"),
    )
    ctx.generate(f"concat/join/{n}",
        a=n,
        render=Function(source_path="join.jinja"),
    )

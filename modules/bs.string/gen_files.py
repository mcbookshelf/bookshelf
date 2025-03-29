from beet import Context, Function

from bookshelf.helpers import render_snbt

LOWER_TO_UPPER = {chr(c): chr(c).upper() for c in range(0x110000) if chr(c).islower()}
UPPER_TO_LOWER = {chr(c): chr(c).lower() for c in range(0x110000) if chr(c).isupper()}


def beet_default(ctx: Context) -> None:
    """Generate files used by the bs.string module."""
    with ctx.override(generate_namespace=ctx.directory.name):
        ctx.generate("import/char_table",
            upper=render_snbt(LOWER_TO_UPPER),
            lower=render_snbt(UPPER_TO_LOWER),
            render=Function(source_path="char_table.jinja"),
        )

        for size in {*range(1, 65), 128, 256}:
            ctx.generate(f"concat/join/{size}",
                size=size,
                render=Function(source_path="concat/join.jinja"),
            )
            ctx.generate(f"concat/pair/{size}",
                size=size,
                max=256,
                render=Function(source_path="concat/pair.jinja"),
            )

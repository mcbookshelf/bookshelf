from __future__ import annotations

from beet import Context, Function

LOWER_TO_UPPER = {chr(c): chr(c).upper() for c in range(0x110000) if chr(c).islower()}
UPPER_TO_LOWER = {chr(c): chr(c).lower() for c in range(0x110000) if chr(c).isupper()}


def beet_default(ctx: Context) -> None:
    """Generate files used by the string module."""
    namespace = ctx.directory.name

    args = {"upper": LOWER_TO_UPPER, "lower": UPPER_TO_LOWER}
    func = Function(source_path="char_table.jinja")
    ctx.generate(f"{namespace}:import/char_table", render=func, **args)

    for size in (sizes := {*range(1, 65), 128, 256}):
        args = {"is_max": size == max(sizes), "size": size}
        func = Function(source_path="concat/join.jinja")
        ctx.generate(f"{namespace}:concat/join/{size}", render=func, **args)
        func = Function(source_path="concat/pair.jinja")
        ctx.generate(f"{namespace}:concat/pair/{size}", render=func, **args)

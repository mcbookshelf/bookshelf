from collections.abc import Generator

from beet import Context


def beet_default(ctx: Context) -> Generator:
    """Add commands to import functions from the import folder."""
    yield
    if imports := ctx.data.functions.match(f"{ctx.data.name}:import/*"):
        load = ctx.data.functions[f"{ctx.data.name}:__load__"]
        load.append(("", *(f"function {name}" for name in imports)))

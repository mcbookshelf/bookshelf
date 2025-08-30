from __future__ import annotations

from typing import TYPE_CHECKING

if TYPE_CHECKING:
    from collections.abc import Generator

    from beet import Context


def beet_default(ctx: Context) -> Generator:
    """Inject commands to import functions from the import folder."""
    yield
    # Append "function module:import/*" commands to the __load__ function
    if imports := ctx.data.functions.match(f"{ctx.data.name}:import/*"):
        load = ctx.data.functions[f"{ctx.data.name}:__load__"]
        load.append(("", *(f"function {name}" for name in imports)))

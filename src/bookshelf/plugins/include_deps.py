from __future__ import annotations

from beet import Context, subproject

from bookshelf.definitions import MODULES_DIR


def beet_default(ctx: Context) -> None:
    """Include required dependencies for the current module."""
    for dep in ctx.meta.get("dependencies", []):
        config = {"directory": f"{MODULES_DIR}/{dep}", "extend": "module.json"}
        ctx.require(subproject(config))

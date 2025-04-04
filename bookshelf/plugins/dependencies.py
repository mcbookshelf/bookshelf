from beet import Context, subproject

from bookshelf.definitions import MODULES_DIR


def beet_default(ctx: Context) -> None:
    """Include dependencies in the current module."""
    for dep in ctx.meta.get("dependencies", []) or []:
        config = {"directory": f"{MODULES_DIR}/{dep}", "extend": "module.json"}
        ctx.require(subproject(config))

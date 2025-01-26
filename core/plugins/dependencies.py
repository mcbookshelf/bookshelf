from beet import Context, subproject


def beet_default(ctx: Context) -> None:
    """Include dependencies in the current module."""
    for dep in ctx.meta.get("dependencies", []) or []:
        config = {"directory": f"../{dep}", "extend": "module.json"}
        ctx.require(subproject(config))

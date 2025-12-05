from __future__ import annotations

from beet import Context, Function


def beet_default(ctx: Context) -> None:
    """Generate a __help__ function with its tag for the current module."""
    with ctx.override(generate_namespace=ctx.directory.name):
        ctx.generate(
            "__help__",
            documentation=ctx.meta.get("documentation"),
            module=ctx.directory.name,
            module_name=ctx.meta.get("name"),
            render=Function(source_path="bookshelf/help.jinja"),
        )

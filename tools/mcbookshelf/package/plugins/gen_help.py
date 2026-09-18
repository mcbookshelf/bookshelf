from beet import Context, Function

from mcbookshelf.meta import Module


def beet_default(ctx: Context) -> None:
    module: Module = ctx.meta["module"]
    ctx.generate(
        f"{module.id}:__help__",
        name=module.name,
        documentation=module.documentation,
        namespace=module.id,
        render=Function(source_path="bs/help.jinja"),
    )

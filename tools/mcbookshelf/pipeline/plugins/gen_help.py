from beet import Context, Function

from mcbookshelf.pipeline.config import module_of


def beet_default(ctx: Context) -> None:
    module = module_of(ctx)
    ctx.generate(
        f"{module.id}:__help__",
        name=module.name,
        documentation=module.documentation,
        namespace=module.id,
        render=Function(source_path="bs/help.jinja"),
    )

from collections.abc import Generator

from beet import Context, TagFile

from mcbookshelf.meta import Module


def beet_default(ctx: Context) -> Generator[None]:
    yield

    module: Module = ctx.meta["module"]
    for _, file in ctx.data.all(f"{module.id}:*", extend=TagFile):  # ty: ignore[invalid-argument-type]
        file.set_content({"replace": True, **file.data})

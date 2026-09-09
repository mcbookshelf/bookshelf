from collections.abc import Generator

from beet import Context

from mcbookshelf.meta import Module
from mcbookshelf.workspace import ownership

from . import prune


def beet_default(ctx: Context) -> Generator[None]:
    yield

    module: Module | None = ctx.meta.get("module")
    if module is None or not module.experimental:
        return
    analysis = ownership.analyze(module.id, ownership.pack_files(ctx, module.id))
    dropped = {
        path
        for owner, paths in analysis.files.items()
        if owner.feature in module.experimental
        for path in paths
    }
    prune(ctx.data, lambda path: path not in dropped)
    ctx.meta["ownership"] = analysis.without(dropped)

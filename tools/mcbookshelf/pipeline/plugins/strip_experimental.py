from collections.abc import Generator

from beet import Context

from mcbookshelf import workspace
from mcbookshelf.meta import Module
from mcbookshelf.references import Owner
from mcbookshelf.workspace import ownership

from . import prune


def beet_default(ctx: Context) -> Generator[None]:
    yield

    module: Module | None = ctx.meta.get("module")
    if module is None or not module.experimental:
        return
    files = ownership.pack_files(ctx, module.id)
    analysis = ownership.analyze(workspace.current(), module.id, files)
    stable = {Owner(module.id, name) for name in module.names - module.experimental}
    used = {group for owner in stable for group in analysis.parents(owner)}
    dropped = {
        path
        for owner, paths in analysis.files.items()
        if owner.feature and owner not in stable and owner not in used
        for path in paths
    }
    prune(ctx.data, lambda path: path not in dropped)

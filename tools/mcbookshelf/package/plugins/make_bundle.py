from beet import Context, PngFile

from mcbookshelf import workspace
from mcbookshelf.package.config import module_config

from . import include


def beet_default(ctx: Context) -> None:
    for member in ctx.meta["members"]:
        include(ctx, module_config(member, ctx.meta["build"].nested))
    if ctx.project_id in workspace.bundles():
        icon = workspace.directory(ctx.project_id) / "pack.png"
        if icon.is_file():
            ctx.data.icon = PngFile(source_path=icon)

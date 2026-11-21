from beet import Context, PngFile

from mcbookshelf import workspace
from mcbookshelf.pipeline.config import build_of, members_of, module_config

from . import include


def beet_default(ctx: Context) -> None:
    for member in members_of(ctx):
        include(ctx, module_config(member, build_of(ctx).nested))
    ws = workspace.current()
    if ctx.project_id in ws.bundles():
        icon = ws.directory(ctx.project_id) / "pack.png"
        if icon.is_file():
            ctx.data.icon = PngFile(source_path=icon)

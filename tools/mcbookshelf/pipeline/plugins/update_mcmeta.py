from collections.abc import Generator

from beet import Context

from mcbookshelf.minecraft import fetch_version


def beet_default(ctx: Context) -> Generator[None]:
    yield

    if ctx.project_root:
        versions = fetch_version(ctx.cache["version"])

        ctx.assets.description = ctx.project_description
        ctx.assets.min_format = ctx.assets.max_format = versions["resource_pack_version"]

        ctx.data.description = ctx.project_description
        ctx.data.min_format = ctx.data.max_format = versions["data_pack_version"]
        data = ctx.data.mcmeta.data
        ctx.data.mcmeta.set_content({"id": ctx.project_id, **data})

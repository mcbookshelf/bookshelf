from collections.abc import Generator

import orjson
from beet import Context

from mcbookshelf import constants

MCMETA_URL = "https://raw.githubusercontent.com/misode/mcmeta/refs/tags/{}-summary/version.json"


def beet_default(ctx: Context) -> Generator[None]:
    yield

    if ctx.project_root:
        cache = ctx.cache[f"version/{constants.GAME_VERSION}"]
        file = cache.download(MCMETA_URL.format(constants.GAME_VERSION))
        formats = orjson.loads(file.read_bytes())

        ctx.assets.description = ctx.project_description
        ctx.assets.min_format = ctx.assets.max_format = formats["resource_pack_version"]

        ctx.data.description = ctx.project_description
        ctx.data.min_format = ctx.data.max_format = formats["data_pack_version"]
        data = ctx.data.mcmeta.data
        ctx.data.mcmeta.set_content({"id": ctx.project_id, **data})

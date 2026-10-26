from collections.abc import Generator
from typing import Any

import orjson
from beet import Cache, Context

from mcbookshelf import constants

MCMETA_URL = "https://raw.githubusercontent.com/misode/mcmeta/refs/tags/{}-summary/version.json"


def beet_default(ctx: Context) -> Generator[None]:
    yield

    if ctx.project_root:
        versions = formats(ctx.cache["version"])

        ctx.assets.description = ctx.project_description
        ctx.assets.min_format = ctx.assets.max_format = versions["resource_pack_version"]

        ctx.data.description = ctx.project_description
        ctx.data.min_format = ctx.data.max_format = versions["data_pack_version"]
        data = ctx.data.mcmeta.data
        ctx.data.mcmeta.set_content({"id": ctx.project_id, **data})


def formats(cache: Cache) -> dict[str, Any]:
    """The pack formats of the game version."""
    return orjson.loads(cache.download(MCMETA_URL.format(constants.GAME_VERSION)).read_bytes())

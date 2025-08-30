from __future__ import annotations

from typing import TYPE_CHECKING

from bookshelf.common import json
from bookshelf.models import Biome, Collection

from .utils import cache_version

if TYPE_CHECKING:
    from beet import Context

BIOMES_URL = "https://raw.githubusercontent.com/misode/mcmeta/{}-summary/data/worldgen/biome/data.min.json"


@cache_version("biomes", Collection[Biome])
def get_biomes(ctx: Context, version: str) -> Collection[Biome]:
    """Retrieve biomes for the provided version."""
    cache = ctx.cache[f"version/{version}"]
    raw = json.load(cache.download(BIOMES_URL.format(version)), dict)

    return Collection(root=[Biome(
        type=f"minecraft:{name}",
        temperature=data["temperature"],
        has_precipitation=data["has_precipitation"],
    ) for name, data in raw.items()])

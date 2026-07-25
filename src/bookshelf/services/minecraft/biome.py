from __future__ import annotations

import httpx

from bookshelf.common import json
from bookshelf.models import Biome, Collection

from .utils import cache_version

BIOMES_URL = "https://raw.githubusercontent.com/misode/mcmeta/{}-summary/data/worldgen/biome/data.min.json"


@cache_version("biomes", Collection[Biome])
def get_biomes(version: str) -> Collection[Biome]:
    """Retrieve biomes for the provided version."""
    response = httpx.get(BIOMES_URL.format(version))
    response.raise_for_status()
    raw = json.load(response.content, dict)

    return Collection(root=[Biome(
        type=f"minecraft:{name}",
        temperature=data["temperature"],
        has_precipitation=data["has_precipitation"],
    ) for name, data in raw.items()])

from typing import Any

from beet import Cache

from mcbookshelf import constants
from mcbookshelf.downloads import download, read_json

MCDATA_URL = "https://raw.githubusercontent.com/mcbookshelf/mcdata/refs/tags/v1/{version}/{name}/data.min.json"
MCMETA_URL = "https://raw.githubusercontent.com/misode/mcmeta/refs/tags/{}-summary/version.json"


def fetch_blocks(cache: Cache, version: str = constants.GAME_VERSION) -> Any:  # noqa: ANN401
    """The raw blocks of a Minecraft version, downloaded once into the cache."""
    return _fetch_mcdata(cache, "blocks", version)


def fetch_entities(cache: Cache, version: str = constants.GAME_VERSION) -> Any:  # noqa: ANN401
    """The raw entities of a Minecraft version, downloaded once into the cache."""
    return _fetch_mcdata(cache, "entities", version)


def fetch_version(cache: Cache) -> dict[str, Any]:
    """The version file of mcmeta for the game version, which holds its pack formats."""
    return download(cache, MCMETA_URL.format(constants.GAME_VERSION), read_json)


def _fetch_mcdata(cache: Cache, name: str, version: str) -> Any:  # noqa: ANN401
    return download(cache, MCDATA_URL.format(version=version, name=name), read_json)

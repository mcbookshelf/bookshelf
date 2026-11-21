from typing import Any

import orjson
from beet import Cache

from mcbookshelf import constants

URL = "https://raw.githubusercontent.com/mcbookshelf/mcdata/refs/tags/v1/{version}/{name}/data.min.json"


def fetch(cache: Cache, name: str, version: str = constants.GAME_VERSION) -> Any:  # noqa: ANN401
    """An mcdata file, as `entities`, downloaded once into the cache."""
    url = URL.format(version=version, name=name)
    path = cache.get_path(url)
    try:
        return orjson.loads(cache.download(url, path).read_bytes())
    except Exception:
        path.unlink(missing_ok=True)
        raise

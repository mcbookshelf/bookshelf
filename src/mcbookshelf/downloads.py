import json
from collections.abc import Callable
from importlib.metadata import version as package_version
from pathlib import Path
from typing import Any

from beet import Cache

USER_AGENT = f"mcbookshelf/bookshelf/{package_version('mcbookshelf')}"


def download[T](
    cache: Cache,
    url: str,
    read: Callable[[Path], T],
    path: Path | None = None,
) -> T:
    """Read a file downloaded once into the cache, which forgets it when it cannot be read."""
    path = path or cache.get_path(url)
    try:
        return read(cache.download(url, path, headers={"User-Agent": USER_AGENT}))
    except Exception:
        path.unlink(missing_ok=True)
        raise


def read_json(path: Path) -> Any:  # noqa: ANN401
    return json.loads(path.read_text("utf-8"))

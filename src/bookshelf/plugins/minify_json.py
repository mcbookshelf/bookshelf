from __future__ import annotations

from typing import TYPE_CHECKING

import orjson
from beet import JsonFileBase

if TYPE_CHECKING:
    from collections.abc import Generator

    from beet import Context


def beet_default(ctx: Context) -> Generator:
    """Configure beet for building Bookshelf modules."""
    yield
    for pack in ctx.packs:
        for _, file in pack.list_files(extend=JsonFileBase):
            file.encoder = lambda obj: orjson.dumps(obj).decode()
            file.decoder = lambda obj: orjson.loads(obj.encode())
            file.ensure_serialized()

from collections.abc import Generator
from typing import Any

import orjson
from beet import Context, JsonFileBase


def beet_default(ctx: Context) -> Generator[None]:
    yield

    for pack in ctx.packs:
        for _, file in pack.list_files(extend=JsonFileBase[dict[str, Any]]):
            file.decoder = lambda obj: orjson.loads(obj.encode())
            file.encoder = lambda obj: orjson.dumps(obj).decode()
            file.set_content(file.data)
            file.ensure_serialized()

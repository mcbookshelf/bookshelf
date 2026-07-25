from __future__ import annotations

import json
from functools import cache
from typing import TYPE_CHECKING

from beet import Context, PngFile, subproject

from bookshelf.definitions import MODULES, MODULES_DIR

if TYPE_CHECKING:
    from collections.abc import Callable

__path__ = ()


def beet_default(ctx: Context) -> None:
    """Include all modules."""
    for mod in MODULES:
        ctx.require(subproject({
            "directory": f"{MODULES_DIR}/{mod}",
            "extend": "module.json",
            "meta": ctx.meta,
        }))
    ctx.data.icon = PngFile(source_path=ctx.directory / "pack.png")


@cache
def __getattr__(tag: str) -> Callable[[Context], None]:
    def plugin(ctx: Context) -> None:
        """Include modules that have the given tag."""
        for mod in MODULES:
            meta = json.loads((MODULES_DIR / mod / "module.json").read_text("utf-8"))
            if tag in meta.get("meta", {}).get("tags", []):
                ctx.require(subproject({
                    "directory": f"{MODULES_DIR}/{mod}",
                    "extend": "module.json",
                    "meta": ctx.meta,
                }))
        ctx.data.icon = PngFile(source_path=ctx.directory / "pack.png")
    return plugin

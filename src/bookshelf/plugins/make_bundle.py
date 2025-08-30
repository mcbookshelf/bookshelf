from __future__ import annotations

import json
from functools import cache
from typing import TYPE_CHECKING

from beet import Context, subproject

from bookshelf.definitions import MODULES, MODULES_DIR

if TYPE_CHECKING:
    from collections.abc import Callable

__path__ = ()


def beet_default(ctx: Context) -> None:
    """Include all modules."""
    for mod in MODULES:
        config = {"directory": f"{MODULES_DIR}/{mod}", "extend": "module.json"}
        ctx.require(subproject(config))


@cache
def __getattr__(tag: str) -> Callable[[Context], None]:
    def plugin(ctx: Context) -> None:
        """Include modules that have the given tag."""
        for mod in MODULES:
            meta = json.loads((MODULES_DIR / mod / "module.json").read_text("utf-8"))
            if tag in meta.get("meta", {}).get("tags", []):
                config = {"directory": f"{MODULES_DIR}/{mod}", "extend": "module.json"}
                ctx.require(subproject(config))
    return plugin

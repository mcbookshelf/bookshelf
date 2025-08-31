from __future__ import annotations

from functools import cache
from typing import TYPE_CHECKING

from beet import Context, subproject

from bookshelf.definitions import MODULES_DIR

if TYPE_CHECKING:
    from collections.abc import Callable

__path__ = ()


@cache
def __getattr__(name: str) -> Callable[[Context], None]:
    def plugin(ctx: Context) -> None:
        """Require a bundle of modules."""
        config = {"directory": f"{MODULES_DIR}/@{name}", "extend": "module.json"}
        ctx.require(subproject(config))
    return plugin

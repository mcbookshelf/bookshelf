from collections.abc import Callable
from functools import cache

from beet import Context, subproject

from bookshelf.definitions import MODULES_DIR

__path__ = ""

@cache
def __getattr__(name: str) -> Callable[[Context], None]:
    def plugin(ctx: Context) -> None:
        """Require a bundle of modules."""
        config = {"directory": f"{MODULES_DIR}/@{name}", "extend": "module.json"}
        ctx.require(subproject(config))
    return plugin

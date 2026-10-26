from collections.abc import Callable
from functools import cache

from beet import Context

from mcbookshelf.releases import Releases

__path__: list[str] = []


@cache
def __getattr__(name: str) -> Callable[[Context], None]:
    def plugin(ctx: Context) -> None:
        """Merge the module into the project."""
        ctx.data.merge(ctx.inject(Releases).module(f"bs.{name}"))

    return plugin

from __future__ import annotations

from typing import TYPE_CHECKING

if TYPE_CHECKING:
    from collections.abc import Generator

    from beet import Context


def beet_default(ctx: Context) -> Generator:
    """Inject a command to register the module in the bookshelf log namespace."""
    yield
    # Only add if the module depends on bs.log to avoid extra noise
    if "bs.log" in [
        *ctx.meta.get("dependencies", []),
        *ctx.meta.get("weak_dependencies", []),
    ]:
        load = ctx.data.functions[f"{ctx.directory.name}:__load__"]
        load.append(ctx.template.render(
            "bookshelf/log.jinja",
            module=ctx.directory.name,
        ))

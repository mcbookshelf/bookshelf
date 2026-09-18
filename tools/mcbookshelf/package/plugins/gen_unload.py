from beet import Context

from mcbookshelf.meta import Module

from . import ensure_function


def beet_default(ctx: Context) -> None:
    module: Module = ctx.meta["module"]
    function = ensure_function(ctx, f"{module.id}:__unload__")
    present = {line.strip() for line in function.lines}
    lines = {
        f"data remove storage {storage.id} {entry.name}"
        for storage in module.storages.values()
        for entry in storage.struct.entries
    }
    function.lines.extend(("", *sorted(lines - present)))

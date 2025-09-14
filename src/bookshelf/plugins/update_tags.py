from __future__ import annotations

from typing import TYPE_CHECKING

from beet import Context, TagFile

if TYPE_CHECKING:
    from collections.abc import Generator


def beet_default(ctx: Context) -> Generator:
    """Add `"replace": true` to all tags in the current module."""
    yield

    for _, file in ctx.data.all(f"{ctx.directory.name}:*", extend=TagFile):
        # Insert "replace": true before the "values" key to preserve order
        pos = list(file.data.keys()).index("values")
        items = list(file.data.items())
        items.insert(pos, ("replace", True))
        file.set_content(dict(items))

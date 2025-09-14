from __future__ import annotations

from datetime import datetime, timezone
from typing import TYPE_CHECKING

from bookshelf.services.minecraft import render_snbt

if TYPE_CHECKING:
    from beet import Context


def beet_default(ctx: Context) -> None:
    """Configure beet for building Bookshelf modules."""
    ctx.template.add_package("bookshelf")
    ctx.template.globals["year"] = datetime.now(timezone.utc).year
    ctx.template.expose("render_snbt", render_snbt)
    ctx.require("beet.contrib.inline_function_tag")

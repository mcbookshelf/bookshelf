from datetime import datetime

from beet import Context


def beet_default(ctx: Context) -> None:
    """Configure the Jinja template engine with necessary functions."""
    ctx.require("beet.contrib.inline_function_tag")
    ctx.template.add_package("core")
    ctx.template.expose("now", datetime.now)

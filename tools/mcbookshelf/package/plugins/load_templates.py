from beet import Context

from mcbookshelf.templates import year


def beet_default(ctx: Context) -> None:
    ctx.require("beet.contrib.inline_function_tag")
    ctx.template.add_package("mcbookshelf", prefix="bs")
    ctx.template.globals["year"] = year()

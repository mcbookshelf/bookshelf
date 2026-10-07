from datetime import UTC, datetime

from beet import Context


def beet_default(ctx: Context) -> None:
    ctx.require("beet.contrib.inline_function_tag")
    ctx.template.add_package("mcbookshelf", prefix="bs")
    ctx.template.globals["year"] = datetime.now(UTC).year

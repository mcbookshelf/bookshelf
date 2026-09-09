from beet import Context, TestEnvironment
from mcward.beet.plugin import TestFunction

from mcbookshelf.meta import Module


def beet_default(ctx: Context) -> None:
    if TestFunction not in ctx.data.extend_namespace:
        return

    module: Module = ctx.meta["module"]
    default = TestEnvironment({"type": "minecraft:function"})
    env = f"{module.id}:default"
    ctx.data.test_environments.setdefault(env, default)

    for name, test in ctx.data[TestFunction].items():
        if name.startswith(f"{module.id}:"):
            lines = test.text.split("\n")
            if not any(line.startswith("# @environment") for line in lines):
                lines.insert(header_size(lines), f"# @environment {env}")
                test.set_content("\n".join(lines))


def header_size(lines: list[str]) -> int:
    for index, line in enumerate(lines):
        if line.strip() and (not line.startswith("#") or line.startswith("# @")):
            return index
    return len(lines)

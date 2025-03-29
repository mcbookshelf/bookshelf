from collections.abc import Generator
from typing import ClassVar

from beet import Context, Function, JsonFile, NamespaceFileScope, TextFile

from bookshelf.definitions import VERSION


class TestEnvironment(JsonFile):
    """Represents a Minecraft Test Environment file."""

    scope: ClassVar[NamespaceFileScope] = ("test_environment",)
    extension: ClassVar[str] = ".json"


class TestFunction(TextFile):
    """Represents a PackTest Minecraft function file."""

    scope: ClassVar[NamespaceFileScope] = ("test",)
    extension: ClassVar[str] = ".mcfunction"


def beet_default(ctx: Context) -> Generator:
    """Include test functions from the test folder."""
    ctx.data.extend_namespace.append(TestEnvironment)
    ctx.data.extend_namespace.append(TestFunction)
    yield
    module = ctx.directory.name[3:]
    env = f"# @environment bs.load:{module}\n"
    header = ctx.template.render("bookshelf/header.jinja")
    offset = len(header)
    count = 0

    for _, file in ctx.data.all(extend=TestFunction):
        count += 1
        file.set_content(f"{file.text[:offset]}{env}{file.text[offset:]}")

    if count > 0:
        ctx.data[f"bs.load:v{VERSION}/test/{module}"] = Function([
            header,
            "function #bs.load:unload",
            f"function #bs.load:module/{module}",
            "forceload add 0 0",
        ])

        ctx.data[f"bs.load:{module}"] = TestEnvironment({
            "type": "minecraft:function",
            "setup": f"bs.load:v{VERSION}/test/{module}",
        })

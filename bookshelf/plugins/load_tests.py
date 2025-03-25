from collections.abc import Generator
from typing import ClassVar

from beet import Context, Function, JsonFile, NamespaceFileScope, TextFile


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
    env = f"# @environment {ctx.directory.name}:default\n"
    header = ctx.template.render("bookshelf/header.jinja")
    offset = len(header)

    for _, file in ctx.data.all(extend=TestFunction):
        file.set_content(f"{file.text[:offset]}{env}{file.text[offset:]}")

    ctx.data[f"{ctx.directory.name}:__test__"] = Function([
        header,
        "function #bs.load:unload",
        f"function #{ctx.directory.name}:load",
    ])

    ctx.data[f"{ctx.directory.name}:default"] = TestEnvironment({
        "type": "minecraft:function",
        "setup": f"{ctx.directory.name}:__test__",
    })

from collections.abc import Generator
from typing import ClassVar

from beet import Context, NamespaceFileScope, TextFile


class TestFunction(TextFile):
    """Represents a PackTest Minecraft function file."""

    scope: ClassVar[NamespaceFileScope] = ("test",)
    extension: ClassVar[str] = ".mcfunction"


def beet_default(ctx: Context) -> Generator:
    """Include test functions from the test folder."""
    ctx.data.extend_namespace.append(TestFunction)
    yield
    batch = f"# @batch {ctx.directory.name}\n"
    header = ctx.template.render("core/header.jinja")
    offset = len(header)

    for _, file in ctx.data.all(extend=TestFunction):
        file.set_content(f"{file.text[:offset]}{batch}{file.text[offset:]}")

    with ctx.override(generate_namespace=ctx.directory.name):
        ctx.generate("__setup__", TestFunction(
            f"{header}{batch}"
            f"# @beforebatch "
            f'function #bs.load:exclusive {{module:"{ctx.directory.name}"}}',
        ))

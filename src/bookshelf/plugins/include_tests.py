from __future__ import annotations

from typing import ClassVar

from beet import Context, NamespaceFile, NamespaceFileScope, TextFileBase


class TestFunction(TextFileBase, NamespaceFile):
    """Represents a PackTest Minecraft function file."""

    scope: ClassVar[NamespaceFileScope] = ("test",)
    extension: ClassVar[str] = ".mcfunction"


def beet_default(ctx: Context) -> None:
    """Include test functions from the test folder."""
    ctx.data.extend_namespace.append(TestFunction)

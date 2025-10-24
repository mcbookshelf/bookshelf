from __future__ import annotations

import re
from typing import TYPE_CHECKING, ClassVar

from beet import (
    Context,
    Function,
    JsonFile,
    NamespaceFile,
    NamespaceFileScope,
    TestEnvironment,
)

from bookshelf.definitions import VERSION

if TYPE_CHECKING:
    from collections.abc import Generator


PERSISTENT_ENTITY_UUID = re.compile(r"B5-0-0-0-\d+")


class TestFunction(JsonFile, NamespaceFile):
    """Represents a PackTest Minecraft function file."""

    scope: ClassVar[NamespaceFileScope] = ("test",)
    extension: ClassVar[str] = ".mcfunction"


def beet_default(ctx: Context) -> Generator:
    """Include test functions from the test folder."""
    ctx.require("bookshelf.plugins.setup_templates")
    ctx.data.extend_namespace.append(TestFunction)
    yield

    module = ctx.directory.name[3:]
    environment = f"# @environment bs.load:{module}\n"
    # Render header once and compute offset for inserting environment tag
    header = ctx.template.render("bookshelf/header.jinja")
    offset = len(header)
    count = 0

    # Insert environment tag after header for all test files
    for _, file in ctx.data.all(extend=TestFunction):
        count += 1
        file.set_content(f"{file.text[:offset]}{environment}{file.text[offset:]}")

    if count > 0:
        load = ctx.data.functions.get(f"{ctx.data.name}:__load__")
        load_content = load.get_content() if load is not None else []
        entities = {m for i in load_content for m in PERSISTENT_ENTITY_UUID.findall(i)}
        # Create a function that loads the test module with some setup commands
        ctx.data.functions[f"bs.load:v{VERSION}/test/{module}"] = Function([
            header,
            "function #bs.load:unload",
            f"function #bs.load:module/{module}",
            "",
            "forceload add 0 0",
            *(f"await entity {entity}" for entity in entities),
        ])
        # Register the test environment to run the setup function
        ctx.data.test_environments[f"bs.load:{module}"] = TestEnvironment({
            "type": "minecraft:function",
            "setup": f"bs.load:v{VERSION}/test/{module}",
        })

from __future__ import annotations

import re

from beet import Context, Function, FunctionTag, TestEnvironment
from semver import Version

from bookshelf.definitions import MODULES, VERSION
from bookshelf.plugins.include_tests import TestFunction

PERSISTENT_ENTITY_UUID = re.compile(r"B5-0-0-0-\d+")


def beet_default(ctx: Context) -> None:
    """Generate load-related functions and tags for the current module."""
    version = Version.parse(VERSION)
    module = ctx.directory.name[3:]

    ctx.require("beet.contrib.lantern_load.base_data_pack")
    ctx.data.function_tags.setdefault("load:load", FunctionTag()).add("#bs.load:load")

    # Generate versioned load functions from templates
    for file, template in [
        (f"resolve/{module}", "process/resolve"),
        (f"v{VERSION}/bundle/append", "bundle/append"),
        (f"v{VERSION}/bundle/concat", "bundle/concat"),
        (f"v{VERSION}/cleanup", "process/cleanup"),
        (f"v{VERSION}/enumerate/{module}", "process/enumerate"),
        (f"v{VERSION}/errors/{module}", "process/errors"),
        (f"v{VERSION}/validate", "process/validate"),
        (f"v{VERSION}/status/status", "status/status"),
        (f"v{VERSION}/status/module", "status/module"),
    ]:
        ctx.generate(
            f"bs.load:{file}",
            version=version,
            module=ctx.directory.name,
            modules=MODULES,
            render=Function(source_path=f"bookshelf/load/{template}.jinja"),
        )

    ctx.generate(
        f"bs.load:v{VERSION}/enumerate/load",
        version=version,
        module="bs.load",
        render=Function(source_path="bookshelf/load/process/enumerate.jinja"),
    )

    # Generate load/unload/module tags
    ctx.data.function_tags["bs.load:load"] = gen_load_tag(MODULES)
    ctx.data.function_tags["bs.load:unload"] = gen_unload_tag(MODULES)
    ctx.data.function_tags[f"bs.load:module/{module}"] = gen_module_load_tag(
        ctx.directory.name,
        ctx.meta.get("dependencies", []) or [],
        ctx.meta.get("weak_dependencies", []) or [],
    )

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


def gen_load_tag(modules: list[str]) -> FunctionTag:
    """Generate a tag to load all modules."""
    return FunctionTag({
        "values": [
            "#bs.load:process/cleanup",
            "#bs.load:process/enumerate",
            "#bs.load:process/resolve",
            "#bs.load:process/validate",
        ] + [
            {"id": f"#bs.load:module/{mod[3:]}", "required": False}
            for mod in modules
        ],
    })


def gen_unload_tag(modules: list[str]) -> FunctionTag:
    """Generate a tag to unload all modules."""
    return FunctionTag({
        "values": [
            {"id": f"{mod}:__unload__", "required": False}
            for mod in modules
        ],
    })


def gen_module_load_tag(
    module: str,
    dependencies: list[str],
    weak_dependencies: list[str],
) -> FunctionTag:
    """Generate a tag for a module and its dependencies."""
    return FunctionTag({
        "replace": True,
        "values": [
            # Required dependencies
            f"#bs.load:module/{dep[3:]}"
            for dep in dependencies
        ] + [
            # Optional weak dependencies
            {"id": f"#bs.load:module/{dep[3:]}", "required": False}
            for dep in weak_dependencies
        ] + [
            # The module's own __load__ function
            f"{module}:__load__",
        ],
    })

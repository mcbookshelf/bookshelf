from beet import Context, Function, FunctionTag

from bookshelf.definitions import MODULES, VERSION
from bookshelf.helpers import parse_version


def beet_default(ctx: Context) -> None:
    """Generate load related functions for the current module."""
    version = parse_version(VERSION)
    module = ctx.directory.name[3:]

    ctx.require("beet.contrib.lantern_load.base_data_pack")
    ctx.data.function_tags.setdefault("load:load", FunctionTag()).add("#bs.load:load")

    for file, template in [
        (f"resolve/{module}", "process/resolve"),
        (f"v{VERSION}/bundle/append", "bundle/append"),
        (f"v{VERSION}/bundle/concat", "bundle/concat"),
        (f"v{VERSION}/cleanup", "process/cleanup"),
        (f"v{VERSION}/validate", "process/validate"),
        (f"v{VERSION}/enumerate/{module}", "process/enumerate"),
        (f"v{VERSION}/errors/{module}", "process/errors"),
    ]:
        ctx.generate(
            f"bs.load:{file}",
            **version,
            module=ctx.directory.name,
            modules=MODULES,
            render=Function(source_path=f"bookshelf/load/{template}.jinja"),
        )

    ctx.generate(
        f"bs.load:v{VERSION}/enumerate/load",
        **version,
        module="bs.load",
        render=Function(source_path="bookshelf/load/process/enumerate.jinja"),
    )

    ctx.data["bs.load:load"] = gen_load_tag(MODULES)
    ctx.data["bs.load:unload"] = gen_unload_tag(MODULES)

    ctx.data[f"bs.load:module/{module}"] = gen_module_load_tag(
        ctx.directory.name,
        ctx.meta.get("dependencies", []) or [],
        ctx.meta.get("weak_dependencies", []) or [],
    )


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
            f"#bs.load:module/{dep[3:]}"
            for dep in dependencies
        ] + [
            {"id": f"#bs.load:module/{dep[3:]}", "required": False}
            for dep in weak_dependencies
        ] + [
            f"{module}:__load__",
        ],
    })

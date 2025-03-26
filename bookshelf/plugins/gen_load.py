from beet import Context, Function, FunctionTag

from bookshelf.definitions import MODULES, VERSION
from bookshelf.helpers import parse_version


def beet_default(ctx: Context) -> None:
    """Generate load related functions for the current module."""
    version = parse_version(VERSION)

    ctx.require("beet.contrib.lantern_load.base_data_pack")
    ctx.data.function_tags.setdefault("load:load", FunctionTag()).add("#bs.load:load")

    for file, template in [
        ("validate", "validate"),
        (f"resolve/{ctx.directory.name}", "steps/resolve"),
        (f"v{VERSION}/bundle/append", "bundle/append"),
        (f"v{VERSION}/bundle/concat", "bundle/concat"),
        (f"v{VERSION}/cleanup", "steps/cleanup"),
        (f"v{VERSION}/errors/{ctx.directory.name}", "errors"),
        (f"v{VERSION}/enumerate/{ctx.directory.name}", "steps/enumerate"),
    ]:
        ctx.generate(
            f"bs.load:{file}",
            **version,
            module=ctx.directory.name,
            modules=MODULES,
            render=Function(source_path=f"bookshelf/load/{template}.jinja"),
        )

    ctx.data["bs.load:load"] = gen_load_tag(MODULES)
    ctx.data["bs.load:unload"] = gen_unload_tag(MODULES)

    for kind in ["load", "unload"]:
        ctx.data[f"{ctx.data.name}:{kind}"] = gen_module_tag(
            kind,
            ctx.directory.name,
            ctx.meta.get("dependencies", []) or [],
            ctx.meta.get("weak_dependencies", []) or [],
        )


def gen_load_tag(modules: list[str]) -> FunctionTag:
    """Generate a tag to load all modules."""
    return FunctionTag({
        "values": [
            "#bs.load:steps/cleanup",
            "#bs.load:steps/enumerate",
            "#bs.load:steps/resolve",
            "bs.load:validate",
        ] + [
            {"id": f"#{mod}:load", "required": False}
            for mod in modules
        ],
    })


def gen_unload_tag(modules: list[str]) -> FunctionTag:
    """Generate a tag to unload all modules."""
    return FunctionTag({
        "values": [
            {"id": f"#{mod}:unload", "required": False}
            for mod in modules
        ],
    })


def gen_module_tag(
    kind: str,
    module: str,
    dependencies: list[str],
    weak_dependencies: list[str],
) -> FunctionTag:
    """Generate a tag for a module and its dependencies."""
    return FunctionTag({
        "replace": True,
        "values": [
            f"#{dep}:{kind}"
            for dep in dependencies
        ] + [
            {"id": f"#{dep}:{kind}", "required": False}
            for dep in weak_dependencies
        ] + [
            f"{module}:__{kind}__",
        ],
    })

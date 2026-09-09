from beet import Context, Function, FunctionTag

from mcbookshelf import constants, workspace
from mcbookshelf.meta import Module, parse_version
from mcbookshelf.workspace import dependencies

from . import ensure_function, ensure_function_tag

LOADER = constants.LOADER_VERSION

STEPS = (
    "cleanup",
    "enumerate",
    "resolve",
    "validate",
)

TEMPLATES = (
    "cleanup",
    "validate",
    "bundle/append",
    "bundle/concat",
    "status/status",
    "status/module",
)


def beet_default(ctx: Context) -> None:
    ctx.require("beet.contrib.lantern_load.base_data_pack")

    module: Module = ctx.meta["module"]
    short, version = module.short, module.version

    ensure_function(ctx, f"{module.id}:__load__")
    ensure_function_tag(ctx, "load:load").add("#bs.load:load")

    for path in TEMPLATES:
        render(ctx, f"v{LOADER}/{path}", path, "bs.load", LOADER)

    render(ctx, f"resolve/{short}", "resolve", module.id, module.version)
    render(ctx, f"enumerate/{short}/v{version}", "enumerate", module.id, version)
    render(ctx, f"enumerate/load/v{LOADER}", "enumerate", "bs.load", LOADER)
    render(ctx, f"v{LOADER}/errors/{short}", "errors", module.id, LOADER)

    tags = ctx.data.function_tags
    strong, weak = dependencies.strong(module.id), dependencies.weak(module.id)
    tags[f"bs.load:module/{short}"] = module_tag(module.id, sorted(strong), sorted(weak))
    tags["bs.load:load"] = load_tag(workspace.modules())
    tags["bs.load:unload"] = unload_tag(workspace.modules())


def module_tag(namespace: str, strong: list[str], weak: list[str]) -> FunctionTag:
    return FunctionTag({
        "replace": True,
        "values": [
            *(f"#bs.load:module/{d[3:]}" for d in strong),
            *({"id": f"#bs.load:module/{d[3:]}", "required": False} for d in weak),
            f"{namespace}:__load__",
        ],
    })


def load_tag(modules: tuple[str, ...]) -> FunctionTag:
    return FunctionTag({
        "values": [
            *(f"#bs.load:process/{s}" for s in STEPS),
            *({"id": f"#bs.load:module/{m[3:]}", "required": False} for m in modules),
        ],
    })


def unload_tag(modules: tuple[str, ...]) -> FunctionTag:
    return FunctionTag({
        "values": [
            {"id": f"{m}:__unload__", "required": False} for m in modules
        ],
    })


def render(ctx: Context, path: str, template: str, module: str, version: str) -> None:
    major, minor, patch = parse_version(version)
    ctx.generate(
        f"bs.load:{path}",
        render=Function(source_path=f"bs/load/{template}.jinja"),
        module=module,
        version=version,
        loader=LOADER,
        major=major,
        minor=minor,
        patch=patch,
    )

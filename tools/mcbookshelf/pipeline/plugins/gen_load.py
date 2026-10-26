from beet import Context, Function, FunctionTag

from mcbookshelf import constants, workspace
from mcbookshelf.meta.model import short
from mcbookshelf.pipeline.config import module_of
from mcbookshelf.version import Version
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

    ws = workspace.current()
    module = module_of(ctx)
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
    strong, weak = dependencies.strong(ws, module.id), dependencies.weak(ws, module.id)
    loads, unloads = (_nested(ctx, module.id, hook) for hook in ("__load__", "__unload__"))
    tags[f"bs.load:module/{short}"] = module_tag(module.id, sorted(strong), sorted(weak), loads)
    tags[f"bs.load:unload/{short}"] = hooks_tag(f"{module.id}:__unload__", unloads)
    tags["bs.load:load"] = load_tag(ws.modules())
    tags["bs.load:unload"] = unload_tag(ws.modules())


def module_tag(
    namespace: str,
    strong: list[str],
    weak: list[str],
    loads: list[str],
) -> FunctionTag:
    """Load the dependencies, then the module, then its features and groups."""
    return FunctionTag({
        "replace": True,
        "values": [
            *(f"#bs.load:module/{short(d)}" for d in strong),
            *({"id": f"#bs.load:module/{short(d)}", "required": False} for d in weak),
            *hooks_tag(f"{namespace}:__load__", loads).data["values"],
        ],
    })


def hooks_tag(root: str, nested: list[str]) -> FunctionTag:
    """The hook of the module, then those of its features and groups, left out when pruned."""
    return FunctionTag({
        "replace": True,
        "values": [root, *({"id": key, "required": False} for key in nested)],
    })


def _nested(ctx: Context, namespace: str, hook: str) -> list[str]:
    """The hooks of the module's features and groups: `<folder>/__load__`, at any depth."""
    return sorted(
        key for key in ctx.data.functions
        if key.startswith(f"{namespace}:") and key.endswith(f"/{hook}")
    )


def load_tag(modules: tuple[str, ...]) -> FunctionTag:
    return FunctionTag({
        "values": [
            *(f"#bs.load:process/{s}" for s in STEPS),
            *({"id": f"#bs.load:module/{short(m)}", "required": False} for m in modules),
        ],
    })


def unload_tag(modules: tuple[str, ...]) -> FunctionTag:
    return FunctionTag({
        "values": [
            {"id": f"#bs.load:unload/{short(m)}", "required": False} for m in modules
        ],
    })


def render(ctx: Context, path: str, template: str, module: str, version: str) -> None:
    major, minor, patch = Version.parse(version)
    ctx.generate(
        f"bs.load:{path}",
        render=Function(source_path=f"bs/load/{template}.jinja"),
        module=module,
        short=short(module),
        version=version,
        loader=LOADER,
        major=major,
        minor=minor,
        patch=patch,
    )

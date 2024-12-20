from beet import Context, Function, FunctionTag

from core.definitions import MODULES, VERSION


def beet_default(ctx: Context) -> None:
    """Generate load related functions for the current module."""
    version = parse_version(VERSION)

    ctx.require("beet.contrib.lantern_load.base_data_pack")
    ctx.data["load:load"] = FunctionTag({"values": ["#bs.load:load"]})

    ctx.generate("bs.load:cleanup",
        render=Function(source_path="core/load/cleanup.jinja"),
    )
    ctx.generate("bs.load:exclusive",
        render=Function(source_path="core/load/exclusive.jinja"),
    )
    ctx.generate(f"bs.load:enumerate/{ctx.data.name}/v{VERSION}",
        **version,
        module=ctx.data.name,
        render=Function(source_path="core/load/enumerate.jinja"),
    )
    ctx.generate(f"bs.load:resolve/{ctx.data.name}",
        **version,
        module=ctx.data.name,
        render=Function(source_path="core/load/resolve.jinja"),
    )
    ctx.generate("bs.load:validate",
        **version,
        modules=MODULES,
        render=Function(source_path="core/load/validate.jinja"),
    )

    ctx.data[f"bs.load:module/{ctx.data.name}"] = FunctionTag({
        "replace": True,
        "values": get_load_tag_values(
            ctx.directory.name,
            ctx.meta.get("dependencies", []) or [],
            ctx.meta.get("weak_dependencies", []) or [],
        ),
    })
    ctx.data["bs.load:load"] = FunctionTag({
        "values": [
            "bs.load:cleanup",
            "#bs.load:enumerate",
            "#bs.load:resolve",
            "bs.load:validate",
        ] + [
            {"id": f"#bs.load:module/{mod}", "required": False}
            for mod in MODULES
        ],
    })
    ctx.data["bs.load:unload"] = FunctionTag({
        "values": [
            {"id": f"{mod}:__unload__", "required": False}
            for mod in MODULES
        ],
    })


def parse_version(version_str: str) -> dict:
    """Parse the version string into a dictionary with major, minor, and patch."""
    major, minor, patch = map(int, version_str.split("."))
    return {"major": major, "minor": minor, "patch": patch}


def get_load_tag_values(
    module: str,
    dependencies: list[str],
    weak_dependencies: list[str],
) -> list[dict | str]:
    """Generate a list of functions for loading a module and its dependencies."""
    return [
        f"#bs.load:module/{dep}"
        for dep in dependencies
    ] + [
        {"id": f"#bs.load:module/{dep}", "required": False}
        for dep in weak_dependencies
    ] + [
        f"{module}:__load__",
    ]

from collections.abc import Callable, Sequence

from beet import Context, DataPack, Function, FunctionTag, ProjectConfig, subproject

from mcbookshelf.templates import header


def ensure_function(ctx: Context, key: str, lines: Sequence[str] = ()) -> Function:
    """Get the function at `key`, creating it with the header if missing."""
    if key not in ctx.data.functions:
        ctx.data.functions[key] = Function([header(), *lines])
    return ctx.data.functions[key]


def ensure_function_tag(ctx: Context, key: str, values: Sequence[str] = ()) -> FunctionTag:
    """Get the function tag at `key`, creating it with the values if missing."""
    if key not in ctx.data.function_tags:
        ctx.data.function_tags[key] = FunctionTag({"values": list(values)})
    return ctx.data.function_tags[key]


def include(ctx: Context, config: ProjectConfig) -> None:
    """Build another project into this one, keeping our `pack.mcmeta` and icon."""
    extra = dict(ctx.data.extra)
    ctx.require(subproject(config))
    ctx.data.extra.update(extra)


def prune(pack: DataPack, keep: Callable[[str], bool]) -> None:
    """Remove every file from the pack whose path the predicate rejects."""
    kept = {id(file) for path, file in pack.list_files() if keep(path)}
    for namespace in pack.values():
        for container in namespace.values():
            for key, file in list(container.items()):
                if id(file) not in kept:
                    del container[key]

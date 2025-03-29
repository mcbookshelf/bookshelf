from collections.abc import Generator

from beet import Context


def beet_default(ctx: Context) -> Generator:
    """Add commands to setup the log format if needed."""
    yield
    if "bs.log" in ctx.meta.get("weak_dependencies", []):
        load = ctx.data.functions[f"{ctx.directory.name}:__load__"]
        load.append((
            "",
            'execute unless data storage bs:const '
            f'log.messages[{{namespaces:["{ctx.directory.name}"]}}] '
            'run data modify storage bs:const '
            'log.messages[{namespaces:["bs"]}].namespaces '
            f'append value "{ctx.directory.name}"',
        ))

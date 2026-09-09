import importlib.util
from collections.abc import Callable
from pathlib import Path
from typing import Any

from beet import Context

from mcbookshelf.meta import Module

type Plugin = Callable[[Context], Any]


def beet_default(ctx: Context) -> None:
    module: Module = ctx.meta["module"]
    ctx.require(*discover_plugins(ctx.directory, module.id))


def discover_plugins(directory: Path, namespace: str) -> list[Plugin]:
    plugins: list[Plugin] = []
    for file in sorted(directory.glob("*.py")):
        name = f"mcbookshelf.modules.{namespace.replace('.', '_')}.{file.stem}"
        spec = importlib.util.spec_from_file_location(name, file)
        if spec is None or spec.loader is None:
            continue
        module = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(module)
        plugin = getattr(module, "beet_default", None)
        if callable(plugin):
            plugins.append(plugin)
    return plugins

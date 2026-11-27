import hashlib
import inspect
import pickle
from collections.abc import Callable, Iterable, Sequence
from functools import cache, wraps
from pathlib import Path

from beet import (
    Context,
    ContextFloatProvider,
    ContextIntProvider,
    Function,
    FunctionTag,
    NamespaceFile,
    Predicate,
    ProjectConfig,
    subproject,
)

from mcbookshelf import constants, minecraft
from mcbookshelf.minecraft.condition import Condition
from mcbookshelf.minecraft.number import Expression
from mcbookshelf.releases import prune
from mcbookshelf.templates import header

__all__ = ["ensure_function", "ensure_function_tag", "generator", "include", "prune"]

type Generated = Iterable[tuple[str, NamespaceFile | Expression | Condition]]


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
    """Build another project into this one, keeping our icon; `update_mcmeta` rewrites the rest."""
    extra = dict(ctx.data.extra)
    ctx.require(subproject(config))
    ctx.data.extra.update(extra)


def generator(plugin: Callable[[Context], Generated]) -> Callable[[Context], None]:
    """Write the files a plugin yields, cached until the version, the tools or the plugin change."""
    source = inspect.getfile(plugin)

    @wraps(plugin)
    def wrapper(ctx: Context) -> None:
        name = hashlib.sha1(plugin.__module__.encode()).hexdigest()  # noqa: S324
        path = ctx.cache["gen"].directory / name
        key = _cache_key(source)
        if path.is_file() and (data := path.read_bytes()).startswith(key):
            files = pickle.loads(data[len(key):])  # noqa: S301
        else:
            files = [(location, _file(value)) for location, value in plugin(ctx)]
            path.write_bytes(key + pickle.dumps(files))
        for location, file in files:
            if isinstance(file, Function) and location in ctx.data.functions:
                ctx.data.functions[location].lines.extend(file.lines)
            else:
                ctx.data[location] = file

    return wrapper


def _file(value: NamespaceFile | Expression | Condition) -> NamespaceFile:
    """The file of what a plugin yields: an expression is a provider of its kind."""
    match value:
        case Expression(kind="int"):
            return ContextIntProvider(value.json())
        case Expression():
            return ContextFloatProvider(value.json())
        case Condition():
            return Predicate(value.json())
    return value


@cache
def _cache_key(source: str) -> bytes:
    digest = hashlib.sha256(constants.GAME_VERSION.encode())
    for file in (*sorted(Path(minecraft.__file__).parent.glob("*.py")), Path(source)):
        digest.update(file.read_bytes())
    return digest.digest()

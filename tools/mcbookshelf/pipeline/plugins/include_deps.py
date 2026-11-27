from beet import Context

from mcbookshelf import workspace
from mcbookshelf.pipeline.config import build_of, module_config, module_of
from mcbookshelf.references import Owner
from mcbookshelf.workspace import dependencies, ownership

from . import include, prune


def beet_default(ctx: Context) -> None:
    required = dependencies.required(workspace.current(), module_of(ctx).id)
    for name, owners in required.items():
        include(ctx, module_config(name, build_of(ctx).nested))
        strip(ctx, name, owners)


def strip(ctx: Context, name: str, owners: set[Owner]) -> None:
    analysis = ownership.analyze(workspace.current(), name, ownership.pack_files(ctx, name))
    kept = {path for owner in (analysis.shared, *owners) for path in analysis.files.get(owner, ())}
    prune(ctx.data, lambda path: not path.startswith(f"data/{name}/") or path in kept)

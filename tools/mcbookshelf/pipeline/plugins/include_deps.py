from collections import defaultdict

from beet import Context

from mcbookshelf import references, workspace
from mcbookshelf.pipeline.config import build_of, module_config, module_of
from mcbookshelf.references import Owner
from mcbookshelf.workspace import ownership

from . import include, prune


def beet_default(ctx: Context) -> None:
    for name, owners in required(module_of(ctx).id).items():
        include(ctx, module_config(name, build_of(ctx).nested))
        strip(ctx, name, owners)


def strip(ctx: Context, name: str, owners: set[Owner]) -> None:
    analysis = ownership.analyze(workspace.current(), name, ownership.pack_files(ctx, name))
    kept = {path for owner in (analysis.shared, *owners) for path in analysis.files.get(owner, ())}
    prune(ctx.data, lambda path: not path.startswith(f"data/{name}/") or path in kept)


def required(name: str) -> dict[str, set[Owner]]:
    """The owners of other modules the module needs, and what those need in turn, by module."""
    ws = workspace.current()

    def requires(owner: Owner) -> set[Owner]:
        analysis = ownership.sources(ws, owner.module)
        found = analysis.dependencies(owner)
        weak = analysis.module.weak_dependencies
        shared = {analysis.shared, *analysis.parents(owner)} if owner.feature else set()
        return {o for o in shared | references.strong(found, weak) if o.module != name}

    analysis = ownership.sources(ws, name)
    targets = references.strong(analysis.targets, analysis.module.weak_dependencies)
    start = {owner for owner in targets if owner.module != name}
    used: dict[str, set[Owner]] = defaultdict(set)
    for owner in references.required(start, requires):
        used[owner.module].add(owner)
    return dict(used)

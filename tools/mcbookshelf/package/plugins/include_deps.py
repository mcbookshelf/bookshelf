from collections import defaultdict

from beet import Context

from mcbookshelf.meta import Module
from mcbookshelf.package.config import module_config
from mcbookshelf.references import Owner
from mcbookshelf.workspace import dependencies, ownership

from . import include, prune


def beet_default(ctx: Context) -> None:
    module: Module = ctx.meta["module"]
    for name, owners in required(module.id).items():
        include(ctx, module_config(name, ctx.meta["build"].nested))
        strip(ctx, name, owners)


def used_by_owner(owner: Owner) -> set[Owner]:
    analysis = ownership.sources(owner.module)
    return analysis.dependencies(owner) | analysis.dependencies(analysis.shared)


def strip(ctx: Context, name: str, owners: set[Owner]) -> None:
    analysis = ownership.analyze(name, ownership.pack_files(ctx, name))
    kept = {path for owner in (analysis.shared, *owners) for path in analysis.files.get(owner, ())}
    prune(ctx.data, lambda path: not path.startswith(f"data/{name}/") or path in kept)


def required(name: str) -> dict[str, set[Owner]]:
    used: dict[str, set[Owner]] = defaultdict(set)
    strong = dependencies.strong(name)
    pending = [owner for owner in ownership.sources(name).targets if owner.module in strong]
    while pending:
        owner = pending.pop()
        if owner not in used[owner.module]:
            used[owner.module].add(owner)
            pending.extend(o for o in used_by_owner(owner) if o.module != name)
    return dict(used)

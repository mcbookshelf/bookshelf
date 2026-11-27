from collections import defaultdict

from mcbookshelf import references
from mcbookshelf.references import Owner
from mcbookshelf.workspace import Workspace, cached, ownership


def weak(ws: Workspace, name: str) -> frozenset[str]:
    """Modules declared as weak dependencies: referenced, but not required."""
    module = ws.load_module(name)
    return frozenset(Owner.parse(entry).module for entry in module.weak_dependencies)


@cached
def strong(ws: Workspace, name: str) -> frozenset[str]:
    """Modules the sources reference, unless declared weak: they ship with the module."""
    return frozenset(target.module for target in _targets(ws, name))


def required(ws: Workspace, name: str) -> dict[str, set[Owner]]:
    """The owners of other modules the module needs, and what those need in turn, by module."""

    def whole(owner: Owner) -> set[Owner]:
        """The owner, and every feature of the group it is or lies in."""
        names = ws.load_module(owner.module).names
        folders = references.groups(names)
        path = owner.feature or ""
        group = path if path in folders else path.rpartition("/")[0]
        if group not in folders:
            return {owner}
        return {owner} | {Owner(owner.module, n) for n in names if n.startswith(f"{group}/")}

    def requires(owner: Owner) -> set[Owner]:
        analysis = ownership.sources(ws, owner.module)
        found = analysis.dependencies(owner)
        weak = analysis.module.weak_dependencies
        shared = {analysis.shared, *analysis.parents(owner)} if owner.feature else set()
        targets = {o for o in references.without_weak(found, weak) if o.module != name}
        return {o for o in shared if o.module != name} | {o for t in targets for o in whole(t)}

    start = {o for owner in _targets(ws, name) for o in whole(owner)}
    used: dict[str, set[Owner]] = defaultdict(set)
    for owner in references.closure(start, requires):
        used[owner.module].add(owner)
    return dict(sorted(used.items()))


def _targets(ws: Workspace, name: str) -> set[Owner]:
    """The owners of other modules the sources reference, unless declared weak."""
    analysis = ownership.sources(ws, name)
    targets = references.without_weak(analysis.targets, analysis.module.weak_dependencies)
    return {target for target in targets if target.module != name}

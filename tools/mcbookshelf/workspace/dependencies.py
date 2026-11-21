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
    analysis = ownership.sources(ws, name)
    targets = references.strong(analysis.targets, analysis.module.weak_dependencies)
    return frozenset({target.module for target in targets} - {name})

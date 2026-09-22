from functools import cache

from mcbookshelf import workspace
from mcbookshelf.references import Owner
from mcbookshelf.workspace import ownership


def weak(name: str) -> frozenset[str]:
    """Modules declared as weak dependencies: referenced, but not required."""
    module = workspace.load_module(name)
    return frozenset(Owner.parse(entry).module for entry in module.weak_dependencies)


@cache
def strong(name: str) -> frozenset[str]:
    """Modules the sources reference, unless declared weak: they ship with the module."""
    analysis = ownership.sources(name)
    declared = {Owner.parse(entry) for entry in analysis.module.weak_dependencies}
    modules = {
        target.module
        for target in analysis.targets
        if target not in declared and Owner(target.module) not in declared
    }
    return frozenset(modules - {name})

"""Bookshelf is a modular library for building Minecraft datapacks.

It provides a wide range of modules that can be used individually,
giving developers the flexibility to pick only the features they need.

Exports:
- `bundle`: Beet plugin to load an entire bundle (`bookshelf.bundle.<name>`).
- `module`: Beet plugin to load a single module (`bookshelf.module.<name>`).
"""

from .definitions import MC_VERSIONS, VERSION
from .plugins import require_bundle as bundle
from .plugins import require_module as module


def version() -> str:
    """Get the current version of Bookshelf."""
    return VERSION

def mc_versions() -> list[str]:
    """Get Minecraft versions compatible with the current Bookshelf version."""
    return MC_VERSIONS

__all__ = [
    "bundle",
    "mc_versions",
    "module",
    "version",
]

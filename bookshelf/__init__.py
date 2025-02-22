"""Bookshelf is a modular library for building Minecraft datapacks.

It provides a wide range of modules that can be used individually,
giving developers the flexibility to pick only the features they need.
"""

from bookshelf.definitions import MC_VERSIONS, VERSION


def version() -> str:
    """Get the current version of Bookshelf."""
    return VERSION

def mc_versions() -> list[str]:
    """Get Minecraft versions compatible with the current Bookshelf version."""
    return MC_VERSIONS

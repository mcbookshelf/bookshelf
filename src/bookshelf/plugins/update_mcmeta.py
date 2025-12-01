from __future__ import annotations

from typing import TYPE_CHECKING, TypedDict

from bookshelf.common import json
from bookshelf.definitions import MC_VERSIONS

if TYPE_CHECKING:
    from collections.abc import Generator

    from beet import Context


VERSION_META = "https://raw.githubusercontent.com/misode/mcmeta/refs/tags/{}-summary/version.json"


class SupportedFormats(TypedDict):
    """Supported pack formats for data and assets."""

    data: int
    assets: int


def beet_default(ctx: Context) -> Generator:
    """Set the pack format for the module based on supported Minecraft versions."""
    yield
    # Retrieve supported data and asset pack formats based on MC versions
    min_formats = get_supported_formats(ctx, MC_VERSIONS[0])
    max_formats = get_supported_formats(ctx, MC_VERSIONS[-1])

    # Set metadata for resource pack
    ctx.assets.description = ctx.meta.get("description")
    ctx.assets.min_format = min_formats["assets"]
    ctx.assets.max_format = max_formats["assets"]

    # Set metadata for data pack
    ctx.data.description = ctx.meta.get("description")
    ctx.data.min_format = min_formats["data"]
    ctx.data.max_format = max_formats["data"]

    # Ensure the mcmeta file includes the data pack id (Smithed convention)
    mcmeta = ctx.data.mcmeta
    ctx.data.mcmeta.set_content({
        "id": ctx.data.name,
        **mcmeta.data,
    })


def get_supported_formats(ctx: Context, version: str) -> SupportedFormats:
    """Retrieve the supported formats for the given Minecraft version."""
    cache = ctx.cache[f"version/{version}"]
    file = cache.download(VERSION_META.format(version))
    versions = json.load(file, dict)

    return SupportedFormats(
        data=versions["data_pack_version"],
        assets=versions["resource_pack_version"],
    )

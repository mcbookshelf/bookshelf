from __future__ import annotations

from typing import TYPE_CHECKING, TypedDict

from bookshelf.common import json
from bookshelf.definitions import MC_VERSIONS

if TYPE_CHECKING:
    from collections.abc import Generator

    from beet import Context


VERSION_META = "https://raw.githubusercontent.com/misode/mcmeta/refs/tags/{}-summary/version.json"


class VersionRange(TypedDict):
    """Range of supported pack format versions."""

    min_inclusive: int
    max_inclusive: int


class SupportedFormats(TypedDict):
    """Supported pack formats for data and assets."""

    data: VersionRange
    assets: VersionRange


def beet_default(ctx: Context) -> Generator:
    """Set the pack format for the module based on supported Minecraft versions."""
    yield
    # Retrieve supported data and asset pack formats based on MC versions
    formats = get_supported_formats(ctx, MC_VERSIONS)

    # Set metadata for resource pack
    ctx.assets.description = ctx.meta["description"]
    ctx.assets.min_format = formats["assets"]["min_inclusive"]
    ctx.assets.max_format = formats["assets"]["max_inclusive"]

    # Set metadata for data pack
    ctx.data.description = ctx.meta["description"]
    ctx.data.min_format = formats["data"]["min_inclusive"]
    ctx.data.max_format = formats["data"]["max_inclusive"]

    # Ensure the mcmeta file includes the data pack id (Smithed convention)
    mcmeta = ctx.data.mcmeta
    ctx.data.mcmeta.set_content({
        "id": ctx.data.name,
        **mcmeta.data,
    })


def get_supported_formats(ctx: Context, versions: list[str]) -> SupportedFormats:
    """Retrieve the supported formats for the given Minecraft versions."""
    # Download min version data
    cache = ctx.cache[f"version/{versions[0]}"]
    file = cache.download(VERSION_META.format(versions[0]))
    min_version = json.load(file, dict)

    # Download max version data
    cache = ctx.cache[f"version/{versions[-1]}"]
    file = cache.download(VERSION_META.format(versions[-1]))
    max_version = json.load(file, dict)

    return SupportedFormats(
        data=VersionRange(
            min_inclusive=min_version["data_pack_version"],
            max_inclusive=max_version["data_pack_version"],
        ),
        assets=VersionRange(
            min_inclusive=min_version["resource_pack_version"],
            max_inclusive=max_version["resource_pack_version"],
        ),
    )

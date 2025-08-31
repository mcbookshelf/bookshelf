from __future__ import annotations

import asyncio
from collections.abc import Awaitable
from logging import getLogger
from typing import TYPE_CHECKING

from bookshelf.definitions import FABRIC_API, MODRINTH_API

if TYPE_CHECKING:
    from pathlib import Path

    from httpx import AsyncClient

logger = getLogger(__name__)

# A download URL, either as a direct string or a coroutine resolving to one.
type URL = str | Awaitable[str]


class AssetResolutionError(Exception):
    """Raised when an asset cannot be resolved for the given criteria."""

    def __init__(self, name: str, version: str) -> None:
        """Initialize the AssetResolutionError."""
        super().__init__(f"Could not resolve asset '{name}' for MC version {version}.")


async def download(
    client: AsyncClient,
    mc_version: str,
    directory: Path,
) -> None:
    """Download required assets into the given directory."""
    server = _resolve_fabric_url(client, mc_version)
    fabric = _resolve_modrinth_url(client, "fabric-api", mc_version)
    packtest = _resolve_modrinth_url(client, "packtest", mc_version)

    await asyncio.gather(
        _download_file(client, server, directory / "server.jar"),
        _download_file(client, fabric, directory / "mods/fabric-api.jar"),
        _download_file(client, packtest, directory / "mods/packtest.jar"),
    )


async def _download_file(
    client: AsyncClient,
    url: URL,
    file: Path,
) -> None:
    """Download a file from the given URL to the specified file path."""
    if not isinstance(url, str):
        url = await url
    response = await client.get(url)
    response.raise_for_status()
    # Ensure target directory exists
    file.parent.mkdir(parents=True, exist_ok=True)
    file.write_bytes(response.content)


async def _resolve_fabric_url(
    client: AsyncClient,
    mc_version: str,
) -> str:
    """Resolve the download URL for a specific Fabric version."""
    response = await client.get(f"{FABRIC_API}/versions/loader/{mc_version}")
    response.raise_for_status()
    version = response.json()[0]["loader"]["version"]
    return f"{FABRIC_API}/versions/loader/{mc_version}/{version}/1.1.0/server/jar"


async def _resolve_modrinth_url(
    client: AsyncClient,
    project_id: str,
    mc_version: str,
) -> str:
    """Resolve the Modrinth download URL for a given project and version."""
    response = await client.get(f"{MODRINTH_API}/project/{project_id}/version")
    response.raise_for_status()
    versions = response.json()
    # Filter versions compatible with the target Minecraft version
    if versions := [
        version
        for version in versions
        if any(v.startswith(mc_version) for v in version["game_versions"])
    ]:
        return versions[0]["files"][0]["url"]
    # Raise if no compatible version was found
    raise AssetResolutionError(project_id, mc_version)

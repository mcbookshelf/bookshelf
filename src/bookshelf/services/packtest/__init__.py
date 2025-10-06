"""Python wrapper that runs a PackTest server."""

from __future__ import annotations

import logging
import shutil
from typing import TYPE_CHECKING

from httpx import AsyncClient, HTTPStatusError
from platformdirs import PlatformDirs

from . import assets, server

if TYPE_CHECKING:
    from pathlib import Path

dirs = PlatformDirs(appname="packtest", appauthor="mcbookshelf", ensure_exists=True)


async def run(datapacks: Path, mc_version: str) -> list[server.LogEvent]:
    """Configure then start a PackTest server for a specified Minecraft version."""
    work_dir = dirs.user_cache_path / f"v{mc_version}"
    world_dir = work_dir / "world"

    shutil.rmtree(world_dir, ignore_errors=True)
    world_dir.mkdir(parents=True, exist_ok=True)
    shutil.copytree(datapacks, world_dir / "datapacks")

    logs: list[server.LogEvent] = []

    try:
        async with AsyncClient() as client:
            await assets.download(client, mc_version, work_dir)
            logs.extend([log async for log in server.run(work_dir)])
    except assets.AssetResolutionError as e:
        logs.append(server.LogEvent(str(e), logging.ERROR))
    except HTTPStatusError as e:
        logs.append(server.LogEvent(str(e), logging.ERROR))

    return logs

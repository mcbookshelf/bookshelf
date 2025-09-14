"""Python wrapper that runs a PackTest server."""

from __future__ import annotations

from typing import TYPE_CHECKING

from . import server, worker

if TYPE_CHECKING:
    from pathlib import Path


def run(datapacks: Path, mc_version: str) -> worker.WorkerStream[server.LogEvent]:
    """Run a PackTest worker for a specified Minecraft version."""
    return worker.WorkerStream(worker.run(datapacks, mc_version))

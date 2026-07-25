"""Publish the Bookshelf Library to diverse platforms."""

from __future__ import annotations

from asyncio import run

from . import modrinth, smithed
from .utils import PublishSpec

__all__ = [
    "PublishSpec",
    "publish_to_modrinth",
    "publish_to_smithed",
]


def publish_to_modrinth(packs: list[PublishSpec]) -> None:
    """Attempt to publish a list of packs to Modrinth."""
    run(modrinth.publish(packs))


def publish_to_smithed(packs: list[PublishSpec]) -> None:
    """Attempt to publish a list of packs to Smithed."""
    run(smithed.publish(packs))

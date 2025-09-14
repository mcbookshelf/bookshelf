"""Publish the Bookshelf Library to diverse platforms."""

from __future__ import annotations

from asyncio import run
from typing import TYPE_CHECKING

from . import modrinth, smithed

if TYPE_CHECKING:
    from .utils import PublishSpec


def publish_to_modrinth(packs: list[PublishSpec]) -> None:
    """Attempt to publish a list of packs to Modrinth."""
    run(modrinth.publish(packs))


def publish_to_smithed(packs: list[PublishSpec]) -> None:
    """Attempt to publish a list of packs to Smithed."""
    run(smithed.publish(packs))

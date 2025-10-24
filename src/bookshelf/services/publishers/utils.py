from __future__ import annotations

from logging import getLogger
from pathlib import Path
from typing import TYPE_CHECKING, Literal

from pydantic import BaseModel

if TYPE_CHECKING:
    from httpx import Response

logger = getLogger(__name__)


class PublishSpec(BaseModel):
    """Specification required to publish a pack to platforms."""

    file: Path
    name: str
    kind: Literal["datapack", "resourcepack"]
    slug: str
    icon: Path
    readme: Path
    changelog: str
    description: str
    documentation: str


def handle_response(
    response: Response,
    action: str,
    slug: str,
    platform: str,
) -> bool:
    """Check and log an error if a Response is not successful."""
    if not response.is_success:
        logger.error(
            "(%s) '%s' → Failed to %s | HTTP %d: %s",
            platform,
            slug,
            action,
            response.status_code,
            response.text,
            extra={"title": f"PublishError[{platform}]"},
        )
    return response.is_success

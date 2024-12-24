import json
import logging
from collections.abc import Generator
from pathlib import Path

import requests
from beet import Context

from core.common.helpers import getenv_secure
from core.definitions import (
    GITHUB_REPO,
    MINECRAFT_VERSIONS,
    MODRINTH_API,
    ROOT_DIR,
    VERSION,
)

MODRINTH_TOKEN = getenv_secure("MODRINTH_TOKEN")
SMITHED_TOKEN = getenv_secure("SMITHED_TOKEN")

RELEASE_DIR = ROOT_DIR / "release"
STATUS_OK = 200

MODRINTH_HEADERS = {
    "Authorization": MODRINTH_TOKEN,
    "User-Agent": "mcbookshelf/Bookshelf/release (contact@gunivers.net)",
}


logger = logging.getLogger("bookshelf")

def beet_default(ctx: Context) -> Generator:
    """Attempt to publish pack to platforms."""
    yield
    if ctx.data.name:
        ctx.data.name = f"{ctx.data.name}-{MINECRAFT_VERSIONS[-1]}-v{VERSION}"
    if ctx.assets.name:
        ctx.assets.name = f"{ctx.assets.name}-{MINECRAFT_VERSIONS[-1]}-v{VERSION}"

    for pack in list(filter(None, ctx.packs)):
        pack.save(RELEASE_DIR, overwrite=True)

    if MODRINTH_TOKEN:
        ctx.require(publish_modrinth)
    if SMITHED_TOKEN:
        ctx.require(publish_smithed)


def publish_modrinth(ctx: Context) -> None:
    """Attempt to publish pack to modrinth."""
    slug = ctx.meta.get("slug")
    name = f"Bookshelf {ctx.meta.get("name")}"
    if not slug:
        logger.warning(
            "Module '%s' is missing a slug. "
            "Slug is required for publishing to Modrinth.",
            ctx.directory.name,
            extra={"depth":1},
        )
        return

    if get_modrinth_project_id(slug) or create_modrinth_project(
        name=name,
        slug=slug,
        summary=ctx.meta.get("description", ""),
        description="",
        documentation=ctx.meta.get("documentation", ""),
    ):
        create_modrinth_version(
            name=f"{name} v{VERSION}",
            slug=slug,
            changelog="",
            file=RELEASE_DIR / f"{ctx.data.name or ctx.assets.name}.zip",
        )


def publish_smithed(ctx: Context) -> None:
    """Attempt to publish pack to smithed."""


def get_modrinth_project_id(slug: str) -> str | None:
    """Attempt to get the modrinth project id."""
    response = requests.get(
        f"{MODRINTH_API}/project/{slug}/check",
        headers=MODRINTH_HEADERS,
        timeout=5,
    )

    return response.json()["id"] \
        if response.status_code == STATUS_OK \
        else None


def create_modrinth_project(
    name: str,
    slug: str,
    summary: str,
    description: str,
    documentation: str,
) -> bool:
    """Attempt to create a new modrinth project."""
    response = requests.post(
        f"{MODRINTH_API}/project",
        headers=MODRINTH_HEADERS,
        timeout=5,
        files={
            "data": json.dumps({
                "name": name,
                "slug": slug,
                "summary": summary,
                "description": description,
                "is_draft": True,
                "initial_versions": [],
                "categories": ["library"],
                "additional_categories": ["game-mechanics"],
                "organization_id": "CeDKAOAS",
                "license_id": "MPL-2.0",
                "license_url": f"https://github.com/{GITHUB_REPO}/blob/master/LICENSE",
                "link_urls": {
                    "issues": f"https://github.com/{GITHUB_REPO}/issues",
                    "source": f"https://github.com/{GITHUB_REPO}",
                    "wiki": documentation,
                    "discord": "https://discord.gg/aV5SF3JsAZ",
                    "other": "https://www.helloasso.com/associations/altearn/formulaires/3/en",
                },
            }),
        },
    )

    if response.status_code != STATUS_OK:
        logger.error(
            "Failed to create project '%s' on Modrinth: %s",
            name,
            response.json(),
            extra={"depth":1},
        )

    return response.status_code == STATUS_OK


def create_modrinth_version(
    name: str,
    slug: str,
    changelog: str,
    file: Path,
) -> bool:
    """Attempt to create a new modrinth version."""
    project_id = get_modrinth_project_id(slug)
    if not project_id:
        return False

    response = requests.post(
        f"{MODRINTH_API}/version",
        headers=MODRINTH_HEADERS,
        timeout=5,
        files={
            "data": json.dumps({
                "project_id": project_id,
                "file_parts": [file.name],
                "version_number": VERSION,
                "version_title": name,
                "version_body": changelog,
                "dependencies": [],
                "release_channel": "release",
                "game_versions": MINECRAFT_VERSIONS,
                "loaders": ["datapack"],
                "featured": True,
            }),
            file.name: file.read_bytes(), # type: ignore[arg-type]
        },
    )

    if response.status_code != STATUS_OK:
        logger.error(
            "Failed to create version '%s' on Modrinth: %s",
            name,
            response.json(),
            extra={"depth":1},
        )

    return response.status_code == STATUS_OK

from __future__ import annotations

import json
from asyncio import gather
from logging import getLogger
from os import getenv

from httpx import AsyncClient

from bookshelf.common.logging import log_errors
from bookshelf.definitions import GITHUB_REPO, MC_VERSIONS, MODRINTH_API, VERSION

from .utils import PublishSpec, handle_response

MODRINTH_TOKEN = getenv("MODRINTH_TOKEN")

logger = getLogger(__name__)


async def publish(packs: list[PublishSpec]) -> None:
    """Attempt to publish a list of packs to Modrinth."""
    if not MODRINTH_TOKEN:
        logger.info("Modrinth publish skipped (%d packs); no token.", len(packs))
        return

    async with AsyncClient(base_url=MODRINTH_API, http2=True, timeout=10, headers={
        "Authorization": MODRINTH_TOKEN,
        "User-Agent": "mcbookshelf/bookshelf/release (contact@gunivers.net)",
    }) as client:
        response = await client.get(
            "projects",
            params={"ids": json.dumps([p.slug for p in packs])},
        )
        projects = {p["slug"]: p["id"] for p in response.raise_for_status().json()}

        tasks = []
        for pack in packs:
            if pack.slug in projects:
                tasks.append(_create_version(client, pack, projects[pack.slug]))
                tasks.append(_update_project(client, pack, projects[pack.slug]))
                tasks.append(_update_icon(client, pack, projects[pack.slug]))
            else:
                tasks.append(_create_project(client, pack))

        errors = filter(None, await gather(*tasks, return_exceptions=True))
        log_errors(errors, logger)


async def _update_project(
    client: AsyncClient,
    pack: PublishSpec,
    project_id: str,
) -> None:
    handle_response(await client.patch(f"project/{project_id}", json={
        "name": pack.name,
        "summary": pack.description,
        "description": pack.readme.read_text("utf-8"),
        "link_urls": {"wiki": pack.documentation},
    }), "update project", pack.slug, "Modrinth")


async def _update_icon(
    client: AsyncClient,
    pack: PublishSpec,
    project_id: str,
) -> None:
    handle_response(await client.patch(
        f"project/{project_id}/icon",
        headers={"Content-Type": "image/png"},
        params={"ext": "png"},
        data=pack.icon.read_bytes(),
    ), "update icon", pack.slug, "Modrinth")


async def _create_version(
    client: AsyncClient,
    pack: PublishSpec,
    project_id: str,
) -> None:
    response = await client.get(f"project/{project_id}/version/{VERSION}")
    if response.is_success:
        logger.warning(
            "The version '%s' for the module '%s' already exists on Modrinth. "
            "This version will not be published again to avoid duplication.",
            VERSION,
            pack.name,
        )
        return

    with pack.file.open("rb") as file:
        handle_response(await client.post("version", files={
            "data": json.dumps({
                "file_parts": [pack.file.name],
                "project_id": project_id,
                "version_number": VERSION,
                "version_title": pack.name,
                "version_body": pack.changelog,
                "dependencies": [],
                "release_channel": "release",
                "game_versions": MC_VERSIONS,
                "loaders": ["datapack"],
                "featured": True,
            }),
            pack.file.name: file,
        }), "create version", pack.slug, "Modrinth")


async def _create_project(
    client: AsyncClient,
    pack: PublishSpec,
) -> None:
    data = json.dumps({
        "name": pack.name,
        "slug": pack.slug,
        "summary": pack.description,
        "description": pack.readme.read_text("utf-8"),
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
            "wiki": pack.documentation,
            "discord": "https://discord.gg/aV5SF3JsAZ",
            "other": "https://www.helloasso.com/associations/altearn/formulaires/3/en",
        },
    })

    with pack.icon.open("rb") as file:
        response = await client.post("project", files={
            "data": (None, data.encode("utf-8"), "application/json"),
            "icon": (pack.icon.name, file, "image/png"),
        })

    if handle_response(response, "create project", pack.slug, "Modrinth"):
        await _create_version(client, pack, response.json()["id"])

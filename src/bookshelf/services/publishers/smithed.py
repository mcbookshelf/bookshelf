from __future__ import annotations

from asyncio import gather
from logging import getLogger
from os import getenv

from httpx import AsyncClient

from bookshelf.common.logging import log_errors
from bookshelf.common.utils import raw_github_url
from bookshelf.definitions import GITHUB_REPO, MC_VERSIONS, SMITHED_API, VERSION

from .utils import PublishSpec, handle_response

SMITHED_TOKEN = getenv("SMITHED_TOKEN")

logger = getLogger(__name__)


async def publish(packs: list[PublishSpec]) -> None:
    """Attempt to publish a list of packs to Smithed."""
    if not SMITHED_TOKEN:
        logger.info("Smithed publish skipped (%d packs); no token.", len(packs))
        return

    async with AsyncClient(base_url=SMITHED_API, http2=True, timeout=10) as client:
        errors = filter(None, await gather(
            *[_publish_project(client, pack) for pack in packs],
            return_exceptions=True,
        ))
        log_errors(errors, logger)


async def _publish_project(
    client: AsyncClient,
    pack: PublishSpec,
) -> None:
    response = await client.get(f"packs/{pack.slug}")
    if not response.is_success:
        await _create_project(client, pack)
        return
    await _create_version(client, pack, response.json()["versions"])
    await _update_project(client, pack)


async def _update_project(
    client: AsyncClient,
    pack: PublishSpec,
) -> None:
    handle_response(await client.patch(
        f"packs/{pack.slug}",
        headers={"Content-Type": "application/json"},
        params={"token": SMITHED_TOKEN},
        json={"data": {
            "display": {
                "name": pack.name,
                "description": pack.description,
                "icon": raw_github_url(pack.icon),
                "webPage": raw_github_url(pack.readme),
                "urls": {"homepage": pack.documentation},
            },
        }},
    ), "update project", pack.slug, "Smithed")


async def _create_version(
    client: AsyncClient,
    pack: PublishSpec,
    versions: list,
) -> None:
    if any(version["name"] == VERSION for version in versions):
        logger.warning(
            "The version '%s' for the module '%s' already exists on Smithed. "
            "This version will not be published again to avoid duplication.",
            VERSION,
            pack.name,
        )
        return

    download = f"https://github.com/{GITHUB_REPO}/releases/download/v{VERSION}/{pack.file.name}"
    handle_response(await client.post(
        f"packs/{pack.slug}/versions",
        headers={"Content-Type": "application/json"},
        params={"token": SMITHED_TOKEN, "version": VERSION},
        json={"data": {
            "name": VERSION,
            "supports": MC_VERSIONS,
            "dependencies": [],
            "downloads": {pack.kind: download},
        }},
    ), "create version", pack.slug, "Smithed")


async def _create_project(
    client: AsyncClient,
    pack: PublishSpec,
) -> None:
    download = f"https://github.com/{GITHUB_REPO}/releases/download/v{VERSION}/{pack.file.name}"
    handle_response(await client.post(
        "packs",
        headers={"Content-Type": "application/json"},
        params={"token": SMITHED_TOKEN, "id": pack.slug},
        json={"data": {
            "id": pack.slug,
            "categories": ["Library"],
            "versions": [{
                "name": VERSION,
                "supports": MC_VERSIONS,
                "dependencies": [],
                "downloads": {pack.kind: download},
            }],
            "display": {
                "name": pack.name,
                "description": pack.description,
                "icon": raw_github_url(pack.icon),
                "webPage": raw_github_url(pack.readme),
                "urls": {
                    "discord": "https://discord.gg/aV5SF3JsAZ",
                    "source": f"https://github.com/{GITHUB_REPO}",
                    "homepage": pack.documentation,
                },
            },
        }},
    ), "create project", pack.slug, "Smithed")

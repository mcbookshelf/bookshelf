import json
from asyncio import gather

from httpx import AsyncBaseTransport, AsyncClient

from mcbookshelf import assets, constants

from . import Pack, PublishError, gather_errors

API = "https://api.modrinth.com/v2"
PLATFORM = "Modrinth"
ORGANIZATION = "CeDKAOAS"
LOADERS = {"datapack": "datapack", "resourcepack": "minecraft"}
LINKS = {
    "issues_url": constants.ISSUES_URL,
    "source_url": constants.GITHUB_URL,
    "discord_url": constants.DISCORD_URL,
    "donation_urls": [{"id": "other", "platform": "Other", "url": constants.DONATION_URL}],
}


async def publish(
    packs: list[Pack],
    token: str,
    transport: AsyncBaseTransport | None = None,
) -> list[Exception]:
    headers = {"Authorization": token, "User-Agent": assets.USER_AGENT}
    async with AsyncClient(
        base_url=API,
        headers=headers,
        timeout=10,
        transport=transport,
    ) as client:
        ids = {"ids": json.dumps([p.slug for p in packs])}
        response = await client.get("projects", params=ids)
        PublishError.check(response, PLATFORM, "*", "list projects")

        projects = {p["slug"]: p["id"] for p in response.json()}
        return await gather_errors(
            _update(client, pack, projects[pack.slug])
            if pack.slug in projects
            else _create(client, pack)
            for pack in packs
        )


async def _update(client: AsyncClient, pack: Pack, project_id: str) -> None:
    await gather(
        _update_project(client, pack, project_id),
        _update_icon(client, pack, project_id),
        _create_version(client, pack, project_id),
    )


async def _update_project(client: AsyncClient, pack: Pack, project_id: str) -> None:
    response = await client.patch(f"project/{project_id}", json={
        "title": pack.name,
        "description": pack.description,
        "body": pack.readme.read_text("utf-8"),
        "wiki_url": pack.documentation,
    })
    PublishError.check(response, PLATFORM, pack.slug, "update project")


async def _update_icon(client: AsyncClient, pack: Pack, project_id: str) -> None:
    response = await client.patch(
        f"project/{project_id}/icon",
        headers={"Content-Type": "image/png"},
        params={"ext": "png"},
        content=pack.icon.read_bytes(),
    )
    PublishError.check(response, PLATFORM, pack.slug, "update icon")


async def _create_version(client: AsyncClient, pack: Pack, project_id: str) -> None:
    existing = await client.get(f"project/{project_id}/version/{pack.version}")
    if existing.is_success:
        return

    data = {
        "name": pack.name,
        "version_number": pack.version,
        "changelog": pack.changelog,
        "dependencies": [],
        "game_versions": [constants.GAME_VERSION],
        "version_type": "release",
        "loaders": [LOADERS[pack.kind]],
        "featured": True,
        "project_id": project_id,
        "file_parts": [pack.file.name],
    }

    with pack.file.open("rb") as file:
        response = await client.post("version", files={
            "data": (None, json.dumps(data).encode("utf-8"), "application/json"),
            pack.file.name: (pack.file.name, file, "application/zip"),
        })
    PublishError.check(response, PLATFORM, pack.slug, "create version")


async def _create(client: AsyncClient, pack: Pack) -> None:
    data = {
        "slug": pack.slug,
        "title": pack.name,
        "description": pack.description,
        "body": pack.readme.read_text("utf-8"),
        "project_type": "mod",
        "client_side": "optional",
        "server_side": "required",
        "categories": ["library"],
        "additional_categories": ["game-mechanics"],
        "organization_id": ORGANIZATION,
        "license_id": "MPL-2.0",
        "license_url": constants.LICENSE_URL,
        "wiki_url": pack.documentation,
        **LINKS,
    }

    with pack.icon.open("rb") as file:
        response = await client.post("project", files={
            "data": (None, json.dumps(data).encode("utf-8"), "application/json"),
            "icon": (pack.icon.name, file, "image/png"),
        })
    PublishError.check(response, PLATFORM, pack.slug, "create project")

    await _create_version(client, pack, response.json()["id"])

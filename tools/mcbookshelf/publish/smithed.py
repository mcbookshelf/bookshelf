from typing import Any

from httpx import AsyncBaseTransport, AsyncClient

from mcbookshelf import constants, workspace

from . import Pack, PublishError, gather_errors

API = "https://api.smithed.dev/v2"
PLATFORM = "Smithed"


async def publish(
    packs: list[Pack],
    token: str,
    transport: AsyncBaseTransport | None = None,
) -> list[Exception]:
    async with AsyncClient(
        base_url=API,
        params={"token": token},
        timeout=10,
        transport=transport,
    ) as client:
        return await gather_errors(_publish(client, pack) for pack in packs)


async def _publish(client: AsyncClient, pack: Pack) -> None:
    response = await client.get(f"packs/{pack.slug}")
    if not response.is_success:
        await _create(client, pack)
        return
    await _create_version(client, pack, response.json()["versions"])
    await _update(client, pack)


def _version(pack: Pack) -> dict[str, Any]:
    return {
        "name": pack.version,
        "supports": [constants.GAME_VERSION],
        "dependencies": [],
        "downloads": {pack.kind: f"{workspace.download_url()}/{pack.file.name}"},
    }


def _display(pack: Pack) -> dict[str, Any]:
    return {
        "name": pack.name,
        "description": pack.description,
        "icon": pack.icon_url,
        "webPage": pack.readme_url,
        "urls": {
            "discord": constants.DISCORD_URL,
            "source": constants.GITHUB_URL,
            "homepage": pack.documentation,
        },
    }


async def _update(client: AsyncClient, pack: Pack) -> None:
    response = await client.patch(
        f"packs/{pack.slug}",
        json={"data": {"display": _display(pack)}},
    )
    PublishError.check(response, PLATFORM, pack.slug, "update project")


async def _create_version(client: AsyncClient, pack: Pack, versions: list[Any]) -> None:
    if any(version["name"] == pack.version for version in versions):
        return

    response = await client.post(
        f"packs/{pack.slug}/versions",
        params={"version": pack.version},
        json={"data": _version(pack)},
    )
    PublishError.check(response, PLATFORM, pack.slug, "create version")


async def _create(client: AsyncClient, pack: Pack) -> None:
    response = await client.post(
        "packs",
        params={"id": pack.slug},
        json={"data": {
            "id": pack.slug,
            "categories": ["Library"],
            "versions": [_version(pack)],
            "display": _display(pack),
        }},
    )
    PublishError.check(response, PLATFORM, pack.slug, "create project")

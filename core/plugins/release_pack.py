import json
from collections.abc import Generator
from pathlib import Path

import requests
from beet import Context, PluginOptions, configurable

from core.common.helpers import getenv_secure
from core.common.logger import get_step_logger
from core.definitions import (
    GITHUB_REPO,
    MINECRAFT_VERSIONS,
    MODRINTH_API,
    RELEASE_DIR,
    ROOT_DIR,
    SMITHED_API,
    VERSION,
)

MODRINTH_TOKEN = getenv_secure("MODRINTH_TOKEN")
SMITHED_TOKEN = getenv_secure("SMITHED_TOKEN")


class PublishOptions(PluginOptions):
    """Options required to publish on platforms."""

    file: Path
    changelog: str
    module_name: str
    module_slug: str
    module_description: str
    module_documentation: str
    module_readme: Path
    version_name: str


def beet_default(ctx: Context) -> Generator:
    """Build pack to output then attempt to publish them to platforms."""
    yield
    for pack in list(filter(None, ctx.packs)):
        pack.name = f"{pack.name}-{MINECRAFT_VERSIONS[-1]}-v{VERSION}" # type: ignore[attr-defined]
        file = pack.save(RELEASE_DIR, overwrite=True) # type: ignore[attr-defined]

    if module_slug := ctx.meta.get("slug"):
        ctx.require(publish_pack(
            file=file,
            changelog="",
            module_name=ctx.meta.get("name", "Bookshelf"),
            module_slug=module_slug,
            module_description=ctx.meta.get("description", ""),
            module_documentation=ctx.meta.get("documentation", ""),
            module_readme=ctx.directory / "README.md",
            version_name=f"{ctx.directory.name} v{VERSION}",
        ))
    else:
        get_step_logger().warning(
            "Metadata file for module '%s' is missing optional key 'slug'. "
            "A slug is required for publishing to platforms.",
            ctx.directory.name,
        )


@configurable(validator=PublishOptions)
def publish_pack(_: Context, opts: PublishOptions) -> None:
    """Attempt to publish pack to platforms."""
    if MODRINTH_TOKEN and (
        get_modrinth_project_id(opts.module_slug)
        or create_modrinth_project(opts)
    ):
        create_modrinth_version(opts)

    if SMITHED_TOKEN and (
        get_smithed_project_id(opts.module_slug)
        or create_smithed_project(opts)
    ):
        create_smithed_version(opts)


def get_modrinth_project_id(slug: str) -> str | None:
    """Attempt to get the Modrinth project id."""
    response = requests.get(f"{MODRINTH_API}/project/{slug}/check", timeout=5, headers={
        "Authorization": MODRINTH_TOKEN,
        "User-Agent": "mcbookshelf/Bookshelf/release (contact@gunivers.net)",
    })

    if response.status_code == requests.codes.ok:
        return response.json()["id"]
    return None


def get_smithed_project_id(slug: str) -> str | None:
    """Attempt to get the Smithed pack id."""
    response = requests.get(f"{SMITHED_API}/packs/{slug}", timeout=5)

    if response.status_code == requests.codes.ok:
        return response.json()["id"]
    return None


def create_modrinth_project(opts: PublishOptions) -> bool:
    """Attempt to create a new Modrinth project."""
    readme = opts.module_readme.read_text("utf-8") \
        if opts.module_readme.is_file() \
        else ""

    return handle_response_error(requests.post(
        f"{MODRINTH_API}/project",
        timeout=5,
        headers={
            "Authorization": MODRINTH_TOKEN,
            "User-Agent": "mcbookshelf/Bookshelf/release (contact@gunivers.net)",
        },
        files={"data":json.dumps({
            "name": opts.module_name,
            "slug": opts.module_slug,
            "summary": opts.module_description,
            "description": readme,
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
                "wiki": opts.module_documentation,
                "discord": "https://discord.gg/aV5SF3JsAZ",
                "other": "https://www.helloasso.com/associations/altearn/formulaires/3/en",
            }}),
        },
    ), f"Failed to create project '{opts.module_name}' on Modrinth.")


def create_smithed_project(opts: PublishOptions) -> bool:
    """Attempt to create a new Smithed project."""
    return handle_response_error(requests.post(
        f"{SMITHED_API}/packs",
        timeout=5,
        headers={"Content-Type": "application/json"},
        params={"token": SMITHED_TOKEN, "id": opts.module_slug},
        json={"data": {
            "categories": ["Library"],
            "display": {
                "name": opts.module_name,
                "description": opts.module_description,
                "icon": "",
                "webPage": (
                    f"https://raw.githubusercontent.com/{GITHUB_REPO}/refs/heads/master/"
                    f"{opts.module_readme.relative_to(ROOT_DIR)}"
                ),
                "urls": {
                    "discord": "https://discord.gg/aV5SF3JsAZ",
                    "source": f"https://github.com/{GITHUB_REPO}",
                    "homepage": opts.module_documentation,
                },
            },
        }},
    ), f"Failed to create project '{opts.module_name}' on Smithed.")


def create_modrinth_version(opts: PublishOptions) -> bool:
    """Attempt to create a new Modrinth version."""
    if requests.get(
        f"{MODRINTH_API}/project/{opts.module_slug}/version/{VERSION}",
        timeout=5,
        headers={
            "Authorization": MODRINTH_TOKEN,
            "User-Agent": "mcbookshelf/Bookshelf/release (contact@gunivers.net)",
        },
    ).status_code == requests.codes.ok:
        get_step_logger().warning(
            "The version '%s' for the module '%s' already exists on Modrinth. "
            "This version will not be published again to avoid duplication.",
            VERSION,
            opts.module_name,
        )
        return False

    return handle_response_error(requests.post(
        f"{MODRINTH_API}/version",
        timeout=5,
        headers={
            "Authorization": MODRINTH_TOKEN,
            "User-Agent": "mcbookshelf/Bookshelf/release (contact@gunivers.net)",
        },
        files={"data": json.dumps({
            "project_id": get_modrinth_project_id(opts.module_slug),
            "file_parts": [opts.file.name],
            "version_number": VERSION,
            "version_title": opts.module_name,
            "version_body": opts.changelog,
            "dependencies": [],
            "release_channel": "release",
            "game_versions": MINECRAFT_VERSIONS,
            "loaders": ["datapack"],
            "featured": True,
        }), opts.file.name: opts.file.read_bytes()}, # type: ignore[arg-type]
    ), f"Failed to create version '{VERSION}' on Modrinth.")


def create_smithed_version(opts: PublishOptions) -> bool:
    """Attempt to create a new Smithed version."""
    if not handle_response_error(response := requests.get(
        f"{SMITHED_API}/packs/{opts.module_slug}/versions",
        timeout=5,
    ), "Failed to get versions on Smithed."):
        return False

    if any(version["name"] == VERSION for version in response.json()):
        get_step_logger().warning(
            "The version '%s' for the module '%s' already exists on Smithed. "
            "This version will not be published again to avoid duplication.",
            VERSION,
            opts.module_name,
        )
        return False

    if not handle_response_error(response := requests.get(
        f"{MODRINTH_API}/project/{opts.module_slug}/version/{VERSION}",
        timeout=5,
    ), f"Failed to get version '{VERSION}' on Modrinth."):
        return False

    data = response.json()
    return handle_response_error(requests.post(
        f"{SMITHED_API}/packs/{opts.module_slug}/versions",
        timeout=5,
        headers={"Content-Type": "application/json"},
        params={"token": SMITHED_TOKEN, "version": VERSION},
        json={"data": {
            "name": VERSION,
            "supports": MINECRAFT_VERSIONS,
            "downloads": {
                data["project_types"][0]: data["files"][0]["url"],
            },
        }},
    ), f"Failed to create version '{VERSION}' on Smithed.")


def handle_response_error(response: requests.Response, err_message: str) -> bool:
    """Check for success and log errors."""
    if response.status_code != requests.codes.ok:
        get_step_logger().error("%s %s", err_message, response.json())

    return response.status_code == requests.codes.ok

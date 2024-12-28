import json
import re
from collections.abc import Generator
from pathlib import Path

import requests
from beet import Context, PluginOptions, configurable

from core.common.helpers import getenv_secure
from core.common.logger import get_step_logger
from core.definitions import (
    DOC_DIR,
    GITHUB_REPO,
    MASTER_URL,
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
    module_icon: Path
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
            changelog=create_specialized_changelog(ctx.directory.name),
            module_name=f"Bookshelf {ctx.meta.get('name', '')}".strip(),
            module_slug=module_slug,
            module_description=ctx.meta.get("description", ""),
            module_documentation=ctx.meta.get("documentation", ""),
            module_icon=ctx.directory / "pack.png",
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
        update_modrinth_project(opts)
        or create_modrinth_project(opts)
    ):
        create_modrinth_version(opts)

    if SMITHED_TOKEN and (
        update_smithed_project(opts)
        or create_smithed_project(opts)
    ):
        create_smithed_version(opts)


def create_specialized_changelog(module: str) -> str:
    """Create a changelog specific to the given module."""
    changelog = (DOC_DIR / f"_templates/changelog/v{VERSION}.md").read_text("utf-8")
    sections = re.split(r"(###.*?)$", changelog, flags=re.MULTILINE)
    return sections.pop(0) + "".join(
        "".join(sections[i:i+2])
        for i in range(0, len(sections) - 1, 2)
        if module in sections[i]
    ) if module.startswith("bs.") else changelog


def get_modrinth_project_id(slug: str) -> str | None:
    """Attempt to get the Modrinth project id."""
    response = requests.get(f"{MODRINTH_API}/project/{slug}/check", timeout=5, headers={
        "Authorization": MODRINTH_TOKEN,
        "User-Agent": "mcbookshelf/Bookshelf/release (contact@gunivers.net)",
    })

    return response.json()["id"] if response.status_code == requests.codes.ok else None


def create_modrinth_project(opts: PublishOptions) -> bool:
    """Attempt to create a new Modrinth project."""
    return handle_response_error(requests.post(
        f"{MODRINTH_API}/project",
        timeout=5,
        headers={
            "Authorization": MODRINTH_TOKEN,
            "User-Agent": "mcbookshelf/Bookshelf/release (contact@gunivers.net)",
        },
        files={"icon": opts.module_icon.read_bytes(), "data":json.dumps({
            "name": opts.module_name,
            "slug": opts.module_slug,
            "summary": opts.module_description,
            "description": opts.module_readme.read_text("utf-8"),
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


def update_modrinth_project(opts: PublishOptions) -> bool:
    """Attempt to update a Modrinth project."""
    response = requests.patch(
        f"{MODRINTH_API}/project/{opts.module_slug}",
        timeout=5,
        headers={
            "Authorization": MODRINTH_TOKEN,
            "User-Agent": "mcbookshelf/Bookshelf/release (contact@gunivers.net)",
        },
        json={
            "summary": opts.module_description,
            "description": opts.module_readme.read_text("utf-8"),
            "link_urls": {"wiki": opts.module_documentation},
        },
    )

    return handle_response_error(
        response,
        f"Failed to update project '{opts.module_name}' on Modrinth.",
    ) if response.status_code != requests.codes.not_found else False


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
                "icon": MASTER_URL.format(
                    opts.module_icon.relative_to(ROOT_DIR).as_posix(),
                ),
                "webPage": MASTER_URL.format(
                    opts.module_readme.relative_to(ROOT_DIR).as_posix(),
                ),
                "urls": {
                    "discord": "https://discord.gg/aV5SF3JsAZ",
                    "source": f"https://github.com/{GITHUB_REPO}",
                    "homepage": opts.module_documentation,
                },
            },
        }},
    ), f"Failed to create project '{opts.module_name}' on Smithed.")


def update_smithed_project(opts: PublishOptions) -> bool:
    """Attempt to update a Smithed project."""
    response = requests.patch(
        f"{SMITHED_API}/packs/{opts.module_slug}",
        timeout=5,
        headers={"Content-Type": "application/json"},
        params={"token": SMITHED_TOKEN},
        json={"data": {
            "display": {
                "description": opts.module_description,
                "urls": {"homepage": opts.module_documentation},
            },
        }},
    )

    return handle_response_error(
        response,
        f"Failed to update project '{opts.module_name}' on Smithed.",
    ) if response.status_code != requests.codes.not_found else False


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

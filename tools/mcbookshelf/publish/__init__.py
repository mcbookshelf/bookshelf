from asyncio import gather
from collections.abc import Awaitable, Iterable
from dataclasses import dataclass
from pathlib import Path

import httpx
import orjson
from httpx import Response

from mcbookshelf import constants, workspace
from mcbookshelf.assets import BundleEntry, Manifest, ModuleEntry
from mcbookshelf.workspace import changelog


@dataclass(frozen=True)
class Pack:

    id: str
    name: str
    slug: str
    kind: str
    version: str
    file: Path
    icon: Path
    icon_url: str
    readme: Path
    readme_url: str
    description: str
    documentation: str
    changelog: str

    @classmethod
    def from_entry(cls, name: str, entry: ModuleEntry | BundleEntry) -> Pack:
        directory = workspace.directory(name)
        kind = "Bundle" if name in workspace.bundles() else "Module"
        return cls(
            id=entry["id"],
            name=f"Bookshelf {entry['name']} {kind}",
            slug=entry["slug"],
            kind=entry["kind"],
            version=f"{entry['version']}+{constants.GAME_VERSION}",
            file=constants.RELEASE_DIR / entry["file"],
            icon=directory / "pack.png",
            icon_url=entry["icon"],
            readme=directory / "README.md",
            readme_url=entry["readme"],
            description=entry["description"],
            documentation=entry["documentation"],
            changelog=_changelog(name, entry),
        )


class PublishError(Exception):

    def __init__(self, platform: str, slug: str, action: str, res: Response) -> None:
        self.platform, self.slug, self.action = platform, slug, action
        self.status, self.text = res.status_code, res.text
        super().__init__(f"({platform}) '{slug}' failed to {action}: {self.status}: {self.text}")

    @classmethod
    def check(cls, res: Response, platform: str, slug: str, action: str) -> None:
        if not res.is_success:
            raise cls(platform, slug, action, res)


FAILURES = (PublishError, httpx.HTTPError)


async def gather_errors(tasks: Iterable[Awaitable[None]]) -> list[Exception]:
    results = await gather(*tasks, return_exceptions=True)
    for result in results:
        if isinstance(result, BaseException) and not isinstance(result, FAILURES):
            raise result
    return [r for r in results if isinstance(r, FAILURES)]


def get_packs() -> list[Pack]:
    manifest = _manifest()
    expected = workspace.release_version()
    if manifest["release"] != expected:
        raise ValueError(
            f"release directory is v{manifest['release']}, sources are v{expected}: "
            "run `release` first",
        )
    if manifest["minecraft"] != constants.GAME_VERSION:
        raise ValueError(
            f"release directory targets Minecraft {manifest['minecraft']}, "
            f"sources target {constants.GAME_VERSION}",
        )
    entries = {**manifest["modules"], **manifest["bundles"]}
    return [Pack.from_entry(name, entry) for name, entry in entries.items()]


def _manifest() -> Manifest:
    file = constants.RELEASE_DIR / "manifest.json"
    if not file.is_file():
        raise ValueError(f"no release at {constants.RELEASE_DIR}: run `release` first")
    return orjson.loads(file.read_bytes())


def _changelog(name: str, entry: BundleEntry | ModuleEntry) -> str:
    if name not in workspace.bundles():
        return changelog.section(name, entry["version"])
    blocks = []
    for member in workspace.members(name):
        notes = changelog.section(member, workspace.load_module(member).version)
        if notes:
            blocks.append(f"## {member}\n\n{notes}")
    return "\n\n".join(blocks)

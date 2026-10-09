from asyncio import gather
from collections.abc import Awaitable, Iterable
from dataclasses import dataclass
from pathlib import Path

import httpx
import orjson
from httpx import Response

from mcbookshelf import constants, workspace
from mcbookshelf.releases import BundleEntry, Manifest, ModuleEntry
from mcbookshelf.workspace import Workspace, changelog, release


@dataclass(frozen=True)
class Pack:

    id: str
    name: str
    slug: str
    pack_type: str
    version: str
    file: Path
    icon: Path
    icon_url: str
    readme: Path
    readme_url: str
    download_url: str
    description: str
    documentation: str
    changelog: str

    @classmethod
    def from_entry(cls, ws: Workspace, name: str, entry: ModuleEntry | BundleEntry) -> Pack:
        directory = ws.directory(name)
        category = "Bundle" if name in ws.bundles() else "Module"
        for file in ("pack.png", "README.md"):
            if not (directory / file).is_file():
                raise ValueError(f"{name} has no {file}, every published pack needs one")
        return cls(
            id=entry["id"],
            name=f"Bookshelf {entry['name']} {category}",
            slug=entry["slug"],
            pack_type=entry["kind"],
            version=f"{entry['version']}+{constants.GAME_VERSION}",
            file=constants.RELEASE_DIR / entry["file"],
            icon=directory / "pack.png",
            icon_url=entry["icon"],
            readme=directory / "README.md",
            readme_url=entry["readme"],
            download_url=f"{release.download_url(ws)}/{entry['file']}",
            description=entry["description"],
            documentation=entry["documentation"],
            changelog=_changelog(ws, name, entry),
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
    ws = workspace.current()
    manifest = _manifest()
    expected = release.version(ws)
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
    return [Pack.from_entry(ws, name, entry) for name, entry in entries.items()]


def _manifest() -> Manifest:
    file = constants.RELEASE_DIR / "manifest.json"
    if not file.is_file():
        raise ValueError(f"no release at {constants.RELEASE_DIR}: run `release` first")
    return orjson.loads(file.read_bytes())


def _changelog(ws: Workspace, name: str, entry: BundleEntry | ModuleEntry) -> str:
    if name not in ws.bundles():
        return changelog.section(ws, name, entry["version"])
    blocks = []
    for member in ws.members(name):
        notes = changelog.section(ws, member, ws.load_module(member).version)
        if notes:
            blocks.append(f"## {member}\n\n{notes}")
    return "\n\n".join(blocks)

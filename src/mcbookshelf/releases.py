import json
import logging
import re
import time
from collections.abc import Callable, Iterable
from importlib.metadata import version as package_version
from pathlib import Path
from typing import Any, NotRequired, TypedDict
from zipfile import BadZipFile, ZipFile

from beet import Cache, Context, DataPack

logger = logging.getLogger(__name__)

API = "https://api.mcbookshelf.dev/v2"
LISTING_TTL = 24 * 60 * 60
USER_AGENT = f"mcbookshelf/bookshelf/{package_version('mcbookshelf')}"


class DownloadEntry(TypedDict):

    modrinth: str | None
    github: str


class VersionStamp(TypedDict):

    date: str
    minecraft_version: str


class VersionEntry(TypedDict):

    tag: str
    version: str
    minecraft: str
    date: str
    modules: dict[str, str]


class FeatureEntry(TypedDict):

    id: str
    kind: str
    documentation: str
    aliases: list[str]
    authors: list[str]
    contributors: list[str]
    created: VersionStamp
    updated: VersionStamp
    files: list[str]
    dependencies: list[str]


class PackEntry(TypedDict):

    id: str
    name: str
    slug: str
    kind: str
    version: str
    description: str
    documentation: str
    icon: str
    readme: str
    file: str
    stub: str
    tags: list[str]
    download: NotRequired[DownloadEntry]


class ModuleEntry(PackEntry):

    files: list[str]
    dependencies: list[str]
    weak_dependencies: list[str]
    features: list[FeatureEntry]


class BundleEntry(PackEntry):

    modules: list[str]


class Manifest(TypedDict):

    version: int
    release: str
    minecraft: str
    bundles: dict[str, BundleEntry]
    modules: dict[str, ModuleEntry]


class ResolutionError(ValueError):
    """The `meta.bookshelf` options name versions that do not exist together."""


def load_pack(file: Path, paths: Iterable[str] | None = None) -> DataPack:
    """Load a module zip, optionally keeping only the given data paths."""
    pack = DataPack(path=file)
    pack.extra.clear()
    if paths is not None:
        wanted = set(paths)
        prune(pack, lambda path: path in wanted)
    return pack


def prune(pack: DataPack, keep: Callable[[str], bool]) -> None:
    """Remove every file from the pack whose path the predicate rejects."""
    kept = {id(file) for path, file in pack.list_files() if keep(path)}
    for namespace in pack.values():
        for container in namespace.values():
            for key in [k for k, file in container.items() if id(file) not in kept]:
                del container[key]


class Releases:
    """The published Bookshelf releases a project resolves its modules from."""

    def __init__(self, ctx: Context) -> None:
        options = ctx.meta.get("bookshelf", {})
        self.cache = ctx.cache["bookshelf"]
        self.versions = _listing(self.cache)
        self.base = self._base(options.get("version"), options.get("minecraft"))
        self.pins = self._pins(options.get("modules", {}), options.get("minecraft"))
        self.modules = self._modules()

    def module(self, name: str, paths: Iterable[str] | None = None) -> DataPack:
        """Download and load a module pack, preferring Modrinth over GitHub."""
        self._check_dependencies(name)
        entry = self.modules[name]
        download = entry.get("download", {})
        for url in filter(None, (download.get("modrinth"), download.get("github"))):
            try:
                return load_pack(_download(self.cache, url, _check_zip), paths)
            except (OSError, BadZipFile) as error:
                logger.debug("Could not download %s (%s).", url, error)
        raise ResolutionError(f"{name} {entry['version']} cannot be downloaded")

    def _base(self, version: str | None, minecraft: str | None) -> str:
        entry = self._find(version, minecraft)
        if entry is None:
            asked = [f"version {version}"] if version else []
            asked += [f"Minecraft {minecraft}"] if minecraft else []
            raise ResolutionError(f"no Bookshelf version matches {' and '.join(asked)}")
        return entry["tag"]

    def _pins(self, pins: dict[str, str], minecraft: str | None) -> dict[str, str]:
        tags = {}
        for name, version in pins.items():
            entry = self._find(None, minecraft, module=(name, version))
            if entry is None:
                target = f" for Minecraft {minecraft}" if minecraft else ""
                raise ResolutionError(f"no Bookshelf version ships {name} {version}{target}")
            tags[name] = entry["tag"]
        return tags

    def _modules(self) -> dict[str, ModuleEntry]:
        tags = {self.base, *self.pins.values()}
        manifests = {tag: _fetch(self.cache, f"{API}/versions/{tag}") for tag in tags}
        modules = dict(manifests[self.base]["modules"])
        for name, tag in self.pins.items():
            modules[name] = manifests[tag]["modules"][name]
        return modules

    def _check_dependencies(self, name: str) -> None:
        tag = self.pins.get(name, self.base)
        built_with = next(v["modules"] for v in self.versions if v["tag"] == tag)
        own = self.modules[name]
        for dependency in {d.partition(":")[0] for d in own["dependencies"]}:
            if dependency not in self.modules:
                raise ResolutionError(
                    f"{name} {own['version']} needs {dependency}, but no version resolved ships it",
                )
            expected = built_with.get(dependency)
            actual = self.modules[dependency]["version"]
            if expected != actual:
                raise ResolutionError(
                    f"{name} {own['version']} was built with {dependency} {expected}, "
                    f"but {dependency} resolved to {actual}",
                )

    def _find(
        self,
        version: str | None,
        minecraft: str | None,
        module: tuple[str, str] | None = None,
    ) -> VersionEntry | None:
        for entry in self.versions:
            if version not in (None, entry["version"]):
                continue
            if minecraft not in (None, entry["minecraft"]):
                continue
            if module and entry["modules"].get(module[0]) != module[1]:
                continue
            return entry
        return None


def _listing(cache: Cache) -> list[VersionEntry]:
    """The published versions, newest first: read again daily, the old ones kept when offline."""
    url = f"{API}/versions"
    path = cache.get_path(url)
    if path.is_file() and time.time() - path.stat().st_mtime > LISTING_TTL:
        refresh = cache.get_path(f"{url}?refresh")
        refresh.unlink(missing_ok=True)
        try:
            _download(cache, url, _read_json, refresh)
            refresh.replace(path)
        except (OSError, ValueError) as error:
            logger.warning("Could not refresh Bookshelf versions, cached ones used (%s)", error)
    return sorted(_download(cache, url, _read_json), key=_release_order, reverse=True)


def _release_order(entry: VersionEntry) -> tuple[tuple[int, ...], str]:
    return tuple(int(part) for part in re.findall(r"\d+", entry["version"])), entry["date"]


def _fetch(cache: Cache, url: str) -> Any:  # noqa: ANN401
    return _download(cache, url, _read_json)


def _read_json(path: Path) -> Any:  # noqa: ANN401
    return json.loads(path.read_text("utf-8"))


def _check_zip(path: Path) -> Path:
    with ZipFile(path) as archive:
        if (member := archive.testzip()) is not None:
            raise BadZipFile(f"{member} is corrupt in {path.name}")
    return path


def _download[T](
    cache: Cache,
    url: str,
    read: Callable[[Path], T],
    path: Path | None = None,
) -> T:
    path = path or cache.get_path(url)
    try:
        return read(cache.download(url, path, headers={"User-Agent": USER_AGENT}))
    except Exception:
        path.unlink(missing_ok=True)
        raise

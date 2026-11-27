import logging
import re
import time
from collections.abc import Iterable
from difflib import get_close_matches
from functools import cached_property
from pathlib import Path
from zipfile import BadZipFile, ZipFile

from beet import Cache, Context, DataPack

from mcbookshelf.downloads import download, read_json
from mcbookshelf.manifest import ModuleEntry, VersionEntry
from mcbookshelf.packs import load_pack

logger = logging.getLogger(__name__)

API = "https://api.mcbookshelf.dev/v2"
LISTING_TTL = 24 * 60 * 60


class ResolutionError(ValueError):
    """The `meta.bookshelf` options name versions that do not exist together."""


class Releases:
    """The published Bookshelf releases a project resolves its modules from."""

    def __init__(self, ctx: Context) -> None:
        self.options = ctx.meta.get("bookshelf", {})
        self.cache = ctx.cache["bookshelf"]

    @cached_property
    def versions(self) -> list[VersionEntry]:
        """The published versions, newest first."""
        return _listing(self.cache)

    @cached_property
    def base(self) -> str:
        """The tag of the release the options ask for, the newest by default."""
        version, minecraft = self.options.get("version"), self.options.get("minecraft")
        entry = self._find(version, minecraft)
        if entry is None:
            criteria = [f"version {version}"] if version else []
            criteria += [f"Minecraft {minecraft}"] if minecraft else []
            raise ResolutionError(f"no Bookshelf version matches {' and '.join(criteria)}")
        return entry["tag"]

    @cached_property
    def pins(self) -> dict[str, str]:
        """The tag of the release each module pinned in the options comes from."""
        minecraft = self.options.get("minecraft")
        tags = {}
        for name, version in self.options.get("modules", {}).items():
            entry = self._find(None, minecraft, module=(name, version))
            if entry is None:
                target = f" for Minecraft {minecraft}" if minecraft else ""
                raise ResolutionError(f"no Bookshelf version ships {name} {version}{target}")
            tags[name] = entry["tag"]
        return tags

    @cached_property
    def modules(self) -> dict[str, ModuleEntry]:
        """The modules of the base release, the pinned ones taken from their own release."""
        tags = {self.base, *self.pins.values()}
        manifests = {tag: download(self.cache, f"{API}/versions/{tag}", read_json) for tag in tags}
        modules = dict(manifests[self.base]["modules"])
        for name, tag in self.pins.items():
            modules[name] = manifests[tag]["modules"][name]
        return modules

    def module(self, name: str, paths: Iterable[str] | None = None) -> DataPack:
        """Download and load a module pack, preferring Modrinth over GitHub."""
        if name not in self.modules:
            close = get_close_matches(name, self.modules, n=1)
            hint = f": did you mean {close[0]}?" if close else ""
            raise ResolutionError(f"Bookshelf has no module {name}{hint}")
        self._check_dependencies(name)
        entry = self.modules[name]
        links = entry.get("download", {})
        for url in filter(None, (links.get("modrinth"), links.get("github"))):
            try:
                return load_pack(download(self.cache, url, _check_zip), paths)
            except (OSError, BadZipFile) as error:
                logger.debug("Could not download %s (%s).", url, error)
        raise ResolutionError(f"{name} {entry['version']} cannot be downloaded")

    def _check_dependencies(self, name: str) -> None:
        tag = self.pins.get(name, self.base)
        built_with = next(v["modules"] for v in self.versions if v["tag"] == tag)
        module = self.modules[name]
        for dependency in {d.partition(":")[0] for d in module["dependencies"]}:
            if dependency not in self.modules:
                raise ResolutionError(
                    f"{name} {module['version']} needs {dependency}, "
                    "but no version resolved ships it",
                )
            expected = built_with.get(dependency)
            actual = self.modules[dependency]["version"]
            if expected != actual:
                raise ResolutionError(
                    f"{name} {module['version']} was built with {dependency} {expected}, "
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


def _check_zip(path: Path) -> Path:
    with ZipFile(path) as archive:
        if (member := archive.testzip()) is not None:
            raise BadZipFile(f"{member} is corrupt in {path.name}")
    return path


def _listing(cache: Cache) -> list[VersionEntry]:
    """The published versions, newest first: read again daily, the old ones kept when offline."""
    url = f"{API}/versions"
    path = cache.get_path(url)
    if path.is_file() and time.time() - path.stat().st_mtime > LISTING_TTL:
        refresh = path.with_name(f"{path.name}.refresh")
        refresh.unlink(missing_ok=True)
        try:
            download(cache, url, read_json, refresh)
            refresh.replace(path)
        except (OSError, ValueError) as error:
            logger.warning("Could not refresh Bookshelf versions, cached ones used (%s)", error)
    return sorted(download(cache, url, read_json), key=_release_order, reverse=True)


def _release_order(entry: VersionEntry) -> tuple[tuple[int, ...], str]:
    return tuple(int(part) for part in re.findall(r"\d+", entry["version"])), entry["date"]

from __future__ import annotations

from re import escape

from pydantic import BaseModel, Field
from semver import Version

from bookshelf.definitions import DOC_URL, VERSION

from .collection import Collection


class VersionsEntry(BaseModel, frozen=True):
    """A project version with supported MC versions and manifest URL."""

    version: str
    minecraft_versions: list[str]
    manifest: str


class SwitcherEntry(BaseModel, frozen=True):
    """A single version used in the documentation switcher."""

    name: str
    version: str
    url: str = Field(pattern=rf"^{escape(DOC_URL)}/.+$")
    preferred: bool = False


class Versions(Collection[VersionsEntry]):
    """A list of all available project versions as represented in versions.json."""


class Switcher(Collection[SwitcherEntry]):
    """A list of versions for the documentation switcher."""

    def upsert(self, entry: SwitcherEntry) -> None:
        """Insert or update a version entry based on a major.minor version match.

        If an existing entry matches the major and minor version of the current version,
        it will be replaced by the new entry. Otherwise, the new entry is inserted
        after pinned entries (at index 2).
        """
        v = Version.parse(VERSION).replace(patch=0)
        for i, e in enumerate(self.root):
            if (e.version.startswith("v") and Version
                .parse(e.version[1:])
                .replace(patch=0) == v):
                self.root[i] = entry
                break
        else:
            self.root.insert(2, entry)

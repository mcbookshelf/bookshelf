from __future__ import annotations

from logging import getLogger

from bookshelf.common import json, utils
from bookshelf.definitions import (
    DOC_URL,
    MANIFEST_FILE,
    MC_VERSIONS,
    ROOT_DIR,
    SWITCHER_FILE,
    VERSION,
    VERSIONS_FILE,
)
from bookshelf.models import Switcher, SwitcherEntry, Versions, VersionsEntry
from bookshelf.services import metadata

logger = getLogger(__name__)


def update_manifest() -> int:
    """Generate a new manifest with all modules and features."""
    manifest = metadata.make_manifest()
    return json.dump(MANIFEST_FILE, manifest)


def update_switcher() -> int:
    """Add the current version to the documentation switcher if missing."""
    switcher = json.load(SWITCHER_FILE, Switcher)
    if any(entry.version.removeprefix("v") == VERSION for entry in switcher):
        logger.warning(
            "Version %s already exists in switcher",
            VERSION,
            extra={"file": SWITCHER_FILE.relative_to(ROOT_DIR)},
        )
        return 0

    switcher.upsert(SwitcherEntry(
        name=VERSION,
        version=f"v{VERSION}",
        url=f"{DOC_URL}/en/v{VERSION}/",
    ))

    return json.dump(SWITCHER_FILE, switcher)


def update_versions() -> int:
    """Prepend the current version to the data versions list if missing."""
    versions = json.load(VERSIONS_FILE, Versions)
    if any(entry.version == VERSION for entry in versions):
        logger.warning(
            "Version %s already exists in versions",
            VERSION,
            extra={"file": VERSIONS_FILE.relative_to(ROOT_DIR)},
        )
        return 0

    versions.root.insert(0, VersionsEntry(
        version=VERSION,
        minecraft_versions=MC_VERSIONS,
        manifest=utils.raw_github_url(MANIFEST_FILE),
    ))

    return json.dump(VERSIONS_FILE, versions)

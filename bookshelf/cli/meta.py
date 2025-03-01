import json
import sys
from pathlib import Path

import click

from bookshelf.definitions import (
    DOC_DIR,
    DOC_URL,
    GITHUB_REPO,
    MC_VERSIONS,
    MODULES,
    MODULES_DIR,
    ROOT_DIR,
    VERSION,
)
from bookshelf.logger import log_step
from bookshelf.meta import build_manifest, get_feature_meta, get_module_meta

MANIFEST_FILE = "data/manifest.json"
VERSIONS_FILE = "data/versions.json"


@click.group()
def meta() -> None:
    """Metadata-related commands."""


@meta.command()
def check() -> None:
    """Check modules metadata files."""
    success = check_modules()
    success &= check_features()
    sys.exit(not success)


@meta.command()
def update() -> None:
    """Update metadata changes."""
    if not update_manifest():
        sys.exit(1)

    update_switcher()
    update_versions()


def check_modules() -> bool:
    """Check metadata for all module files."""
    with log_step("⏳ Checking module metadata files…") as logger:
        for module in MODULES:
            get_module_meta(MODULES_DIR / module / "module.json", logger)

    return not logger.errors


def check_features() -> bool:
    """Check metadata for all feature files."""
    with log_step("⏳ Checking feature metadata files…") as logger:
        for feature in MODULES_DIR.rglob("*/data/**/*.json"):
            get_feature_meta(feature, logger)

    return not logger.errors


def update_manifest() -> bool:
    """Generate and update the manifest file."""
    with log_step("⚙️ Generating manifest file…") as logger:
        if manifest := build_manifest(logger):
            with Path(ROOT_DIR / MANIFEST_FILE).open("w", newline="\n") as file:
                json.dump(manifest, file, indent=2)

    return not logger.errors


def update_switcher() -> None:
    """Generate and update the switcher file."""
    with log_step("⚙️ Generating switcher file…") as logger:
        switcher_path = DOC_DIR / "_static/switcher.json"
        switcher: list[dict] = json.loads(switcher_path.read_text("utf-8"))

        if any(entry["version"][1:] == VERSION for entry in switcher):
            logger.debug("Version %s already exists. No update needed.", VERSION)
            return

        entry = {
            "name": VERSION,
            "version": f"v{VERSION}",
            "url": f"{DOC_URL}/en/v{VERSION}/",
        }

        for i in range(len(switcher)):
            if switcher[i]["version"][1:].split(".")[:2] == VERSION.split(".")[:2]:
                switcher[i] = entry
                break
        else:
            switcher.insert(2, entry)

        switcher_path.write_text(json.dumps(switcher, indent=2), "utf-8")


def update_versions() -> None:
    """Generate and update the versions file."""
    with log_step("⚙️ Generating versions file…") as logger:
        versions_path = ROOT_DIR / VERSIONS_FILE
        versions: list[dict] = json.loads(versions_path.read_text("utf-8"))

        if any(entry["version"] == VERSION for entry in versions):
            logger.debug("Version %s already exists. No update needed.", VERSION)
            return

        versions.insert(0, {
            "version": VERSION,
            "minecraft_versions": MC_VERSIONS,
            "manifest": f"https://raw.githubusercontent.com/{GITHUB_REPO}/refs/tags/v{VERSION}/{MANIFEST_FILE}",
        })

        versions_path.write_text(json.dumps(versions, indent=2), "utf-8")

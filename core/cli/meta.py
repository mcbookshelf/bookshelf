import json
import os
import shutil
import subprocess
import sys
from pathlib import Path

import click

from core.common.logger import log_step
from core.common.metadata import build_manifest, get_feature_meta, get_module_meta
from core.definitions import (
    GITHUB_REPO,
    META_MANIFEST,
    META_VERSIONS,
    MINECRAFT_VERSIONS,
    MODULES_DIR,
    ROOT_DIR,
    VERSION,
)


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
    """Update and commit metadata changes."""
    if not update_manifest():
        sys.exit(1)

    update_versions()
    commit_changes()

    env = os.getenv("GITHUB_OUTPUT")
    if env and not version_exists(VERSION):
        with Path(env).open("a") as output:
            name = f"MC {", ".join(MINECRAFT_VERSIONS)}"
            output.write(f"release_tag=v{VERSION}\n")
            output.write(f"release_name=v{VERSION} - {name}\n")


def check_modules() -> bool:
    """Check metadata for all module files."""
    with log_step("⏳ Checking module metadata files…") as logger:
        for module in MODULES_DIR.iterdir():
            get_module_meta(module / "module.json", logger)

    return not logger.errors


def check_features() -> bool:
    """Check metadata for all feature files."""
    with log_step("⏳ Checking feature metadata files…") as logger:
        for feature in MODULES_DIR.rglob("*.json"):
            get_feature_meta(feature, logger)

    return not logger.errors


def commit_changes() -> None:
    """Commit and push changes to the repository."""
    git = shutil.which("git")
    if not git:
        error_msg = "The 'git' command was not found."
        raise FileNotFoundError(error_msg)

    for cmd in [
        [git, "add", META_MANIFEST, META_VERSIONS],
        [git, "commit", "-m", f"🔖 Update metadata for version v{VERSION}"],
        [git, "push"],
    ]:
        subprocess.run(cmd, cwd=ROOT_DIR, check=True)


def update_manifest() -> bool:
    """Generate and update the manifest file."""
    with log_step("⚙️ Generating manifest file…") as logger:
        if manifest := build_manifest(logger):
            with Path(ROOT_DIR / META_MANIFEST).open("w", newline="\n") as file:
                json.dump(manifest, file, indent=2)

    return not logger.errors


def update_versions() -> None:
    """Generate and update the versions file."""
    with log_step("⚙️ Generating versions file…") as logger:
        versions =  json.loads((ROOT_DIR / META_VERSIONS).read_text("utf-8"))
        if any(entry["version"] == VERSION for entry in versions):
            logger.debug("Version %s already exists. No update needed.", VERSION)
            return

        with Path(ROOT_DIR / META_VERSIONS).open("w", newline="\n") as file:
            json.dump([{
                "version": VERSION,
                "minecraft_versions": MINECRAFT_VERSIONS,
                "manifest": f"https://raw.githubusercontent.com/{GITHUB_REPO}/refs/tags/v{VERSION}/{META_MANIFEST}",
            }, *versions], file, indent=2)


def version_exists(version: str) -> bool:
    """Check if the specified version tag already exists."""
    git = shutil.which("git")
    if not git:
        error_msg = "The 'git' command was not found."
        raise FileNotFoundError(error_msg)

    result = subprocess.run(
        [git, "tag", "--list", f"v{version}"],
        cwd=ROOT_DIR,
        check=True,
        capture_output=True,
        text=True,
    )

    return bool(result.stdout.strip())

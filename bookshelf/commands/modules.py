import json
import sys
import time
from collections.abc import Sequence
from pathlib import Path
from tempfile import TemporaryDirectory

import click
import watchfiles
from beet import PackConfig, Project, ProjectConfig
from beet.toolchain.commands import error_handler

from bookshelf.definitions import (
    BUILD_DIR,
    DOC_DIR,
    DOC_URL,
    GITHUB_REPO,
    MC_VERSIONS,
    MODULES,
    MODULES_DIR,
    ROOT_DIR,
    VERSION,
)
from bookshelf.helpers import render_template
from bookshelf.logger import log_step
from bookshelf.metadata import build_manifest, get_feature_meta, get_module_meta
from bookshelf.packtest import Assets, Runner

MANIFEST_FILE = "data/manifest.json"
VERSIONS_FILE = "data/versions.json"


@click.group()
def modules() -> None:
    """Modules-related commands."""


@modules.command()
@click.argument("modules", nargs=-1)
def build(modules: tuple[str, ...]) -> None:
    """Build the specified modules."""
    with log_step("🔨 Building project…"):
        Project(create_config(
            modules=modules,
            output=BUILD_DIR,
            require=["bookshelf.plugins.load_tests"],
        )).build()


@modules.command()
def release() -> None:
    """Build zipped modules for a release."""
    with log_step("🔨 Building project…") as logger:
        Project(create_config(
            modules=["@*", *MODULES],
            meta={"autosave":{"link":False}},
            zipped=True,
            require=["bookshelf.plugins.release_pack"],
        )).build()

    sys.exit(logger.errors)


@modules.command()
@click.argument("modules", nargs=-1)
def test(modules: tuple[str, ...]) -> None:
    """Build and test the specified modules."""
    with TemporaryDirectory(prefix="mcbs-") as tmpdir:
        with log_step("🔨 Building project…"):
            Project(create_config(
                modules=modules,
                output=Path(tmpdir) / "world/datapacks",
                meta={"autosave":{"link":False}},
                require=["bookshelf.plugins.load_tests"],
            )).build()

        runner = Runner(Assets(MC_VERSIONS[-1]))
        code = runner.run(Path(tmpdir))

    sys.exit(code)


@modules.command()
@click.argument("modules", nargs=-1)
def watch(modules: tuple[str, ...]) -> None:
    """Watch for changes in specified modules and rebuild them."""
    with log_step("🔨 Watching project…") as logger:
        config = create_config(
            modules=modules,
            output=BUILD_DIR,
            require=["bookshelf.plugins.load_tests"],
        )

        def build_once() -> None:
            with error_handler(format_padding=1):
                project = Project(config.resolve(ROOT_DIR))
                project.build()
                del project

            logger.info("%s Finished build!", click.style(
                time.strftime("%H:%M:%S"),
                fg="green",
                bold=True,
            ))

        build_once()

        for changes in watchfiles.watch(MODULES_DIR):
            count = len(changes)
            change, filename = next(iter(changes))

            logger.info("%s %s", click.style(
                time.strftime("%H:%M:%S"),
                fg="green",
                bold=True,
            ), (
                f"{change.name.capitalize()}: {filename}"
                if count == 1 else
                f"Detected {count} changes…"
            ))

            build_once()


@modules.command()
@click.argument("world", required=False)
@click.option(
    "--minecraft",
    metavar="DIRECTORY",
    help="Path to the .minecraft directory.",
)
@click.option(
    "--data-pack",
    metavar="DIRECTORY",
    help="Path to the data packs directory.",
)
@click.option(
    "--resource-pack",
    metavar="DIRECTORY",
    help="Path to the resource packs directory.",
)
def link(
    world: str | None,
    minecraft: str | None,
    data_pack: str | None,
    resource_pack: str | None,
) -> None:
    """Link the generated resource pack and data pack to Minecraft."""
    project = Project(ProjectConfig())
    with log_step("🔗 Linking project…"):
        click.echo(project.link(
            world,
            minecraft,
            data_pack,
            resource_pack,
        ))


def create_config(
    modules: Sequence[str] | None = None,
    output: Path | None = None,
    meta: dict | None = None,
    zipped: bool | None = None,
    require: list[str] | None = None,
) -> ProjectConfig:
    """Create a configuration for the project."""
    pack_config = PackConfig(
        compression="deflate",
        compression_level=9,
        zipped=True,
    ) if zipped else PackConfig()

    return ProjectConfig(
        extend="module.json", # type: ignore[arg-type]
        broadcast=[MODULES_DIR / mod for mod in modules or MODULES], # type: ignore[arg-type]
        data_pack=pack_config,
        resource_pack=pack_config,
        output=output,
        meta=meta or {},
        require=[
            "bookshelf.plugins.log_build",
            *(require if require is not None else []),
            "bookshelf.plugins.set_pack_meta",
        ],
    ).resolve(ROOT_DIR)


@modules.command()
def check() -> None:
    """Check modules for conventions."""
    success = check_headers()
    success &= check_requirements()
    success &= check_modules()
    success &= check_features()
    sys.exit(not success)


@modules.command()
@click.option("--versions", is_flag=True)
def update(versions: bool) -> None: # noqa: FBT001
    """Update metadata changes."""
    if not update_manifest():
        sys.exit(1)
    if versions:
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


def check_headers() -> bool:
    """Check that all mcfunction files have the correct header."""
    template = render_template(ROOT_DIR / "bookshelf/templates/header.jinja")

    with log_step("⏳ Checking function file headers…") as logger:
        for file_path in MODULES_DIR.rglob("*/data/**/*.mcfunction"):
            lines = file_path.read_text("utf-8").splitlines()
            header = "\n".join(lines[:len(template.splitlines())])

            if header.strip() != template.strip():
                relative_path = file_path.relative_to(ROOT_DIR)
                logger.error(
                    "Found invalid header in file: %s",
                    relative_path,
                    extra={
                        "title": "Missing header",
                        "file": relative_path,
                    },
                )

    return not logger.errors


def check_requirements() -> bool:
    """Check that all modules have the required files."""
    with log_step("⏳ Checking required module files…") as logger:
        for module in MODULES:
            for file in [
                MODULES_DIR / module / "module.json",
                MODULES_DIR / module / "README.md",
                MODULES_DIR / module / "pack.png",
                MODULES_DIR / module / f"data/{module}/function/__load__.mcfunction",
                MODULES_DIR / module / f"data/{module}/function/__unload__.mcfunction",
            ]:
                if not file.exists():
                    logger.error(
                        "File '%s' is missing from module '%s'.",
                        file.name,
                        module,
                        extra={"title": "Missing required file", "file": file},
                    )

    return not logger.errors

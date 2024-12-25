import sys
import time
from pathlib import Path
from tempfile import TemporaryDirectory

import click
from beet import PackConfig, Project, ProjectConfig
from beet.toolchain.cli import error_handler

from core.cli.meta import check_features, check_modules
from core.common.helpers import render_template
from core.common.logger import log_step
from core.common.packtest import Assets, Runner
from core.definitions import (
    BUILD_DIR,
    MINECRAFT_VERSIONS,
    MODULES,
    MODULES_DIR,
    ROOT_DIR,
)


@click.group()
def modules() -> None:
    """Modules-related commands."""


@modules.command()
@click.argument("modules", nargs=-1)
def build(modules: tuple[str, ...]) -> None:
    """Build the specified modules."""
    with log_step("🔨 Building project…"):
        create_project(create_config(
            modules,
            output=BUILD_DIR,
            require=["core.plugins.setup_tests"],
        )).build()


@modules.command()
def check() -> None:
    """Check modules for conventions."""
    success = check_headers()
    success &= check_requirements()
    success &= check_modules()
    success &= check_features()
    sys.exit(not success)


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
    project = create_project(create_config())
    with log_step("🔗 Linking project…"):
        click.echo(project.link(
            world,
            minecraft,
            data_pack,
            resource_pack,
        ))


@modules.command()
def release() -> None:
    """Build zipped modules for a release."""
    with log_step("🔨 Building project…") as logger:
        pack_config = PackConfig(
            compression="bzip2",
            compression_level=9,
            zipped=True,
        )
        create_project(create_config(
            ("bookshelf", *MODULES),
            data_pack=pack_config,
            resource_pack=pack_config,
            meta={"autosave":{"link":False}},
            require=["core.plugins.release_pack"],
        )).build()

    sys.exit(logger.errors)


@modules.command()
@click.argument("modules", nargs=-1)
def test(modules: tuple[str, ...]) -> None:
    """Build and test the specified modules."""
    with TemporaryDirectory(prefix="mcbs-") as tmpdir:
        with log_step("🔨 Building project…"):
            create_project(create_config(
                modules,
                output=Path(tmpdir) / "world/datapacks",
                meta={"autosave":{"link":False}},
                require=["core.plugins.setup_tests"],
            )).build()

        runner = Runner(Assets(MINECRAFT_VERSIONS[-1]))
        code = runner.run(Path(tmpdir))

    sys.exit(code)


@modules.command()
@click.argument("modules", nargs=-1)
def watch(modules: tuple[str, ...]) -> None:
    """Watch for changes in specified modules and rebuild them."""
    with log_step("🔨 Watching project…") as logger:
        config = create_config(
            modules,
            require=["beet.contrib.livereload","core.plugins.setup_tests"],
            output=BUILD_DIR,
        )
        project = create_project(config.copy())

        for changes in project.watch(0.5):
            filename, action = next(iter(changes.items()))

            logger.info("%s %s", click.style(
                time.strftime("%H:%M:%S"),
                fg="green",
                bold=True,
            ), (
                f"{action.capitalize()}: {filename}"
                if changes == {filename: action} else
                f"{len(changes)} changes detected…"
            ))

            with error_handler(format_padding=1):
                project.resolved_config = config.resolve(ROOT_DIR)
                project.build()

            logger.info("%s Finished build!", click.style(
                time.strftime("%H:%M:%S"),
                fg="green",
                bold=True,
            ))


def create_config(
    modules: tuple[str, ...] | None = None,
    **kwargs: object,
) -> ProjectConfig:
    """Create a configuration for the project."""
    modules = modules if modules else tuple(MODULES)
    require = kwargs.get("require", [])

    kwargs["extend"] = "module.json"
    kwargs["broadcast"] = [f"modules/{mod}" for mod in modules]
    kwargs["require"] = [
        "core.plugins.log_build",
        *(require if isinstance(require, list) else [require]),
    ]

    return ProjectConfig(**kwargs) # type: ignore[arg-type]


def create_project(config: ProjectConfig) -> Project:
    """Create a project based on the provided configuration."""
    return Project(config.resolve(ROOT_DIR))


def check_headers() -> bool:
    """Check that all mcfunction files have the correct header."""
    template = render_template(ROOT_DIR / "core/templates/header.jinja")

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

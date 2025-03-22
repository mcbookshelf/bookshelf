import time
from pathlib import Path

import click
from beet import PackConfig, Project, ProjectConfig
from beet.toolchain.cli import error_handler

from bookshelf.definitions import (
    BUILD_DIR,
    EXAMPLES_DIR,
    ROOT_DIR,
)
from bookshelf.logger import log_step

original_read_text = Path.read_text

def utf8_safe_read_text(
    self: Path,
    encoding: str | None = "utf-8",
    errors: str | None = "replace",
) -> str:
    """Safely read UTF8 files."""
    return original_read_text(self, encoding=encoding, errors=errors)

Path.read_text = utf8_safe_read_text


@click.group()
def examples() -> None:
    """Examples-related commands."""


@examples.command()
@click.argument("examples", nargs=-1)
def build(examples: tuple[str, ...]) -> None:
    """Build the specified examples."""
    with log_step("🔨 Building project…"):
        Project(create_config(
            examples=examples,
            output=BUILD_DIR,
        )).build()


@examples.command()
@click.argument("examples", nargs=-1)
def watch(examples: tuple[str, ...]) -> None:
    """Watch for changes in specified examples and rebuild them."""
    with log_step("🔨 Watching project…") as logger:
        config = create_config(
            examples=examples,
            output=BUILD_DIR,
        )
        project = Project(config.copy().resolve(ROOT_DIR))

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
    examples: tuple[str, ...] | None = None,
    output: Path | None = None,
) -> ProjectConfig:
    """Create a configuration for the project."""
    return ProjectConfig(
        broadcast=[EXAMPLES_DIR / f"{example}.md" for example in examples or ["*"]],
        data_pack=PackConfig(),
        resource_pack=PackConfig(),
        require=["lectern.contrib.require"],
        pipeline=["lectern"],
        meta={
            "lectern": {
                "load": ".",
            },
        },
        output=output,
    ).resolve(ROOT_DIR)

import time
from pathlib import Path

import click
import watchfiles
from beet import PackConfig, Project, ProjectConfig
from beet.toolchain.commands import error_handler

from bookshelf.definitions import (
    BUILD_DIR,
    EXAMPLES_DIR,
    MODULES_DIR,
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

Path.read_text = utf8_safe_read_text # type: ignore[method-assign]


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

        for changes in watchfiles.watch(MODULES_DIR, EXAMPLES_DIR):
            count = len(changes)
            change, filename = next(iter(changes))

            logger.info("%s %s", click.style(
                time.strftime("%H:%M:%S"),
                fg="green",
                bold=True,
            ), (
                f"{change.name.capitalize()}: {filename}"
                if count == 1 else
                f"{count} changes detected…"
            ))

            build_once()


def create_config(
    examples: tuple[str, ...] | None = None,
    output: Path | None = None,
) -> ProjectConfig:
    """Create a configuration for the project."""
    return ProjectConfig(
        broadcast=[EXAMPLES_DIR / f"{example}.md" for example in examples or ["*"]], # type: ignore[arg-type]
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

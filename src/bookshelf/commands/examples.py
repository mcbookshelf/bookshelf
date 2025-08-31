from __future__ import annotations

from pathlib import Path
from typing import TYPE_CHECKING

import click

from bookshelf.common.logging import summarize_logs
from bookshelf.common.termui import track
from bookshelf.common.utils import watch_and_run
from bookshelf.definitions import BUILD_DIR, EXAMPLES, EXAMPLES_DIR, MODULES_DIR
from bookshelf.services import builder

if TYPE_CHECKING:
    from collections.abc import Sequence

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
    with summarize_logs("🔨 BUILDING EXAMPLES…"):
        build_examples(
            examples or EXAMPLES,
            builder.BuildOptions(output=BUILD_DIR),
        )


@examples.command()
@click.argument("examples", nargs=-1)
def watch(examples: tuple[str, ...]) -> None:
    """Watch for changes in specified examples and rebuild them."""
    with summarize_logs("👀 WATCHING EXAMPLES…"):
        watch_and_run(
            build_examples,
            [MODULES_DIR, EXAMPLES_DIR],
            examples or EXAMPLES,
            builder.BuildOptions(output=BUILD_DIR),
        )


def build_examples(examples: Sequence[str], options: builder.BuildOptions) -> None:
    """Run the build for each example, reporting progress to the user."""
    builder.clean_links()
    for build, example in track((
        f"Build example [green]{example}",
        (builder.build_example, example),
    ) for example in examples):
        build(example, options)

from __future__ import annotations

from pathlib import Path

import click

from bookshelf.common.logging import summarize_logs
from bookshelf.common.termui import track
from bookshelf.common.utils import watch_and_run
from bookshelf.definitions import BUILD_DIR, EXAMPLES, EXAMPLES_DIR
from bookshelf.services import builder

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
@click.argument("examples", default=EXAMPLES, nargs=-1)
def build(examples: tuple[str, ...]) -> None:
    """Build the specified examples."""
    with summarize_logs("🔨 BUILDING EXAMPLES…"):
        entries = track((f"Build example [green]{e}", e) for e in examples)
        builder.ExampleBuilder(
            require=["bookshelf.plugins.build_pack"],
            meta={"build": {"output": BUILD_DIR}},
        ).build(entries)


@examples.command()
@click.argument("examples", nargs=-1)
def watch(examples: tuple[str, ...]) -> None:
    """Watch for changes in specified examples and rebuild them."""
    with summarize_logs("👀 WATCHING EXAMPLES…"):
        def run() -> None:
            entries = track((f"Build example [green]{e}", e) for e in examples)
            builder.ExampleBuilder(
                require=["bookshelf.plugins.build_pack"],
                meta={"build": {"output": BUILD_DIR}},
            ).build(entries)
        watch_and_run(run, EXAMPLES_DIR)

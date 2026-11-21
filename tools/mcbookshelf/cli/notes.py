from pathlib import Path

import click

from mcbookshelf import workspace
from mcbookshelf.workspace import changelog


@click.command()
@click.option(
    "--unreleased",
    is_flag=True,
    help="Gather the `Unreleased` sections.",
)
@click.option(
    "--output",
    type=click.Path(dir_okay=False, writable=True, path_type=Path),
    default=None,
    help="Write the notes to a file instead of printing them.",
)
def notes(*, unreleased: bool, output: Path | None) -> None:
    """Write release notes from module changelogs."""
    text = changelog.notes(workspace.current(), unreleased=unreleased)
    if output is None:
        click.echo(text)
        return
    output.parent.mkdir(parents=True, exist_ok=True)
    output.write_text(text + "\n", "utf-8", newline="\n")

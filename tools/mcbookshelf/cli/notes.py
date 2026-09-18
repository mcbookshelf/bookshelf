from pathlib import Path

import click

from mcbookshelf.workspace import changelog
from mcbookshelf.workspace.changelog import write_text


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
    text = changelog.notes(unreleased=unreleased)
    if output is None:
        click.echo(text)
        return
    write_text(output, text)

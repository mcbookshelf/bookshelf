import os
from pathlib import Path

import click

from mcbookshelf import constants, workspace
from mcbookshelf.workspace import history


@click.command()
def info() -> None:
    """Export release information as GitHub outputs."""
    tag = workspace.release_tag()
    lines = [
        f"version={workspace.release_version()}",
        f"tag={tag}",
        f"tag_exists={str(history.tag_exists(tag)).lower()}",
        f"game_version={constants.GAME_VERSION}",
    ]

    if output := os.environ.get("GITHUB_OUTPUT"):
        with Path(output).open("a", encoding="utf-8") as file:
            file.write("\n".join(lines) + "\n")
        return
    click.echo("\n".join(lines))

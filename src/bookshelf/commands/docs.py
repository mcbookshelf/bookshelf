from __future__ import annotations

import subprocess

import click

from bookshelf.common.utils import locate_command
from bookshelf.definitions import DOC_DIR, EXAMPLES_DIR


@click.group()
def docs() -> None:
    """Documentation-related commands."""


@docs.command()
@click.argument("output_dir", default="_build", required=False)
@click.option("--builder", default="html", help="The builder to use for Sphinx")
def build(output_dir: str, builder: str) -> None:
    """Build static HTML documentation."""
    sphinx = locate_command("sphinx-build")
    subprocess.run(
        (sphinx, ".", "-b", builder, output_dir),
        check=True,
        cwd=DOC_DIR,
    )


@docs.command()
@click.argument("output_dir", default="_build", required=False)
@click.option("--builder", default="html", help="The builder to use for Sphinx")
def watch(output_dir: str, builder: str) -> None:
    """Build and serve live documentation."""
    sphinx = locate_command("sphinx-autobuild")
    subprocess.run(
        (sphinx, ".", "-b", builder, output_dir, "--watch", EXAMPLES_DIR),
        check=True,
        cwd=DOC_DIR,
    )

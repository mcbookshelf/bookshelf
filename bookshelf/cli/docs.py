import shutil
import subprocess

import click

from bookshelf.definitions import DOC_DIR, EXAMPLES_DIR


@click.group()
def docs() -> None:
    """Documentation-related commands."""


@docs.command()
@click.argument("output", required=False)
def build(output: str | None = None) -> None:
    """Build static HTML documentation."""
    sphinx = shutil.which("sphinx-build")
    if not sphinx:
        error_msg = "The 'sphinx-build' command was not found."
        raise FileNotFoundError(error_msg)

    subprocess.run(
        [sphinx, ".", output if output else "_build"],
        check=True,
        cwd=DOC_DIR,
    )


@docs.command()
@click.argument("output", required=False)
def watch(output: str | None = None) -> None:
    """Build and serve live documentation."""
    try:
        sphinx = shutil.which("sphinx-autobuild")
        if not sphinx:
            error_msg = "The 'sphinx-autobuild' command was not found."
            raise FileNotFoundError(error_msg)

        subprocess.run(
            [sphinx, ".", output if output else "_build", "--watch", f"{EXAMPLES_DIR}"],
            check=True,
            cwd=DOC_DIR,
        )

    except KeyboardInterrupt:
        click.echo("\nExiting sphinx-autobuild…")

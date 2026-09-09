import subprocess
from shutil import which

import click

from mcbookshelf import constants, workspace

LOCALE_DIR = "_build/locale"


@click.group()
def docs() -> None:
    """Documentation-related commands."""


@docs.group()
def locales() -> None:
    """Internationalization-related commands."""


@docs.command()
@click.argument("output_dir", default="_build", required=False)
@click.option("--builder", default="html", help="The builder to use for Sphinx")
@click.option("--lang", default="en", help="The language to use for the documentation")
def build(output_dir: str, builder: str, lang: str) -> None:
    """Build static HTML documentation."""
    run("sphinx-build", ".", "-b", builder, "-D", f"language={lang}", output_dir)


@docs.command()
@click.argument("output_dir", default="_build", required=False)
@click.option("--builder", default="html", help="The builder to use for Sphinx")
@click.option("--lang", default="en", help="The language to use for the documentation")
def watch(output_dir: str, builder: str, lang: str) -> None:
    """Build and serve live documentation."""
    args = ["-b", builder, "-D", f"language={lang}"]
    watched = ["--watch", str(constants.EXAMPLES_DIR)]
    for name in (*workspace.modules(), *workspace.bundles()):
        watched.extend(("--watch", str(workspace.file(name))))
    run("sphinx-autobuild", ".", *args, output_dir, *watched, "--ignore", "**/*.mo")


@locales.command()
@click.argument("lang")
def add(lang: str) -> None:
    """Add a new language and create its .po files."""
    run("sphinx-intl", "update", "-p", LOCALE_DIR, "-l", lang)


@locales.command()
def update() -> None:
    """Extract messages and update .po files."""
    run("sphinx-build", ".", "-b", "gettext", LOCALE_DIR)
    for entry in sorted((constants.DOCS_DIR / "_locales").iterdir()):
        if entry.is_dir():
            run("sphinx-intl", "update", "-p", LOCALE_DIR, "-l", entry.name)


def run(command: str, *args: str) -> None:
    executable = which(command)
    if executable is None:
        raise click.ClickException(f"'{command}' was not found in PATH.")
    subprocess.run((executable, *args), check=True, cwd=constants.DOCS_DIR)

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
@click.option("--lang", default="en", help="The language to use for the documentation")
def build(output_dir: str, builder: str, lang: str) -> None:
    """Build static HTML documentation."""
    sphinx = locate_command("sphinx-build")
    subprocess.run((
        sphinx,
        ".",
        "-b",
        builder,
        "-D",
        f"language={lang}",
        output_dir,
    ), check=True, cwd=DOC_DIR)


@docs.command()
@click.argument("output_dir", default="_build", required=False)
@click.option("--builder", default="html", help="The builder to use for Sphinx")
@click.option("--lang", default="en", help="The language to use for the documentation")
def watch(output_dir: str, builder: str, lang: str) -> None:
    """Build and serve live documentation."""
    sphinx = locate_command("sphinx-autobuild")
    subprocess.run((
        sphinx,
        ".",
        "-b",
        builder,
        "-D",
        f"language={lang}",
        output_dir,
        "--watch",
        EXAMPLES_DIR,
        "--ignore",
        "**/*.mo",
    ), check=True, cwd=DOC_DIR)


@docs.group()
def locales() -> None:
    """Internationalization-related commands."""


@locales.command()
@click.argument("lang")
def add(lang: str) -> None:
    """Add a new language and create its .po files."""
    intl = locate_command("sphinx-intl")
    subprocess.run([
        intl,
        "update",
        "-p",
        "_build/locale",
        "-l",
        lang,
    ], check=True, cwd=DOC_DIR)


@locales.command()
def update() -> None:
    """Extract messages and update .po files."""
    sphinx = locate_command("sphinx-build")
    intl = locate_command("sphinx-intl")
    subprocess.run([
        sphinx,
        ".",
        "-b",
        "gettext",
        "_build/locale",
    ], check=True, cwd=DOC_DIR)

    for lang in [
        d.name
        for d in (DOC_DIR / "_locales").iterdir()
        if d.is_dir()
    ]:
        subprocess.run([
            intl,
            "update",
            "-p",
            "_build/locale",
            "-l",
            lang,
        ], check=True, cwd=DOC_DIR)

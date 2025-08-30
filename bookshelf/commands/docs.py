import shutil
import subprocess
from contextlib import suppress

import click

from bookshelf.definitions import DOC_DIR, EXAMPLES_DIR
from bookshelf.logger import log_step


@click.group()
def docs() -> None:
    """Documentation-related commands: build, watch, and manage locales."""


@docs.command()
@click.argument("output", required=False)
@click.option("--builder", default="html", help="The builder to use for Sphinx")
@click.option("--lang", default=None, help="The language to use for the documentation")
def build(
    output: str | None = None,
    builder: str = "html",
    lang: str | None = None,
) -> None:
    """Build static HTML documentation."""
    with log_step("🔨 Building documentation…"):
        subprocess.run([
            command("sphinx-build"),
            ".",
            "-b",
            builder,
            "-D",
            f"language={lang or 'en'}",
            output if output else "_build",
        ], check=True, cwd=DOC_DIR)


@docs.command()
@click.argument("output", required=False)
@click.option("--builder", default="html", help="The builder to use for Sphinx")
@click.option("--lang", default=None, help="The language to use for the documentation")
def watch(
    output: str | None = None,
    builder: str = "html",
    lang: str | None = None,
) -> None:
    """Build and serve live documentation."""
    with log_step("🔨 Watching documentation…"), suppress(KeyboardInterrupt):
        subprocess.run([
            command("sphinx-autobuild"),
            ".",
            "-b",
            builder,
            "-D",
            f"language={lang or 'en'}",
            output if output else "_build",
            "--watch",
            f"{EXAMPLES_DIR}",
            "--ignore",
            "**/*.mo",
        ], check=True, cwd=DOC_DIR)


@docs.group()
def locales() -> None:
    """Internationalization-related commands."""


@locales.command()
@click.argument("lang")
def add(lang: str) -> None:
    """Add a new language and create its .po files."""
    with log_step(f"🔨 Adding new '{lang}' language…"):
        subprocess.run([
            command("sphinx-intl"),
            "update",
            "-p",
            "_build/locale",
            "-l",
            lang,
        ], check=True, cwd=DOC_DIR)


@locales.command()
def update() -> None:
    """Extract messages and update .po files."""
    subprocess.run([
        command("sphinx-build"),
        ".",
        "-b",
        "gettext",
        "_build/locale",
    ], check=True, cwd=DOC_DIR)

    for lang in [
        d.name
        for d in (DOC_DIR / "locales").iterdir()
        if d.is_dir()
    ]:
        subprocess.run([
            command("sphinx-intl"),
            "update",
            "-p",
            "_build/locale",
            "-l",
            lang,
        ], check=True, cwd=DOC_DIR)


def command(name: str) -> str:
    """Return the full path to a command if found, or raise an error."""
    path = shutil.which(name)
    if not path:
        error_msg = f"The '{name}' command was not found."
        raise FileNotFoundError(error_msg)
    return path

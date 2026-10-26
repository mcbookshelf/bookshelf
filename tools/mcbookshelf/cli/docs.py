import os
import subprocess
import sys
import webbrowser
from contextlib import suppress
from pathlib import Path
from shutil import which
from time import perf_counter, strftime
from typing import cast

import click
from rich.markup import escape

from mcbookshelf import constants, workspace

from . import ui

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
@click.option("--host", default="127.0.0.1", help="The address to serve on")
@click.option("--port", default=8000, help="The port to serve on")
@click.option("--open", "browse", is_flag=True, help="Open the browser once built")
def watch(output_dir: str, builder: str, lang: str, host: str, port: int, *, browse: bool) -> None:  # noqa: PLR0913
    """Build and serve live documentation."""
    try:
        from mcbookshelf.sphinx import livereload  # noqa: PLC0415
    except ImportError as error:
        raise click.ClickException(f"the 'docs' dependency group is missing: {error}") from None

    ws = workspace.current()
    metadata = [ws.file(name) for name in (*ws.modules(), *ws.bundles())]
    watched = [constants.DOCS_DIR, constants.EXAMPLES_DIR, *metadata]
    worker = livereload.Worker(constants.DOCS_DIR / output_dir, builder, lang)
    url = f"http://{host}:{port}"

    def build(paths: list[str]) -> dict[str, object]:
        """Build with a spinner, then leave one line: when, what changed, how it went."""
        # Named by the files left: a save also touches folders and short-lived files
        files = ", ".join(sorted({Path(p).name for p in paths if Path(p).is_file()})) or "docs"
        start = perf_counter()
        with ui.console.status(f"[bright_black]building {escape(files)}…"):
            result = worker.build(paths)
        took = f"{perf_counter() - start:.1f}s"
        error = cast("str", result.get("error", ""))
        warnings = cast("str", result.get("warnings", ""))
        mark = "[red]✗" if error else "[yellow]![/]" if warnings else "[green]✓[/]"
        line = f"[bright_black]{strftime('%H:%M:%S')}[/] {mark} {escape(files)}"
        ui.console.print(f"{line} [bright_black]{took}[/]", soft_wrap=True)
        for text, style in ((error, "red"), (warnings, "yellow")):
            for detail in text.replace(f"{constants.DOCS_DIR}{os.sep}", "").splitlines():
                ui.console.print(f"         {detail}", style=style, soft_wrap=True, markup=False)
        return result

    def ready() -> None:
        ui.console.print(f"[bright_black]serving on[/] [bold]{url}[/]")
        if browse:
            webbrowser.open(url)

    ui.heading("👀 WATCHING…")
    try:
        sources = [path for path in watched if path.exists()]
        livereload.serve(worker, (host, port), sources, build=build, ready=ready)
    except OSError as error:
        raise click.ClickException(f"cannot serve on {url}: {error}") from None
    except KeyboardInterrupt:
        raise SystemExit(130) from None


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

    group = subprocess.CREATE_NEW_PROCESS_GROUP if sys.platform == "win32" else 0
    arguments = (executable, *args)
    with subprocess.Popen(arguments, cwd=constants.DOCS_DIR, creationflags=group) as process:
        try:
            while (code := process.poll()) is None:
                with suppress(subprocess.TimeoutExpired):
                    process.wait(timeout=0.2)
        except KeyboardInterrupt:
            stop(process)
            raise SystemExit(130) from None
    if code:
        raise SystemExit(code)


def stop(process: subprocess.Popen[bytes]) -> None:
    """Stop a process and the ones it started, which a kill would leave running on Windows."""
    if sys.platform == "win32":
        tree = ("taskkill", "/F", "/T", "/PID", str(process.pid))
        subprocess.run(tree, check=False, capture_output=True)
    else:
        process.terminate()

from collections.abc import Iterable, Iterator
from pathlib import Path
from time import strftime

import click
import watchfiles

from mcbookshelf import constants, pipeline, workspace
from mcbookshelf.pipeline import Build
from mcbookshelf.pipeline.fingerprint import is_stale, is_stub_stale
from mcbookshelf.pipeline.livereload import livereload

from . import ui

LINKED = Build(link=True)
STUB = Build(stub=True)


@click.command()
@click.argument("names", default=lambda: workspace.current().modules(), nargs=-1)
def build(names: tuple[str, ...]) -> None:
    """Build modules, bundles, or examples."""
    ui.heading("🔨 BUILDING…")
    ui.summary(run(names, LINKED, constants.BUILD_DIR))


@click.command()
@click.argument("names", default=lambda: workspace.current().modules(), nargs=-1)
def watch(names: tuple[str, ...]) -> None:
    """Build, then rebuild what changed when a module or example changes, reloading the world."""
    ui.heading("👀 WATCHING…")
    try:
        with livereload() as reload:
            run(names, LINKED, constants.BUILD_DIR)
            reload()
            for _ in changes(constants.MODULES_DIR, constants.EXAMPLES_DIR):
                run([name for name in names if is_stale(name, LINKED)], LINKED, constants.BUILD_DIR)
                reload()
    except KeyboardInterrupt:
        raise SystemExit(130) from None


@click.command()
@click.argument("names", default=lambda: workspace.current().modules(), nargs=-1)
@click.option("--watch", is_flag=True, help="Update it again when a module changes.")
def stub(names: tuple[str, ...], *, watch: bool) -> None:
    """Write the files the modules generate, for the editor to know them, without their packs."""
    ui.heading("🧩 UPDATING THE STUB…")
    if not watch:
        if stale := [name for name in names if is_stub_stale(name)]:
            ui.summary(run(stale, STUB))
        else:
            ui.dim("Every module is up to date.")
        return
    try:
        run([name for name in names if is_stub_stale(name)], STUB)
        ui.dim("Watching the modules…")
        for _ in changes(constants.MODULES_DIR):
            run([name for name in names if is_stub_stale(name)], STUB)
    except KeyboardInterrupt:
        raise SystemExit(130) from None


def changes(*directories: Path) -> Iterator[None]:
    """Wait for each change of the directories, tell its files and read the workspace again."""
    for batch in watchfiles.watch(*directories):
        files = ", ".join(sorted({Path(f).name for _, f in batch}))
        ui.dim(f"{strftime('%H:%M:%S')} changed: {files}")
        workspace.current.cache_clear()
        yield


def run(names: Iterable[str], options: Build, output: Path | None = None) -> int:
    """Build each name with a progress line, and count the failures."""
    with ui.tracking(names) as tracker:
        for name in names:
            pipeline.build(name, options, tracker.done, output)
    return tracker.errors

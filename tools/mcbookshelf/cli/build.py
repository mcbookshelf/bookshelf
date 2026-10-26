from collections.abc import Iterable
from pathlib import Path
from time import strftime

import click
import watchfiles

from mcbookshelf import constants, pipeline, workspace
from mcbookshelf.pipeline import Build
from mcbookshelf.pipeline.livereload import livereload

from . import ui


@click.command()
@click.argument("names", default=lambda: workspace.current().modules(), nargs=-1)
def build(names: tuple[str, ...]) -> None:
    """Build modules, bundles, or examples."""
    ui.heading("🔨 BUILDING…")
    ui.summary(run(names, constants.BUILD_DIR, Build(link=True)))


@click.command()
@click.argument("names", default=lambda: workspace.current().modules(), nargs=-1)
def watch(names: tuple[str, ...]) -> None:
    """Build, then rebuild when a module or example changes, reloading the linked world."""
    ui.heading("👀 WATCHING…")
    try:
        with livereload() as reload:
            run(names, constants.BUILD_DIR, Build(link=True))
            reload()
            for changes in watchfiles.watch(constants.MODULES_DIR, constants.EXAMPLES_DIR):
                files = ", ".join(sorted({Path(f).name for _, f in changes}))
                ui.dim(f"{strftime('%H:%M:%S')} changed: {files}")
                workspace.current.cache_clear()
                run(names, constants.BUILD_DIR, Build(link=True))
                reload()
    except KeyboardInterrupt:
        raise SystemExit(130) from None


def run(names: Iterable[str], output: Path, options: Build) -> int:
    """Build each name with a progress line, and count the failures."""
    with ui.tracking(names) as tracker:
        for name in names:
            pipeline.build(name, options, tracker.done, output=output)
    return tracker.errors

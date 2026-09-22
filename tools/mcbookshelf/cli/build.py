from collections.abc import Iterable
from pathlib import Path
from time import strftime

import click
import watchfiles

from mcbookshelf import constants, package, workspace
from mcbookshelf.package import Build

from . import ui

LINKED = Build(link=True)


@click.command()
@click.argument("names", default=workspace.modules(), nargs=-1)
def build(names: tuple[str, ...]) -> None:
    """Build modules, bundles, or examples."""
    ui.heading("🔨 BUILDING…")
    ui.summary(run(names, constants.BUILD_DIR, LINKED))


@click.command()
@click.argument("names", default=workspace.modules(), nargs=-1)
def watch(names: tuple[str, ...]) -> None:
    """Build, then rebuild when a module or example changes."""
    ui.heading("👀 WATCHING…")
    run(names, constants.BUILD_DIR, LINKED)
    for changes in watchfiles.watch(constants.MODULES_DIR, constants.EXAMPLES_DIR):
        files = ", ".join(sorted({Path(f).name for _, f in changes}))
        ui.dim(f"{strftime('%H:%M:%S')} changed: {files}")
        workspace.forget()
        run(names, constants.BUILD_DIR, LINKED)


def run(names: Iterable[str], output: Path, options: Build) -> int:
    """Build each name with a progress line, and count the failures."""
    with ui.tracking(names) as tracker:
        for name in names:
            package.build(name, options, tracker.done, output=output)
    return tracker.errors

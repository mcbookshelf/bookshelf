import click

from mcbookshelf import constants, package, workspace
from mcbookshelf.package import Build

from . import ui


@click.command()
@click.option(
    "--all",
    "everything",
    is_flag=True,
    help="Include experimental features and modules under 1.0.0.",
)
def release(*, everything: bool) -> None:
    """Build every released module and bundle as minified zips, each with its stub."""
    ui.heading("📦 RELEASING…")
    options = Build(tests=False, minify=True, zipped=True, versioned=True, experimental=everything)
    names = workspace.modules() if everything else workspace.released()
    with ui.tracking((*names, *workspace.bundles())) as tracker:
        package.release(names, options, tracker.done, constants.RELEASE_DIR)
    ui.summary(tracker.errors)

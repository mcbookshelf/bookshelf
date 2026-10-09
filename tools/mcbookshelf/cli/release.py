import click

from mcbookshelf import constants, pipeline, workspace
from mcbookshelf.pipeline import Build

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
    ws = workspace.current()
    names = ws.modules() if everything else ws.released()
    with ui.tracking((*names, *ws.bundles())) as tracker:
        pipeline.release(names, options, tracker.done, constants.RELEASE_DIR)
    ui.summary(tracker.errors)

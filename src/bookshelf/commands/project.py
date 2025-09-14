from __future__ import annotations

import click
from beet import Project, ProjectConfig

from bookshelf.common.logging import log_errors, summarize_logs
from bookshelf.common.termui import track
from bookshelf.definitions import ROOT_DIR
from bookshelf.services import updater, validator


@click.command()
def check() -> None:
    """Check the integrity of the project (metadata, headers, ...)."""
    with summarize_logs("🔍 CHECKING PROJECT…", exit_on_errors=True):
        for task in track((
            ("Check required files", validator.check_required_files),
            ("Check modules metadata", validator.check_modules_metadata),
            ("Check features metadata", validator.check_features_metadata),
            ("Check function headers", validator.check_function_headers),
        )):
            log_errors(task())


@click.command()
@click.option("--versions", is_flag=True)
def update(*, versions: bool) -> None:
    """Update the manifest and optionally update versions."""
    with summarize_logs("📑 UPDATING PROJECT…", exit_on_errors=True):
        tasks = [("Update manifest", updater.update_manifest)]
        if versions:
            tasks.append(("Update versions", updater.update_versions))
            tasks.append(("Update switcher", updater.update_switcher))
        for task in track(tasks, show_pending=False):
            task()


@click.command()
@click.argument("world", required=False)
@click.option(
    "--minecraft",
    metavar="DIRECTORY",
    help="Path to the .minecraft directory.",
)
@click.option(
    "--data-pack",
    metavar="DIRECTORY",
    help="Path to the data packs directory.",
)
@click.option(
    "--resource-pack",
    metavar="DIRECTORY",
    help="Path to the resource packs directory.",
)
def link(
    world: str | None,
    minecraft: str | None,
    data_pack: str | None,
    resource_pack: str | None,
) -> None:
    """Link the generated resource pack and data pack to Minecraft."""
    with summarize_logs("🔗 LINKING PROJECT…", exit_on_errors=True):
        project = Project(ProjectConfig().resolve(ROOT_DIR))
        click.echo(project.link(
            world,
            minecraft,
            data_pack,
            resource_pack,
        ))

import click
from beet import Project, ProjectConfig

from mcbookshelf import constants

from . import ui


@click.command()
@click.argument("world", required=False)
@click.option("--minecraft", metavar="DIRECTORY", help="The .minecraft directory.")
@click.option("--data-pack", metavar="DIRECTORY", help="The data packs directory.")
@click.option("--resource-pack", metavar="DIRECTORY", help="The resource packs folder.")
def link(
    world: str | None,
    minecraft: str | None,
    data_pack: str | None,
    resource_pack: str | None,
) -> None:
    """Link the built packs to a Minecraft world."""
    ui.heading("🔗 LINKING…")
    project = Project(resolved_config=ProjectConfig().resolve(constants.ROOT_DIR))
    ui.console.print(project.link(world, minecraft, data_pack, resource_pack))

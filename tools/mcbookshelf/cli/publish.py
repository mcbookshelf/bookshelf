from asyncio import run
from collections.abc import Awaitable, Callable
from dataclasses import dataclass
from os import getenv

import click

from mcbookshelf.publish import Pack, get_packs, modrinth, smithed

from . import ui


@dataclass(frozen=True)
class Platform:

    token: str
    publish: Callable[[list[Pack], str], Awaitable[list[Exception]]]


PLATFORMS = {
    "modrinth": Platform("MODRINTH_TOKEN", modrinth.publish),
    "smithed": Platform("SMITHED_TOKEN", smithed.publish),
}


@click.command()
@click.option(
    "--platform",
    "platforms",
    type=click.Choice(list(PLATFORMS)),
    multiple=True,
    help="Platform to publish to, repeatable. Defaults to all platforms.",
)
@click.option("--dry-run", is_flag=True, help="List the packs and stop.")
def publish(platforms: tuple[str, ...], *, dry_run: bool) -> None:
    """Push the release directory to platforms."""
    ui.heading("🚀 PUBLISHING…")
    try:
        packs = get_packs()
    except ValueError as error:
        raise click.ClickException(str(error)) from None
    for pack in packs:
        ui.dim(f"{pack.id} {pack.version}")
    if dry_run:
        ui.summary(0)
        return

    tokens = {}
    selected = platforms or tuple(PLATFORMS)
    for name in selected:
        token = getenv(PLATFORMS[name].token)
        if not token:
            raise click.ClickException(f"{name}: {PLATFORMS[name].token} is not set")
        tokens[name] = token

    failures = []
    with ui.tracking(selected) as tracker:
        for name in selected:
            errors = run(PLATFORMS[name].publish(packs, tokens[name]))
            failures.extend(errors)
            tracker.done(name, f"{len(errors)} failed" if errors else None)
    for error in failures:
        ui.console.print(str(error), style="red")
    ui.summary(len(failures))

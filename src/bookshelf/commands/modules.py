from __future__ import annotations

from itertools import groupby
from pathlib import Path
from tempfile import TemporaryDirectory
from typing import TYPE_CHECKING

import click
from mcward import WardError
from mcward.cli.datapacks import discover_datapacks, pack_resolver
from mcward.cli.environments import get_environments, manager, start_environments
from mcward.cli.reporters import github, live
from rich import get_console

from bookshelf.common.logging import summarize_logs
from bookshelf.common.termui import track
from bookshelf.common.utils import watch_and_run
from bookshelf.definitions import (
    BUILD_DIR,
    BUNDLES,
    MC_VERSIONS,
    MODULES,
    MODULES_DIR,
    RELEASE_DIR,
)
from bookshelf.services import builder, publishers

if TYPE_CHECKING:
    from mcward import Version
    from mcward.cli.datapacks import DataPack


@click.group()
def modules() -> None:
    """Modules-related commands."""


@modules.command()
@click.argument("modules", default=MODULES, nargs=-1)
def build(modules: tuple[str, ...]) -> None:
    """Build the specified modules."""
    with summarize_logs("🔨 BUILDING MODULES…"):
        entries = track((f"Build module [green]{m}", m) for m in modules)
        builder.ModuleBuilder(
            require=["bookshelf.plugins.build_pack"],
            meta={"build": {"output": BUILD_DIR}},
        ).build(entries)


@modules.command()
@click.argument("modules", default=MODULES, nargs=-1)
def watch(modules: tuple[str, ...]) -> None:
    """Watch for changes in specified modules and rebuild them."""
    with summarize_logs("👀 WATCHING MODULES…"):
        def run() -> None:
            entries = track((f"Build module [green]{m}", m) for m in modules)
            builder.ModuleBuilder(
                require=["bookshelf.plugins.build_pack"],
                meta={"build": {"output": BUILD_DIR}},
            ).build(entries)
        watch_and_run(run, MODULES_DIR)


@modules.command()
def release() -> None:
    """Build and release zipped modules."""
    with summarize_logs("🔨 BUILDING MODULES…", exit_on_errors=True):
        packs = []
        entries = track((f"Build module [green]{m}", m) for m in [*BUNDLES, *MODULES])
        builder.ModuleBuilder(
            require=["bookshelf.plugins.release_pack"],
            meta={"release": {
                "output": RELEASE_DIR,
                "enqueue": packs.append,
            }, "versions": MC_VERSIONS},
        ).build(entries)

    with summarize_logs("🚀 PUBLISHING MODULES…", exit_on_errors=True):
        for publish in track([
            ("Publish to [green]Modrinth[/green]", publishers.publish_to_modrinth),
            ("Publish to [green]Smithed[/green]", publishers.publish_to_smithed),
        ]):
            publish(packs)


@modules.command()
@click.argument("modules", default=MODULES, nargs=-1)
@click.option(
    "--versions",
    is_flag=True,
    help="Test on all compatible versions instead of only the latest.",
)
@click.option(
    "--reporter",
    type=click.Choice(["live", "github"]),
    default="live",
    help="Result output: interactive live display, or GitHub Actions annotations.",
)
def test(
    modules: tuple[str, ...],
    *,
    versions: bool,
    reporter: str,
) -> None:
    """Build and test modules."""
    selector = "*:*"
    if len(modules) == 1 and ":" in modules[0]:
        module, _, path = modules[0].partition(":")
        selector = f"{module}:{path or '*'}"
        modules = (module,)

    with TemporaryDirectory() as directory:
        output = Path(directory)

        with summarize_logs("🔨 BUILDING MODULES…", exit_on_errors=True):
            entries = track((f"Build module [green]{m}", m) for m in modules)
            builder.ModuleBuilder(
                require=["bookshelf.plugins.build_pack"],
                meta={"build": {
                    "output": output,
                    "link": False,
                }, "versions": MC_VERSIONS},
                zipped=True,
            ).build(entries)

        console = get_console()
        console.print("")
        console.print("🔬 TESTING MODULES…", style="b bright_black", highlight=False)
        console.print("┈" * 32, style="bright_black")

        datapacks = discover_datapacks([str(path) for path in output.iterdir()])
        if not datapacks:
            err = "No datapacks found in the build output"
            raise click.ClickException(err)

        selected = resolve_versions(datapacks, all_versions=versions)
        try:
            envs = start_environments(get_environments(selected))
            run = github.run if reporter == "github" else live.run
            resolve = pack_resolver([MODULES_DIR / m for m in modules])
            paths = [datapack.path for datapack in datapacks]
            run(paths, envs, resolve=resolve, selector=selector)
        except WardError as e:
            raise click.ClickException(str(e)) from e


def resolve_versions(
    datapacks: list[DataPack],
    *,
    all_versions: bool,
) -> list[Version]:
    """Resolve the newest compatible version of each major line, or the latest one."""
    min_format = max(datapack.min_format for datapack in datapacks)
    max_format = min(datapack.max_format for datapack in datapacks)

    compatible = manager.list_compatible(min_format, max_format)
    if not compatible:
        err = (
            "No compatible versions found for pack format range "
            f"{min_format}..{max_format}"
        )
        raise click.ClickException(err)

    lines = groupby(compatible, key=lambda version: (version.year, version.major))
    selected = [next(group) for _, group in lines]
    return selected if all_versions else selected[:1]

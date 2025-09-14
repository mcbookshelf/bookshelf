from __future__ import annotations

from pathlib import Path
from tempfile import TemporaryDirectory
from typing import TYPE_CHECKING

import click

from bookshelf.common.logging import summarize_logs
from bookshelf.common.termui import track
from bookshelf.common.utils import watch_and_run
from bookshelf.definitions import BUILD_DIR, BUNDLES, MC_VERSIONS, MODULES, MODULES_DIR
from bookshelf.services import builder, packtest, publishers

if TYPE_CHECKING:
    from collections.abc import Sequence


@click.group()
def modules() -> None:
    """Modules-related commands."""


@modules.command()
@click.argument("modules", nargs=-1)
def build(modules: tuple[str, ...]) -> None:
    """Build the specified modules."""
    with summarize_logs("🔨 BUILDING MODULES…"):
        build_modules(
            modules or MODULES,
            builder.BuildOptions(
                require=["bookshelf.plugins.include_tests"],
                output=BUILD_DIR,
            ),
        )


@modules.command()
@click.argument("modules", nargs=-1)
def watch(modules: tuple[str, ...]) -> None:
    """Watch for changes in specified modules and rebuild them."""
    with summarize_logs("👀 WATCHING MODULES…"):
        watch_and_run(
            build_modules,
            [MODULES_DIR],
            modules or MODULES,
            builder.BuildOptions(
                require=["bookshelf.plugins.include_tests"],
                output=BUILD_DIR,
            ),
        )


@modules.command()
def release() -> None:
    """Build and release zipped modules."""
    packs = []
    with summarize_logs("🔨 BUILDING MODULES…", exit_on_errors=True):
        build_modules([*BUNDLES, *MODULES], builder.BuildOptions(
            zipped=True,
            require=["bookshelf.plugins.release_pack"],
            meta={
                "autosave": {"link": False},
                "publish": lambda spec: packs.append(spec),
            },
        ))

    with summarize_logs("🚀 PUBLISHING MODULES…", exit_on_errors=True):
        for publish in track([
            ("Publish to [green]Modrinth[/green]", publishers.publish_to_modrinth),
            ("Publish to [green]Smithed[/green]", publishers.publish_to_smithed),
        ]):
            publish(packs)


@modules.command()
@click.argument("modules", nargs=-1)
@click.option("--versions", is_flag=True)
def test(modules: tuple[str, ...], *, versions: bool) -> None:
    """Build and test modules."""
    with TemporaryDirectory() as directory:
        with summarize_logs("🔨 BUILDING MODULES…", exit_on_errors=True):
            build_modules(
                modules or MODULES,
                builder.BuildOptions(
                    require=["bookshelf.plugins.include_tests"],
                    meta={"autosave": {"link": False}},
                    output=(output := Path(directory)),
                    zipped=True,
                ),
            )

        with summarize_logs("🔬 TESTING MODULES…", exit_on_errors=True):
            for worker in track([(
                f"Test version [green]{v}[/green]",
                packtest.run(output, v),
            ) for v in (reversed(MC_VERSIONS) if versions else MC_VERSIONS[-1:])]):
                for event in worker:
                    event.log()


def build_modules(modules: Sequence[str], options: builder.BuildOptions) -> None:
    """Run the build for each module, reporting progress to the user."""
    builder.clean_links()
    for build, module in track((
        f"Build module [green]{module}",
        (builder.build_module, module),
    ) for module in modules):
        build(module, options)

from __future__ import annotations

import asyncio
from pathlib import Path
from tempfile import TemporaryDirectory

import click

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
from bookshelf.services import builder, packtest, publishers


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
                "enqueue": lambda spec: packs.append(spec),
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
@click.option("--versions", is_flag=True)
def test(modules: tuple[str, ...], *, versions: bool) -> None:
    """Build and test modules."""
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

        with summarize_logs("🔬 TESTING MODULES…", exit_on_errors=True):
            async def test_modules() -> None:
                vers = list(reversed(MC_VERSIONS)) if versions else MC_VERSIONS[-1:]
                coros = [packtest.run(output, v) for v in vers]
                tasks = [asyncio.create_task(coro) for coro in coros]

                for task in track(
                    (f"Test version [green]{v}[/green]", t)
                    for v, t in zip(vers, tasks, strict=True)
                ):
                    logs = await task
                    for event in logs:
                        event.log()

            asyncio.run(test_modules())

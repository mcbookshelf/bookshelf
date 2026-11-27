import sys
from pathlib import Path

import click
from mcward import TestSession
from mcward.beet import test_project
from mcward.cli.session import check_watch, load_config, test_options
from mcward.cli.watch import watch as watch_tests
from mcward.cli.writers import is_report_file, parse_coverage_report
from rich.markup import escape

from mcbookshelf import constants, pipeline, workspace
from mcbookshelf.pipeline.config import ward_config

from . import ui

OPTIONS = (
    "reporter",
    "coverage",
    "coverage_reports",
    "coverage_min",
    "junit_xml",
    "verbose",
    "watch",
)


@click.command(
    params=[
        param
        for param in click.command("mcward")(test_options(lambda: None)).params
        if param.name in OPTIONS
    ],
)
@click.argument("modules", default=lambda: workspace.current().modules(), nargs=-1)
def test(  # noqa: PLR0913
    modules: tuple[str, ...],
    *,
    reporter: str,
    coverage: bool,
    coverage_reports: tuple[str, ...],
    coverage_min: float | None,
    junit_xml: Path | None,
    verbose: bool,
    watch: bool,
) -> None:
    """Build the modules as one pack and run their tests."""
    check_watch(watch, reporter)
    config = load_config(None)
    specs = [parse_coverage_report(value) for value in coverage_reports]
    default = f"{modules[0]}:*" if len(modules) == 1 else "*:*"

    def run(selector: str) -> TestSession:
        ui.heading("🔬 TESTING…")
        return test_project(
            pipeline.project(ward_config(modules)),
            config,
            versions=[constants.GAME_VERSION],
            reporter=reporter,
            selector=selector,
            coverage=coverage,
            coverage_specs=specs,
            coverage_min=coverage_min,
            junit_xml=junit_xml,
            verbose=verbose,
        )

    def rerun(selector: str) -> None:
        """Build and test again; a failed build is shown and the watch goes on."""
        workspace.current.cache_clear()
        try:
            run(selector)
        except click.ClickException:
            raise
        except Exception as error:  # noqa: BLE001
            ui.console.print(f"[red]{escape(pipeline.describe(error))}")

    if watch:
        watch_tests(
            rerun,
            default,
            [constants.MODULES_DIR, config.world] if config.world else [constants.MODULES_DIR],
            ignore=lambda path: is_report_file(path, specs, junit_xml),
        )
    elif run(default).failed:
        sys.exit(1)

import sys
from pathlib import Path

import click
from mcward.beet import test_project
from mcward.cli.reports import parse_coverage_report

from mcbookshelf import constants, package, workspace
from mcbookshelf.package.config import ward_config

from . import ui


@click.command()
@click.argument("modules", default=workspace.modules(), nargs=-1)
@click.option(
    "--coverage",
    is_flag=True,
    help="Record executed commands and report line coverage.",
)
@click.option(
    "--coverage-report",
    "coverage_reports",
    multiple=True,
    metavar="FORMAT[:PATH]",
    help="Write coverage as `lcov` or `html`, optionally to a path.",
)
@click.option(
    "--reporter",
    type=click.Choice(["live", "github"]),
    default="live",
    help="Result output: live display or GitHub Actions annotations.",
)
@click.option(
    "--junit-xml",
    type=click.Path(dir_okay=False, writable=True, path_type=Path),
    default=None,
    help="Write test results as JUnit XML.",
)
@click.option(
    "--verbose",
    is_flag=True,
    help="List every test and coverage row instead of collapsing large runs.",
)
def test( # noqa: PLR0913
    modules: tuple[str, ...],
    *,
    reporter: str,
    coverage: bool,
    coverage_reports: tuple[str, ...],
    junit_xml: Path | None,
    verbose: bool,
) -> None:
    """Build the modules as one pack and run their tests."""
    specs = [parse_coverage_report(value) for value in coverage_reports]
    ui.heading("🔬 TESTING…")
    project = package.project(ward_config(modules))

    if test_project(
        project,
        versions=[constants.GAME_VERSION],
        reporter=reporter,
        selector=f"{modules[0]}:*" if len(modules) == 1 else "*:*",
        coverage=coverage or bool(specs),
        coverage_specs=specs,
        junit_xml=junit_xml,
        verbose=verbose,
    ).failed:
        sys.exit(1)

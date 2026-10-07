import click

from mcbookshelf import workspace
from mcbookshelf.workspace import bumps, history

from . import ui


@click.command()
@click.option("--check", is_flag=True, help="Check a release branch without applying changes.")
def bump(*, check: bool) -> None:
    """Check or apply the versions required for a release."""
    ui.heading("🔢 CHECKING VERSIONS…" if check else "🔢 BUMPING…")
    ws = workspace.current()
    tag = history.previous_tag(ws)
    if tag is None:
        ui.dim("no previous release")
        ui.summary(0)
        return
    ui.dim(f"since {tag}")

    errors = 0
    for expectation in bumps.expectations(ws, tag):
        where = f"{expectation.name}: {expectation.current} → {expectation.expected}"
        if check:
            errors += 1
            ui.console.print(f"✗ {where} ({expectation.reason})", style="red")
        else:
            bumps.apply(ws, expectation)
            ui.console.print(f"✓ {where} ({expectation.reason})", style="green")
    if check:
        for problem in bumps.problems(ws, tag):
            errors += 1
            ui.console.print(f"✗ {problem}", style="red")
    ui.summary(errors)

import click

from mcbookshelf import validation, workspace

from . import ui


@click.command()
@click.argument("modules", default=workspace.modules(), nargs=-1)
def check(modules: tuple[str, ...]) -> None:
    """Check modules and report every issue."""
    ui.heading("🔍 CHECKING…")
    issues = {}
    with ui.tracking(modules) as tracker:
        for name in modules:
            issues[name] = validation.check_module(name)
            count = len(issues[name])
            tracker.done(name, f"found {count} issue{'s' if count > 1 else ''}" if count else None)
    for name, module_issues in issues.items():
        if module_issues:
            ui.console.print(f"\n[bold]{name}[/]")
        for issue in module_issues:
            ui.dim(str(issue))
    ui.summary(tracker.errors)

from collections.abc import Generator, Iterable
from contextlib import contextmanager
from dataclasses import dataclass, field

from rich.console import Console, RenderableType
from rich.markup import escape
from rich.progress import Progress, SpinnerColumn, Task, TaskID, TextColumn, TimeElapsedColumn
from rich.text import Text

console = Console(highlight=False, emoji=False)


def dim(text: str) -> None:
    console.print(text, style="bright_black", soft_wrap=True, markup=False)


def heading(text: str) -> None:
    console.print()
    console.print(text, style="bold bright_black")
    console.print("┈" * 32, style="bright_black")


def summary(errors: int) -> None:
    """Print the final status and exit with an error when needed."""
    if errors:
        plural = "S" if errors > 1 else ""
        console.print(f"\nDONE WITH {errors} ERROR{plural}!\n", style="bold red")
        raise SystemExit(1)
    console.print("\nDONE WITH SUCCESS!\n", style="bold green")


@dataclass
class Tracker:

    progress: Progress
    tasks: dict[str, TaskID]
    errors: int = field(default=0, init=False)
    details: dict[str, str] = field(default_factory=dict, init=False)

    def done(self, name: str, error: str | None) -> None:
        """Mark a task done; an error shows its first line, the rest is printed at the end."""
        task = self.tasks[name]
        if error is None:
            self.progress.update(task, mark="[green]✓")
        else:
            self.errors += 1
            first, _, rest = error.partition("\n")
            description = f"[red]{escape(f'{name}: {first}')}"
            self.progress.update(task, mark="[red]✗", description=description)
            if rest:
                self.details[name] = rest
        self.progress.advance(task)


class StatusColumn(SpinnerColumn):
    """A spinner while the task runs, then the mark its outcome left."""

    def render(self, task: Task) -> RenderableType:
        if task.finished:
            return Text.from_markup(task.fields.get("mark", ""))
        return super().render(task)


@contextmanager
def tracking(names: Iterable[str]) -> Generator[Tracker]:
    columns = (StatusColumn(), TextColumn("{task.description}"))
    with Progress(*columns, TimeElapsedColumn(), console=console) as progress:
        tracker = Tracker(progress, {name: progress.add_task(name, total=1) for name in names})
        yield tracker
    for name, details in tracker.details.items():
        console.print(f"\n[bold]{escape(name)}[/]")
        dim(details)

from collections.abc import Generator, Iterable
from contextlib import contextmanager
from dataclasses import dataclass, field

from rich.console import Console
from rich.progress import Progress, SpinnerColumn, TaskID, TextColumn, TimeElapsedColumn

console = Console(highlight=False)


def dim(text: str) -> None:
    console.print(text, style="bright_black", soft_wrap=True)


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
    errors: int = field(default=0, init=False)
    tasks: dict[str, TaskID]

    def done(self, name: str, error: str | None) -> None:
        if error is not None:
            self.errors += 1
            self.progress.update(self.tasks[name], description=f"[red]{name}: {error}")
        self.progress.advance(self.tasks[name])


@contextmanager
def tracking(names: Iterable[str]) -> Generator[Tracker]:
    columns = (SpinnerColumn(finished_text="[green]✓"), TextColumn("{task.description}"))
    with Progress(*columns, TimeElapsedColumn(), console=console) as progress:
        yield Tracker(progress, {name: progress.add_task(name, total=1) for name in names})

from __future__ import annotations

from typing import TYPE_CHECKING

from rich import get_console
from rich.progress import Progress, SpinnerColumn, TextColumn, TimeElapsedColumn

from bookshelf.definitions import GITHUB_WORKSPACE

if TYPE_CHECKING:
    from collections.abc import Generator, Iterable

    from rich.console import Console


def track[T](
    sequence: Iterable[tuple[str, T]],
    *,
    console: Console | None = None,
    show_pending: bool = True,
) -> Generator[T, None, None]:
    """Yield items from a sequence while displaying progress output."""
    if GITHUB_WORKSPACE:
        yield from _track_github(sequence, console=console)
    else:
        yield from _track_console(sequence, console=console, show_pending=show_pending)


def _track_github[T](
    sequence: Iterable[tuple[str, T]],
    *,
    console: Console | None = None,
) -> Generator[T, None, None]:
    console = console or get_console()
    for name, item in sequence:
        console.print(f"::group::{name}")
        try:
            yield item
        finally:
            console.print("::endgroup::")


def _track_console[T](
    sequence: Iterable[tuple[str, T]],
    *,
    console: Console | None = None,
    show_pending: bool = True,
) -> Generator[T, None, None]:
    with Progress(
        SpinnerColumn(finished_text="[green]✔"),
        TextColumn("{task.description}"),
        TimeElapsedColumn(),
        console=console,
    ) as progress:
        for item, task in [(item, progress.add_task(
            name,
            total=1,
            visible=show_pending,
        )) for name, item in sequence]:
            try:
                progress.update(task, visible=True)
                yield item
            finally:
                progress.advance(task)

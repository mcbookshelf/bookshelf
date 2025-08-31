from __future__ import annotations

import logging
from collections import defaultdict
from contextlib import contextmanager
from sys import stdout
from types import MappingProxyType
from typing import TYPE_CHECKING, Any

import beet
import click
import lectern
from rich import get_console
from rich.logging import RichHandler
from rich.traceback import install

from bookshelf.common import errors

if TYPE_CHECKING:
    from collections.abc import Generator, Iterable

    from rich.console import Console

logger = logging.getLogger("bookshelf")


def setup_github() -> None:
    """Configure the 'bookshelf' logger for GitHub Actions."""
    logger.setLevel(logging.DEBUG)

    handler = logging.StreamHandler(stdout)
    handler.setFormatter(GitHubFormatter())
    logger.addHandler(handler)


def setup_rich() -> None:
    """Configure the default 'bookshelf' logger for console output."""
    install(
        max_frames=20,
        suppress=[beet, click, lectern],
    )

    logger.setLevel(logging.DEBUG)

    handler = RichHandler(
        markup=True,
        rich_tracebacks=True,
        show_path=False,
        show_time=False,
        tracebacks_suppress=[beet, click, lectern],
    )
    handler.setFormatter(RichFormatter())
    logger.addHandler(handler)


class GitHubFormatter(logging.Formatter):
    """Formatter that emits GitHub annotations with optional title, file, and line."""

    ANNOTATIONS = MappingProxyType({
        logging.DEBUG: "debug",
        logging.INFO: "notice",
        logging.WARNING: "warning",
        logging.ERROR: "error",
        logging.CRITICAL: "error",
    })

    def format(self, record: logging.LogRecord) -> str:
        """Format a LogRecord with optional title and file/line information."""
        message = super().format(record)

        title = getattr(record, "title", None)
        file = getattr(record, "file", None)
        line = getattr(record, "line", None)

        if file or line:
            loc = ":".join(map(str, filter(None, [file, line])))
            message = f"{message} ({loc})"

        if annotation := self.ANNOTATIONS.get(record.levelno):
            return f"::{annotation} {", ".join(filter(None, [
                f"title={title}" if title else None,
                f"file={file}" if file else None,
                f"line={line}" if line else None,
            ]))}::{message}"

        return message


class RichFormatter(logging.Formatter):
    """Formatter that optionally adds title and file/line info from log `extra`."""

    def format(self, record: logging.LogRecord) -> str:
        """Format a LogRecord with optional title and file/line information."""
        message = super().format(record)

        title = getattr(record, "title", None)
        file = getattr(record, "file", None)
        line = getattr(record, "line", None)

        if title:
            message = f"[red]{title}[/red]: {message}"

        if file or line:
            loc = ":".join(map(str, filter(None, [file, line])))
            message = f"{message} [bright_black]({loc})[/bright_black]"

        return message


class LogCounterHandler(logging.Handler):
    """A logging handler that counts log messages by level."""

    def __init__(self) -> None:
        """Initialize the counter."""
        self.counts = defaultdict(int)
        super().__init__()

    def emit(self, record: logging.LogRecord) -> None:
        """Count log messages by level."""
        self.counts[record.levelname.lower()] += 1


def log_errors(
    exceptions: Iterable[BaseException],
    logger: logging.Logger = logger,
) -> None:
    """Log a sequence of errors."""
    for e in exceptions:
        if isinstance(e, errors.BookshelfCompositeError):
            log_errors(e.exceptions)
        elif isinstance(e, errors.BookshelfError):
            logger.error(e, extra={
                "title": e.title,
                "file": e.file,
                "line": e.line,
            })
        else:
            logger.error(
                str(e),
                exc_info=e,
                extra={"title": "UnexpectedError"},
            )


@contextmanager
def count_logs(
    logger: logging.Logger = logger,
) -> Generator[dict, Any, None]:
    """Context manager to count log messages."""
    handler = LogCounterHandler()
    logger.addHandler(handler)

    try:
        yield handler.counts
    finally:
        logger.removeHandler(handler)


@contextmanager
def summarize_logs(
    heading: str | None = None,
    console: Console | None = None,
    logger: logging.Logger = logger,
    *,
    exit_on_errors: bool = False,
) -> Generator[dict, Any, None]:
    """Context manager to count logs and print a summary at the end."""
    console = console or get_console()
    logger = logger or logging.getLogger("bookshelf")

    with count_logs(logger) as counter:
        if heading:
            console = console or get_console()
            console.print("")
            console.print(heading, style="b bright_black", highlight=False)
            console.print("┈" * 32, style="bright_black")
        yield counter

    e = counter.get("error", 0)
    w = counter.get("warning", 0)
    e_msg = f"{e} ERROR{'S' if e > 1 else ''}"
    w_msg = f"{w} WARNING{'S' if w > 1 else ''}"

    match e, w:
        case 0, 0:
            console.print("\n✅ DONE WITH SUCCESS!\n", style="green b")
        case 0, w:
            console.print(f"\n🔔 DONE WITH {w_msg}!\n", style="yellow b")
        case e, 0:
            console.print(f"\n🚨 DONE WITH {e_msg}!\n", style="red b")
        case e, w:
            console.print(f"\n🚨 DONE WITH {e_msg} and {w_msg}!\n", style="red b")

    if exit_on_errors and e > 0:
        raise SystemExit(1)

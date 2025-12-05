from __future__ import annotations

from pathlib import Path
from shutil import which
from time import strftime
from typing import TYPE_CHECKING

from beet.toolchain.commands import error_handler
from pydantic import BaseModel, ValidationError
from rich.console import Console
from watchfiles import watch

from bookshelf.common import errors
from bookshelf.definitions import GITHUB_REPO, ROOT_DIR, VERSION

if TYPE_CHECKING:
    from collections.abc import Callable


def locate_command(command: str) -> str:
    """Return the absolute path to a command or raise FileNotFoundError."""
    path = which(command)
    if path is None:
        message = f"The '{command}' command was not found in your system PATH."
        raise FileNotFoundError(message)
    return path


def raw_github_url(file: Path, version: str = VERSION) -> str:
    """Return a link to the given file on GitHub for the current version."""
    slug = file.relative_to(ROOT_DIR).as_posix()
    return f"https://raw.githubusercontent.com/{GITHUB_REPO}/refs/tags/v{version}/{slug}"


def validate_model[T: BaseModel](file: Path | None, model: type[T], obj: object) -> T:
    """Validate a Model with custom errors."""
    try:
        return model.model_validate(obj)
    except ValidationError as e:
        errs: list[errors.ValidationError] = []
        for err in e.errors():
            loc = ".".join(map(str, err["loc"]))
            typ = err.get("type", "unknown")
            errs.append(errors.ValidationError(
                title=f"ValidationError\\[{e.title}]",
                message=f"({typ}) '{loc}' → {err['msg']}",
                file=file,
            ))
        message = f"Failed to validate '{e.title}' ({file.relative_to(ROOT_DIR)})"
        raise errors.BookshelfCompositeError(message, errs) from e


def watch_and_run(run: Callable[[], None], *paths: Path) -> None:
    """Run a callable once, then re-run it on file changes in the given paths."""
    console = Console()
    run()
    for changes in watch(*paths):
        with error_handler(format_padding=1):
            count = len(changes)
            filenames = (str(Path(f).relative_to(ROOT_DIR)) for _, f in changes)
            console.print(
                f"{strftime('%H:%M:%S')} "
                f"{count} change{'s' if count != 1 else ''} detected "
                f"[bright_black]({', '.join(filenames)})[/bright_black]",
            )
            run()

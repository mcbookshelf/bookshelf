from dataclasses import dataclass, field
from enum import StrEnum
from pathlib import Path

from mcbookshelf import constants


class Severity(StrEnum):

    ERROR = "error"
    WARNING = "warning"


class MetadataWarning(UserWarning):
    """Something suspicious in a metadata file."""


class MetadataError(Exception):
    """A metadata file that does not load: every error found in it."""

    def __init__(self, diagnostics: Diagnostic | list[Diagnostic]) -> None:
        items = [diagnostics] if isinstance(diagnostics, Diagnostic) else list(diagnostics)
        self.diagnostics = items
        first = items[0]
        self.message = first.message
        self.file = first.file
        self.line = first.line
        self.column = first.column
        super().__init__(str(self))

    def __str__(self) -> str:
        return "\n".join(str(d) for d in self.diagnostics)


@dataclass(frozen=True, slots=True)
class Diagnostic:

    message: str
    severity: Severity = Severity.ERROR
    file: Path | None = None
    line: int | None = None
    column: int | None = None

    def __str__(self) -> str:
        location = locate(self.file, self.line, self.column)
        return f"{location}: {self.message}" if location else self.message


@dataclass(slots=True)
class Diagnostics:

    file: Path | None = None
    items: list[Diagnostic] = field(default_factory=list)

    def error(self, message: str, line: int | None = None, column: int | None = None) -> None:
        self.items.append(Diagnostic(message, Severity.ERROR, self.file, line, column))

    def warning(self, message: str, line: int | None = None) -> None:
        self.items.append(Diagnostic(message, Severity.WARNING, self.file, line))

    @property
    def errors(self) -> list[Diagnostic]:
        return [d for d in self.items if d.severity is Severity.ERROR]

    @property
    def warnings(self) -> list[Diagnostic]:
        return [d for d in self.items if d.severity is Severity.WARNING]


def locate(file: Path | str | None, line: int | None, column: int | None = None) -> str:
    """Format `file:line:column` with the known parts."""
    root = constants.ROOT_DIR
    if isinstance(file, Path) and file.is_absolute() and file.is_relative_to(root):
        file = file.relative_to(root)
    return ":".join(str(part) for part in (file, line, column) if part is not None)

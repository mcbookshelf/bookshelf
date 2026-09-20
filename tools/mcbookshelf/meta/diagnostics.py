from dataclasses import dataclass, field
from pathlib import Path

from mcbookshelf import constants


@dataclass(frozen=True, slots=True)
class Diagnostic:
    """One thing wrong in a metadata file, at a place."""

    message: str
    file: Path | None = None
    line: int | None = None
    column: int | None = None

    def __str__(self) -> str:
        location = locate(self.file, self.line, self.column)
        return f"{location}: {self.message}" if location else self.message


@dataclass(slots=True)
class Diagnostics:
    """Everything found wrong in a file, collected in one pass."""

    file: Path | None = None
    items: list[Diagnostic] = field(default_factory=list)

    def error(self, message: str, line: int | None = None) -> None:
        self.items.append(Diagnostic(message, self.file, line))


class MetadataError(Exception):
    """A metadata file that does not load: every error found in it."""

    def __init__(self, diagnostics: Diagnostic | list[Diagnostic]) -> None:
        items = [diagnostics] if isinstance(diagnostics, Diagnostic) else list(diagnostics)
        self.diagnostics = items
        self.message = items[0].message
        super().__init__(str(self))

    def __str__(self) -> str:
        return "\n".join(str(d) for d in self.diagnostics)


def locate(file: Path | str | None, line: int | None, column: int | None = None) -> str:
    """Format `file:line:column` with the known parts."""
    root = constants.ROOT_DIR
    if isinstance(file, Path) and file.is_absolute() and file.is_relative_to(root):
        file = file.relative_to(root)
    return ":".join(str(part) for part in (file, line, column) if part is not None)

from pathlib import Path

from mcbookshelf import constants


def locate(file: Path | str | None, line: int | None, column: int | None = None) -> str:
    """Format `file:line:column` with the known parts."""
    root = constants.ROOT_DIR
    if isinstance(file, Path) and file.is_absolute() and file.is_relative_to(root):
        file = file.relative_to(root)
    return ":".join(str(part) for part in (file, line, column) if part is not None)


class MetadataWarning(UserWarning):
    """Something suspicious in a metadata file."""


class MetadataError(Exception):
    """An error in a metadata file, with an optional source location."""

    def __init__(
        self,
        message: str,
        *,
        file: Path | None = None,
        line: int | None = None,
        column: int | None = None,
    ) -> None:
        self.message = message
        self.file = file
        self.line = line
        self.column = column
        super().__init__(message)

    def __str__(self) -> str:
        location = locate(self.file, self.line, self.column)
        return f"{location}: {self.message}" if location else self.message

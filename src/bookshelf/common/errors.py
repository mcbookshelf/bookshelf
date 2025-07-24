from __future__ import annotations

from typing import TYPE_CHECKING

from bookshelf.definitions import ROOT_DIR

if TYPE_CHECKING:
    from pathlib import Path


class BookshelfError(Exception):
    """Base exception for single Bookshelf errors."""

    def __init__(
        self,
        *,
        title: str | None = None,
        message: str | None = None,
        file: Path | None = None,
        line: int | None = None,
    ) -> None:
        """Initialize with docstring as message if no message is given."""
        self.title = title or self.__class__.__name__
        self.message = message or self.__doc__
        self.file = file.relative_to(ROOT_DIR) if file else None
        self.line = line

        super().__init__(self.message)


class BookshelfCompositeError(ExceptionGroup, BookshelfError):
    """Base exception for composite errors."""


class ValidationError(BookshelfError):
    """Failed to validate the Model."""


class JSONFileNotFoundError(BookshelfError):
    """The JSON file could not be found."""


class JSONDecodeError(BookshelfError):
    """The JSON file could not be parsed."""


class JSONTypeError(BookshelfError):
    """The JSON content does not match the expected type."""


class InvalidFeatureFileError(BookshelfError):
    """File is not recognized as a feature."""


class ConflictingModuleKindError(BookshelfError):
    """Module cannot contain both a data_pack and a resource_pack."""


class UnrecognizedModuleKindError(BookshelfError):
    """Cannot determine module kind from data."""


class InvalidFileHeaderError(BookshelfError):
    """Required header is missing or malformed."""


class MissingRequiredFileError(BookshelfError):
    """File marked as required is missing."""

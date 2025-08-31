from __future__ import annotations

from datetime import datetime, timezone
from logging import getLogger
from typing import TYPE_CHECKING

from jinja2 import Template

from bookshelf.common import errors
from bookshelf.definitions import MODULES, MODULES_DIR, SRC_DIR
from bookshelf.services.metadata import make_feature_from_file, make_module_from_file

if TYPE_CHECKING:
    from collections.abc import Iterable

logger = getLogger(__name__)

HEADER_TEMPLATE = SRC_DIR / "bookshelf/templates/header.jinja"

REQUIRED_FILES = [
    "module.json",
    "README.md",
    "pack.png",
    "data/{module}/function/__load__.mcfunction",
    "data/{module}/function/__unload__.mcfunction",
]


def check_features_metadata() -> Iterable[errors.BookshelfError]:
    """Validate all feature metadata JSON files."""
    for file in MODULES_DIR.rglob("*/data/**/*.json"):
        try:
            make_feature_from_file(file)
        except errors.InvalidFeatureFileError:
            continue
        except errors.BookshelfError as e:
            yield e


def check_modules_metadata() -> Iterable[errors.BookshelfError]:
    """Validate all module metadata JSON files."""
    for module in MODULES:
        try:
            make_module_from_file(MODULES_DIR / module / "module.json")
        except errors.BookshelfError as e:
            yield e


def check_required_files() -> Iterable[errors.BookshelfError]:
    """Verify required files exist in each module."""
    for file in [
        MODULES_DIR / module / path.format(module=module)
        for module in MODULES for path in REQUIRED_FILES
    ]:
        if not file.exists():
            yield errors.MissingRequiredFileError(file=file)


def check_function_headers() -> Iterable[errors.BookshelfError]:
    """Ensure all .mcfunction files begin with the correct header."""
    template = Template(HEADER_TEMPLATE.read_text(encoding="utf-8"))
    template = template.render(year=datetime.now(timezone.utc).year)
    for file in MODULES_DIR.rglob("*/data/**/*.mcfunction"):
        lines = file.read_text("utf-8").splitlines()
        header = "\n".join(lines[:len(template.splitlines())])
        if header.strip() != template.strip():
            yield errors.InvalidFileHeaderError(file=file)

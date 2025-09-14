from __future__ import annotations

from functools import cache
from typing import TYPE_CHECKING

import orjson
from pydantic import BaseModel

from bookshelf.common import errors, utils

if TYPE_CHECKING:
    from pathlib import Path


def dump(file: Path, data: BaseModel | dict | list, indent: int | None = 2) -> int:
    """Write data to a JSON file using orjson."""
    options = orjson.OPT_INDENT_2 if indent else 0
    contents = orjson.dumps(data, option=options, default=_orjson_default)
    return file.write_bytes(contents)


def load[T: BaseModel | dict | list](file: Path, expected_type: type[T]) -> T:
    """Load a JSON file and return its content."""
    data = _parse_json(file)
    if isinstance(data, expected_type):
        return data
    if isinstance(expected_type, type) and issubclass(expected_type, BaseModel):
        return utils.validate_model(file, expected_type, data)
    raise errors.JSONTypeError(file=file)


def _orjson_default(obj: object) -> object:
    if isinstance(obj, BaseModel):
        return obj.model_dump(mode="json", exclude_none=True, exclude_defaults=True)
    raise TypeError


@cache
def _parse_json(file: Path) -> dict | list:
    try:
        raw = file.read_bytes()
        return orjson.loads(raw)
    except FileNotFoundError as e:
        raise errors.JSONFileNotFoundError(file=file) from e
    except orjson.JSONDecodeError as e:
        raise errors.JSONDecodeError(message=str(e), file=file, line=e.lineno) from e

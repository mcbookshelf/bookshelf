from __future__ import annotations

from functools import cache
from pathlib import Path

import orjson
from pydantic import BaseModel

from bookshelf.common import errors, utils


def dump(file: Path, data: BaseModel | dict | list, indent: int | None = 2) -> int:
    """Write data to a JSON file using orjson."""
    options = orjson.OPT_INDENT_2 if indent else 0
    contents = orjson.dumps(data, option=options, default=_orjson_default)
    return file.write_bytes(contents)


def load[T: BaseModel | dict | list](obj: bytes | Path, expected_type: type[T]) -> T:
    """Load JSON from bytes or a file path and return its content."""
    if isinstance(obj, Path):
        data = _parse_file(obj)
        file = obj
    else:
        data = _parse_bytes(obj)
        file = None
    if isinstance(data, expected_type):
        return data
    if isinstance(expected_type, type) and issubclass(expected_type, BaseModel):
        return utils.validate_model(file, expected_type, data)
    raise errors.JSONTypeError(file=file)


def _orjson_default(obj: object) -> object:
    if isinstance(obj, BaseModel):
        return obj.model_dump(mode="json", exclude_none=True, exclude_defaults=True)
    raise TypeError


def _parse_bytes(data: bytes) -> dict | list:
    try:
        return orjson.loads(data)
    except orjson.JSONDecodeError as e:
        raise errors.JSONDecodeError(message=str(e), line=e.lineno) from e

@cache
def _parse_file(file: Path) -> dict | list:
    try:
        return orjson.loads(file.read_bytes())
    except FileNotFoundError as e:
        raise errors.JSONFileNotFoundError(file=file) from e
    except orjson.JSONDecodeError as e:
        raise errors.JSONDecodeError(message=str(e), file=file, line=e.lineno) from e

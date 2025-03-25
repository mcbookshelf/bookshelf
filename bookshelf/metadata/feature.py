import json
import re
from pathlib import Path

from pydantic import BaseModel, Field, ValidationError

from bookshelf.definitions import DOC_URL, ROOT_DIR
from bookshelf.helpers import extract_feature_id
from bookshelf.logger import StepLogger


class Updated(BaseModel):
    """Represents metadata about when a feature or module was last updated."""

    date: str = Field(pattern=r"^\d{4}/(0[1-9]|1[0-2])/(0[1-9]|[1-2]\d|3[0-1])$")
    minecraft_version: str

class FeatureMeta(BaseModel):
    """Represents metadata for a feature within the library."""

    id: str
    documentation: str = Field(pattern=rf"^{re.escape(DOC_URL)}/en/latest/modules/.+$")
    authors: list[str]
    contributors: list[str] = []
    created: Updated
    updated: Updated


def get_feature_meta(file: Path, logger: StepLogger) -> FeatureMeta | None:
    """Retrieve feature metadata from a JSON file."""
    relpath = file.relative_to(ROOT_DIR)
    feature_id = extract_feature_id(file)
    if not feature_id:
        return None

    try:
        meta = json.loads(file.read_text("utf-8")).get("__bookshelf__", {})
        return FeatureMeta(id=feature_id, **meta)

    except ValidationError:
        logger.exception("Found errors in feature '%s'.", feature_id, extra={
            "title": "Validation Error",
            "file": relpath,
        })

    except json.JSONDecodeError as e:
        logger.exception("File '%s' has invalid JSON.", relpath, extra={
            "title": "Malformed Json",
            "file": relpath,
            "line": e.lineno,
        })

    return None

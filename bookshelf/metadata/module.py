import json
import re
from pathlib import Path
from typing import Literal

from pydantic import BaseModel, Field, ValidationError

from bookshelf.definitions import DOC_URL, RAW_PROJECT_URL, ROOT_DIR
from bookshelf.logger import StepLogger


class ModuleMeta(BaseModel):
    """Represents metadata for a module within the library."""

    id: str = Field(pattern=r"^bs\..+$")
    name: str
    slug: str
    icon: str | None = None
    banner: str | None = None
    readme: str | None = None
    description: str
    documentation: str = Field(pattern=rf"^{re.escape(DOC_URL)}/en/latest/modules/.+$")

    kind: Literal["combined", "data_pack", "resource_pack"]
    tags: list[str] = []
    authors: list[str] = []
    contributors: list[str] = []
    dependencies: list[str] = []
    weak_dependencies: list[str] = []


def get_module_meta(file: Path, logger: StepLogger) -> ModuleMeta | None:
    """Retrieve module metadata from a JSON file."""
    relpath = file.relative_to(ROOT_DIR)
    module_id = file.parent.name

    try:
        data = json.loads(file.read_text("utf-8"))
        meta = data.get("meta", {})

        if "data_pack" in data and "resource_pack" in data:
            error_msg = "A module cannot have both 'data_pack' and 'resource_pack'."
            raise ValueError(error_msg)
        if "data_pack" in data:
            meta["kind"] = "data_pack"
        if "resource_pack" in data:
            meta["kind"] = "resource_pack"

        for key in ["tags"]:
            if key not in meta:
                logger.warning(
                    "Metadata file for module '%s' is missing optional key '%s'. "
                    "You should consider adding it.",
                    module_id,
                    key,
                )

        for key, value in [
            ("icon", "pack.png"),
            ("readme", "README.md"),
            ("banner", "banner.png"),
        ]:
            if (file.parent / value).exists():
                meta[key] = RAW_PROJECT_URL.format((relpath.parent / value).as_posix())

        return ModuleMeta(id=module_id, **meta)

    except ValidationError:
        logger.exception("Found errors in module '%s'.", module_id, extra={
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

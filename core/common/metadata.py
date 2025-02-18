import json
import re
from bisect import insort
from pathlib import Path
from typing import Literal

from pydantic import BaseModel, Field, ValidationError

from core.common.helpers import extract_feature_id
from core.common.logger import StepLogger
from core.definitions import DOC_URL, MODULES, MODULES_DIR, PROJECT_URL, ROOT_DIR


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

    kind: Literal["data_pack", "resource_pack"]
    tags: list[str] = []
    authors: list[str] = []
    contributors: list[str] = []
    dependencies: list[str] = []
    weak_dependencies: list[str] = []


def get_feature_meta(file: Path, logger: StepLogger) -> FeatureMeta | None:
    """Retrieve feature metadata from a JSON file."""
    relative_path = file.relative_to(ROOT_DIR)
    feature_id = extract_feature_id(file)
    if not feature_id:
        return None

    try:
        meta = json.loads(file.read_text("utf-8")).get("__bookshelf__", {})
        return FeatureMeta(id=feature_id, **meta)

    except ValidationError:
        logger.exception("Found errors in feature '%s'.", feature_id, extra={
            "title": "Validation Error",
            "file": relative_path,
        })

    except json.JSONDecodeError as e:
        logger.exception("File '%s' has invalid JSON.", relative_path, extra={
            "title": "Malformed Json",
            "file": relative_path,
            "line": e.lineno,
        })

    return None


def get_module_meta(file: Path, logger: StepLogger) -> ModuleMeta | None:
    """Retrieve module metadata from a JSON file."""
    relative_path = file.relative_to(ROOT_DIR)
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
                meta[key] = PROJECT_URL.format(
                    (relative_path.parent / value).as_posix(),
                )

        return ModuleMeta(id=module_id, **meta)

    except ValidationError:
        logger.exception("Found errors in module '%s'.", module_id, extra={
            "title": "Validation Error",
            "file": relative_path,
        })

    except json.JSONDecodeError as e:
        logger.exception("File '%s' has invalid JSON.", relative_path, extra={
            "title": "Malformed Json",
            "file": relative_path,
            "line": e.lineno,
        })

    return None


def build_manifest(logger: StepLogger) -> dict | None:
    """Build the manifest by gathering metadata for all modules and their features."""
    manifest: dict[str, list[dict]] = {"modules":[]}
    for module in MODULES:
        if module_meta := get_module_meta(MODULES_DIR / module / "module.json", logger):
            module_dict = module_meta.model_dump(
                exclude_defaults=True,
                exclude_none=True,
            )
            module_dict["features"] = []
            for file_path in (MODULES_DIR / module / "data") .rglob("*.json"):
                if feature_meta := get_feature_meta(file_path, logger):
                    feature_dict = feature_meta.model_dump(
                        exclude_defaults=True,
                        exclude_none=True,
                    )
                    insort(module_dict["features"], feature_dict, key=lambda x: x["id"])
            insort(manifest["modules"], module_dict, key=lambda x: x["id"])

    return manifest if not logger.errors else None

"""Manage Bookshelf metadata."""

from bisect import insort

from bookshelf.definitions import MODULES, MODULES_DIR
from bookshelf.logger import StepLogger
from bookshelf.metadata.feature import get_feature_meta
from bookshelf.metadata.module import get_module_meta


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

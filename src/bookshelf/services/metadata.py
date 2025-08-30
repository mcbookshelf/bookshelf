from __future__ import annotations

from contextlib import suppress
from typing import TYPE_CHECKING

from bookshelf.common import errors, json, utils
from bookshelf.definitions import MODULES, MODULES_DIR
from bookshelf.models import Feature, Manifest, Module, ModuleKind

if TYPE_CHECKING:
    from pathlib import Path


def make_manifest() -> Manifest:
    """Build the manifest by gathering modules and features."""
    modules = []
    for name in sorted(MODULES):
        modules.append(make_module_from_file(MODULES_DIR / name / "module.json"))
        # Attempt to create Feature instances with all JSON files inside the module
        for feature in sorted((MODULES_DIR / name / "data").rglob("*.json")):
            with suppress(errors.InvalidFeatureFileError):
                modules[-1].features.append(make_feature_from_file(feature))

    return Manifest(modules=modules)


def make_module_from_file(file: Path) -> Module:
    """Create a Module instance from a module.json file."""
    data = json.load(file, dict)
    meta = data.get("meta", {})

    meta["id"] = file.parent.name
    meta["kind"] = _guess_module_kind(data, file)

    return utils.validate_model(file, Module, meta)


def make_feature_from_file(file: Path) -> Feature:
    """Create a Feature instance from a JSON file."""
    data = json.load(file, dict)
    meta = data.get("__bookshelf__", {})

    if not meta.get("feature"):
        raise errors.InvalidFeatureFileError(file=file)
    meta["id"], meta["kind"] = _extract_feature_identity(file)

    return utils.validate_model(file, Feature, meta)


def _extract_feature_identity(file: Path) -> tuple[str, str]:
    ns, kind, *rest = file.relative_to(MODULES_DIR).with_suffix("").parts[2:]
    # Special case for tags: prepend '#' to id, append '_tag' to kind
    if kind == "tags":
        return f"#{ns}:{'/'.join(rest[1:])}", f"{rest[0]}_tag"
    return f"{ns}:{'/'.join(rest)}", kind


def _guess_module_kind(data: dict, file: Path) -> ModuleKind:
    is_data_pack = ModuleKind.DATA_PACK.value in data
    is_resource_pack = ModuleKind.RESOURCE_PACK.value in data

    if is_data_pack and is_resource_pack:
        raise errors.ConflictingModuleKindError(file=file)
    if is_data_pack:
        return ModuleKind.DATA_PACK
    if is_resource_pack:
        return ModuleKind.RESOURCE_PACK
    raise errors.UnrecognizedModuleKindError(file=file)

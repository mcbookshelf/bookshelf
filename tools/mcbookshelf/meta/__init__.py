from pathlib import Path

from . import errors, models, syntax
from .build import build_bundle, build_module
from .errors import MetadataError, MetadataWarning
from .models import Bundle, Feature, Module, Role, Slot, Stamp, Target, feature_id, parse_version
from .parser import parse

__all__ = [
    "Bundle",
    "Feature",
    "MetadataError",
    "MetadataWarning",
    "Module",
    "Role",
    "Slot",
    "Stamp",
    "Target",
    "build_bundle",
    "build_module",
    "errors",
    "feature_id",
    "load_bundle",
    "load_module",
    "models",
    "parse",
    "parse_version",
    "syntax",
]


def load_module(file: Path) -> models.Module:
    """Load a `module.bs` file."""
    document = parse(file.read_text("utf-8"), file)
    return build_module(document, file.parent.name, file)


def load_bundle(file: Path) -> models.Bundle:
    """Load a `bundle.bs` file."""
    document = parse(file.read_text("utf-8"), file)
    return build_bundle(document, file.parent.name, file)

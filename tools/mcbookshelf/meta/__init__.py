from pathlib import Path

from . import diagnostics, model, rules, syntax
from .builder import build_bundle, build_module
from .diagnostics import Diagnostic, Diagnostics, MetadataError, MetadataWarning, Severity
from .model import Bundle, Feature, Module, Slot, Stamp, Target
from .parser import parse
from .syntax import Role

__all__ = [
    "Bundle",
    "Diagnostic",
    "Diagnostics",
    "Feature",
    "MetadataError",
    "MetadataWarning",
    "Module",
    "Role",
    "Severity",
    "Slot",
    "Stamp",
    "Target",
    "build_bundle",
    "build_module",
    "diagnose",
    "diagnostics",
    "load_bundle",
    "load_module",
    "model",
    "parse",
    "rules",
    "syntax",
]


def load_module(file: Path) -> model.Module:
    """Load a `module.bs` file."""
    document = parse(file.read_text("utf-8"), file)
    return build_module(document, file.parent.name, file)


def load_bundle(file: Path) -> model.Bundle:
    """Load a `bundle.bs` file."""
    document = parse(file.read_text("utf-8"), file)
    return build_bundle(document, file.parent.name, file)


def diagnose(file: Path) -> list[Diagnostic]:
    """Everything wrong or suspicious in a `.bs` file."""
    report = Diagnostics(file)
    try:
        document = parse(file.read_text("utf-8"), file)
    except MetadataError as error:
        return error.diagnostics
    if file.parent.name.startswith("@"):
        build_bundle(document, file.parent.name, file, report)
    else:
        build_module(document, file.parent.name, file, report)
    return report.items

"""Schemas and data models for the Bookshelf Library."""

from __future__ import annotations

from .collection import Collection
from .metadata import Feature, Manifest, Module, ModuleKind
from .minecraft import (
    Biome,
    Block,
    StateNode,
    StatePredicate,
    StateProperty,
    StateValue,
    VoxelShape,
)
from .versions import Switcher, SwitcherEntry, Versions, VersionsEntry

__all__ = [
    "Biome",
    "Block",
    "Collection",
    "Feature",
    "Manifest",
    "Module",
    "ModuleKind",
    "StateNode",
    "StatePredicate",
    "StateProperty",
    "StateValue",
    "Switcher",
    "SwitcherEntry",
    "Versions",
    "VersionsEntry",
    "VoxelShape",
]

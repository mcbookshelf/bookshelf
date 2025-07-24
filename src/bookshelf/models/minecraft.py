from __future__ import annotations

from dataclasses import dataclass
from functools import cached_property

from frozendict import frozendict
from pydantic import BaseModel
from pydantic_core import core_schema

type VoxelShape = tuple[tuple[float, float, float, float, float, float], ...]
type StateValue[T] = StatePredicate[T] | T

frozendict.__get_pydantic_core_schema__ = lambda source_type, handler: (
    core_schema.no_info_after_validator_function(
        frozendict,
        core_schema.dict_schema(
            keys_schema=handler(source_type.__args__[0]),
            values_schema=handler(source_type.__args__[1]),
        ),
    )
)

class Biome(BaseModel, frozen=True):
    """Represents a Minecraft biome."""

    type: str
    temperature: float
    has_precipitation: bool = True


class Block(BaseModel, frozen=True):
    """Represents a Minecraft block."""

    type: str
    item: str
    group: int
    properties: tuple[StateProperty, ...] = ()
    can_occlude: bool = False
    has_shape_offset: bool = False
    has_visual_offset: bool = False
    ignited_by_lava: bool = False
    blast_resistance: float
    friction: float
    hardness: float
    jump_factor: float = 1.0
    speed_factor: float = 1.0
    instrument: str
    sounds: frozendict[str, str]
    shape: StateValue[VoxelShape] = ((0.0, 0.0, 0.0, 16.0, 16.0, 16.0),)
    collision_shape: StateValue[VoxelShape] = ((0.0, 0.0, 0.0, 16.0, 16.0, 16.0),)
    luminance: StateValue[int] = 0
    is_conductive: StateValue[bool] = False
    is_spawnable: StateValue[bool] = False


class StatePredicate[T](BaseModel, frozen=True):
    """Predicate over a block's state."""

    group: int
    tree: StateNode[T]

    def __hash__(self) -> int:
        """Hash based on the group ID."""
        return self.group


class StateProperty(BaseModel, frozen=True):
    """Represents a block state property and its sequencing metadata."""

    name: str
    group: int
    options: tuple[str, ...]
    sequence_ref: int | None = None
    sequence_index: int

    def __hash__(self) -> int:
        """Hash based on the group ID."""
        return self.group


@dataclass(frozen=True)
class StateNode[T]:
    """Decision node with branches."""

    name: str
    children: dict[str, T | StateNode[T]]

    @cached_property
    def size(self) -> int:
        """Number of nodes and leaves in this subtree."""
        return 1 + sum(
            child.size if isinstance(child, StateNode) else 1
            for child in self.children.values()
        )

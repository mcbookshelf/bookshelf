from collections import Counter
from collections.abc import Callable, Hashable, Iterable, Mapping
from dataclasses import dataclass
from itertools import product
from math import prod

from beet import Cache

from mcbookshelf import constants
from mcbookshelf.minecraft import condition
from mcbookshelf.minecraft.data import fetch
from mcbookshelf.minecraft.math import Expression, add, btree, cond, const

type Box = tuple[float, float, float, float, float, float]
type Shape = tuple[Box, ...]
type Properties = tuple[tuple[str, str], ...]


@dataclass(frozen=True, slots=True)
class State:

    shape: Shape
    collision_shape: Shape
    properties: Properties
    fluid: str | None
    luminance: int
    is_conductive: bool
    is_spawnable: bool

    def get(self, name: str) -> str:
        return next(value for key, value in self.properties if key == name)


@dataclass(frozen=True, slots=True)
class Block:

    id: str
    item: str
    properties: tuple[tuple[str, tuple[str, ...]], ...]
    defaults: Properties
    states: tuple[State, ...]
    can_occlude: bool
    has_shape_offset: bool
    has_visual_offset: bool
    ignited_by_lava: bool
    blast_resistance: float
    friction: float
    hardness: float
    jump_factor: float
    speed_factor: float
    instrument: str
    sounds: tuple[tuple[str, str], ...]


def get_blocks(cache: Cache, version: str = constants.GAME_VERSION) -> dict[str, Block]:
    """The blocks of a Minecraft version."""
    return {
        block_id: Block(
            id=block_id,
            item=data["item"],
            properties=tuple(
                (name, _ordered(options))
                for name, options in sorted(data["possible_properties"].items())
            ),
            defaults=tuple(sorted(data["default_properties"].items())),
            states=tuple(
                State(
                    properties=tuple(sorted(state["properties"].items())),
                    shape=tuple(map(tuple, state["shape"])),
                    collision_shape=tuple(map(tuple, state["collision_shape"])),
                    fluid=state["fluid"].get("id"),
                    luminance=state["luminance"],
                    is_conductive=state["is_conductive"],
                    is_spawnable=state["is_spawnable"],
                )
                for state in data["states"]
            ),
            can_occlude=data["can_occlude"],
            has_shape_offset=data["has_shape_offset"],
            has_visual_offset=data["has_visual_offset"],
            ignited_by_lava=data["ignited_by_lava"],
            blast_resistance=data["blast_resistance"],
            friction=data["friction"],
            hardness=data["hardness"],
            jump_factor=data["jump_factor"],
            speed_factor=data["speed_factor"],
            instrument=data["instrument"],
            sounds=tuple(sorted(data["sounds"].items())),
        )
        for block_id, data in sorted(fetch(cache, "blocks", version).items())
    }


def changing[T](block: Block, values: tuple[T, ...]) -> list[str]:
    """The properties of a block that change its value, given for each of its states, in order."""
    names = []
    for name, _ in block.properties:
        others: dict[Properties, set[T]] = {}
        for state, value in zip(block.states, values, strict=True):
            rest = tuple(pair for pair in state.properties if pair[0] != name)
            others.setdefault(rest, set()).add(value)
        if any(len(found) > 1 for found in others.values()):
            names.append(name)
    return names


def block_table[T: Hashable](
    blocks: Iterable[Block],
    values: Mapping[str, Callable[[State], T]],
    skip: Mapping[str, Callable[[Block], bool]] | None = None,
) -> tuple[dict[str, Expression], list[T | None]]:
    """A provider per value, giving the index of each block state's value in a shared table."""
    constant, stateful = _split(list(blocks), values, skip or {})
    table, index = _codes(Counter(v for ids in constant.values() for v in ids.values()))
    grids: dict[tuple[tuple[str, ...], tuple[T, ...]], Expression] = {}
    seen: dict[tuple[object, ...], Expression] = {}

    def grid(block: Block, value: Callable[[State], T]) -> Expression:
        found = tuple(value(state) for state in block.states)
        if (key := (block.properties, found)) in seen:
            return seen[key]
        names = changing(block, found)
        options = [dict(block.properties)[name] for name in names]
        cells = {
            tuple(state.get(name) for name in names): cell
            for state, cell in zip(block.states, found, strict=True)
        }
        layout = (tuple(names), tuple(cells[combo] for combo in product(*options)))
        if layout not in grids:
            grids[layout] = _grid(len(table), names, options)
            table.extend(layout[1])
        seen[key] = grids[layout]
        return grids[layout]

    providers = {}
    for name, value in values.items():
        codes = _code_sum(constant[name], index)
        if not stateful[name]:
            providers[name] = codes
            continue
        grids_part = btree(
            stateful[name],
            lambda block, value=value: grid(block, value),
            lambda group: condition.block(block.id for block in group),
        )
        if constant[name]:
            has_grid = condition.block(block.id for block in stateful[name])
            grids_part = cond(has_grid, grids_part, codes)
        providers[name] = grids_part
    return providers, table


def _split[T](
    blocks: list[Block],
    values: Mapping[str, Callable[[State], T]],
    skip: Mapping[str, Callable[[Block], bool]],
) -> tuple[dict[str, dict[str, T]], dict[str, list[Block]]]:
    """For each value, the blocks with one value in all their states, and the others."""
    constant: dict[str, dict[str, T]] = {name: {} for name in values}
    stateful: dict[str, list[Block]] = {name: [] for name in values}
    for name, value in values.items():
        for block in blocks:
            if name in skip and skip[name](block):
                continue
            if len(found := {value(state) for state in block.states}) == 1:
                constant[name][block.id] = found.pop()
            else:
                stateful[name].append(block)
    return constant, stateful


def _ordered(options: list[str]) -> tuple[str, ...]:
    """The values in the order of state range checks: numbers ascending, `false` first."""
    if set(options) == {"false", "true"}:
        return ("false", "true")
    if all(option.lstrip("-").isdigit() for option in options):
        return tuple(sorted(options, key=int))
    return tuple(options)


def _codes[T](uses: Counter[T]) -> tuple[list[T | None], dict[T, int]]:
    """A table of the values, the most used at the codes with the fewest bits set."""
    size = 1 << (len(uses) - 1).bit_length() if uses else 0
    codes = sorted(range(size), key=lambda code: (code.bit_count(), code))
    table: list[T | None] = [None] * size
    for (found, _), code in zip(uses.most_common(), codes, strict=False):
        table[code] = found
    return table, {found: code for code, found in enumerate(table) if found is not None}


def _code_sum[T](constant: dict[str, T], index: dict[T, int]) -> Expression:
    """The code of each block, adding the bits it sets: one block check per bit."""
    bits = max(index.values(), default=0).bit_length()
    return add(0, *(
        cond(condition.block(ids), 1 << bit, 0)
        for bit in range(bits)
        if (ids := [i for i, found in constant.items() if index[found] >> bit & 1])
    ))


def _grid(base: int, names: list[str], options: list[tuple[str, ...]]) -> Expression:
    """The index of the values of the given properties in a grid from `base`, by range checks."""
    stride = prod(map(len, options))
    terms = []
    for name, choices in zip(names, options, strict=True):
        stride //= len(choices)
        terms.append(btree(
            list(enumerate(choices)),
            lambda choice, stride=stride: const(choice[0] * stride),
            lambda half, name=name: condition.block_state_range(name, maximum=half[-1][1]),
        ))
    return add(base, *terms)

from __future__ import annotations

from collections import Counter, defaultdict
from functools import cache
from itertools import chain, permutations, takewhile
from logging import getLogger
from typing import TYPE_CHECKING, Any

import httpx
from frozendict import frozendict

from bookshelf.common import json
from bookshelf.models import (
    Block,
    Collection,
    StateNode,
    StatePredicate,
    StateProperty,
    StateValue,
    VoxelShape,
)

from .utils import cache_version

if TYPE_CHECKING:
    from collections.abc import Callable

logger = getLogger(__name__)

BLOCKS_URL = "https://raw.githubusercontent.com/mcbookshelf/mcdata/refs/tags/v1/{}/blocks/data.min.json"


@cache_version("blocks", Collection[Block])
def get_blocks(version: str) -> Collection[Block]:
    """Retrieve blocks for the provided version."""
    response = httpx.get(BLOCKS_URL.format(version))
    response.raise_for_status()
    raw = json.load(response.content, dict)

    blocks: list[dict[str, Any]] = []
    groups: dict[tuple[tuple[str, tuple[str, ...]], ...], int] = {(): 0}

    for block, data in raw.items():
        props = set()
        states = data.pop("states")
        defaults = data.pop("default_properties")
        # Normalize property ordering: rotate options so the default comes first
        for name, options in sorted(data.pop("possible_properties").items()):
            i = options.index(defaults[name])
            props.add((str(name), tuple(options[i:] + options[:i])))

        blocks.append({
            **data,
            "type": block,
            "props": props,
            "group": groups.setdefault(tuple(sorted(props)), len(groups)),
            "shape": _make_shape_value("shape", states),
            "collision_shape": _make_shape_value("collision_shape", states),
            "luminance": _make_state_value("luminance", states),
            "is_conductive": _make_state_value("is_conductive", states),
            "is_spawnable": _make_state_value("is_spawnable", states),
        })

    blocks.sort(key=lambda b: b["type"])
    return Collection(root=_make_blocks(blocks))


def _make_blocks(blocks: list[dict]) -> list[Block]:
    """Build Block instances from raw block dictionaries."""
    props = _make_properties({block["group"]: block["props"] for block in blocks})
    return [Block(
        **block,
        properties=props.get(block["group"], ()),
    ) for block in blocks]


def _make_state_value[T](key: str, states: list) -> StateValue[T]:
    """Build a StateValue for a given key inside the state dict."""
    def getter(state: dict) -> T:
        return state[key]
    return _make_state_value_from(key, getter, states)


def _make_shape_value(key: str, states: list) -> StateValue[VoxelShape]:
    """Build a StateValue for voxel shapes inside the state dict."""
    def getter(state: dict) -> VoxelShape:
        return tuple(tuple(e*16 for e in v) for v in state[key])
    return _make_state_value_from("shape", getter, states)


_state_value_memo = defaultdict(dict)
def _make_state_value_from[T](
    key: str,
    getter: Callable[[dict], T],
    states: list,
) -> StateValue[T]:
    """Build a StateValue mapping block states to the values produced by `getter`."""
    output_to_props = defaultdict(list)
    prop_to_outputs = defaultdict(lambda: defaultdict(list))

    for state in states:
        output = getter(state)
        props = state["properties"]
        output_to_props[output].append(props)
        for name, value in state["properties"].items():
            prop_to_outputs[name][value].append(output)

    # Early exit if all outputs are identical
    if len(output_to_props) == 1:
        return next(iter(output_to_props))

    # Identify only the properties that affect the output
    properties = {
        name for name, group in prop_to_outputs.items()
        if any(o != next(iter(group.values())) for o in group.values())
    }
    # Represent states in a hashable way
    frozenstates = frozenset(
        (frozendict((n, v) for n, v in state.items() if n in properties), output)
        for output, group in output_to_props.items()
        for state in group
    )
    # Check memoization to reuse existing predicates
    if frozenstates not in _state_value_memo[key]:
        _state_value_memo[key][frozenstates] = StatePredicate(
            group=len(_state_value_memo[key]) + 1,
            tree=_make_state_tree(frozenset(properties), frozenstates),
        )

    return _state_value_memo[key][frozenstates]


@cache
def _make_state_tree[T](
    properties: frozenset[str],
    states: frozenset[tuple[frozendict[str, str], T]],
) -> StateNode[T] | T:
    """Recursively build a StateNode decision tree from block states."""
    if len(outputs := {out for _, out in states}) == 1:
        return next(iter(outputs))

    if not properties:
        msg = "Ambiguous states: cannot determine unique leaf (%d states, outputs=%s)"
        logger.warning(msg, len(states), outputs)
        return next(iter(outputs))

    best_node = None
    best_size = float("inf")

    for name in properties:
        groups = defaultdict(set)
        for state, out in states:
            groups[state[name]].add((state, out))

        if len(groups) == 1:
            continue

        children = {}
        for value, group in groups.items():
            children[value] = _make_state_tree(properties - {name}, frozenset(group))
        node = StateNode(name, children)

        if node.size < best_size:
            best_node = node
            best_size = node.size
            if best_size == len(outputs):
                break

    if best_node is None:
        msg = "Ambiguous states: no property can split (%d states, outputs=%s)"
        logger.warning(msg, len(states), outputs)
        return next(iter(outputs))

    return best_node


def _make_properties(
    groups: dict[int, set[tuple[str, tuple[str, ...]]]],
) -> dict[int, tuple[StateProperty, ...]]:
    """Build StateProperty instances for each group based on optimized sequences."""
    composites, props_map = _make_composite_properties(groups)
    sequences = _make_optimized_sequences(composites)

    next_id = 1
    properties = {}
    sequence_map = {}
    for group, props in sequences.items():
        sequence = ()
        sequence_ref = None
        optimized_group = []
        for prop in props:
            sequence += (prop,)
            if sequence not in sequence_map:
                sequence_map[sequence] = next_id
                next_id += 1

            optimized_group.append(StateProperty(
                name=prop[0],
                group=sequence_map[sequence],
                options=props_map[group][prop[0]],
                sequence_index=len(sequence) - 1,
                sequence_ref=sequence_ref,
            ))
            sequence_ref = sequence_map[sequence]

        properties[group] = optimized_group

    return properties


def _make_composite_properties(
    groups: dict[int, set[tuple[str, tuple[str, ...]]]],
) -> tuple[
    dict[int, list[tuple[tuple[str, tuple[str, ...]], ...]]],
    dict[int, dict[str, tuple[str, ...]]],
]:
    """Group properties into composites shared across the same set of groups."""
    occurrences = defaultdict(set)
    props_map = defaultdict(dict)

    # Map group -> property -> values, and track where each property occurs
    for group_id, props in groups.items():
        for name, values in props:
            props_map[group_id][name] = values
            occurrences[(name, tuple(sorted(values)))].add(group_id)

    # Group properties that occur in the same set of groups
    groups_to_props = defaultdict(set)
    for prop, group_ids in occurrences.items():
        groups_to_props[frozenset(group_ids)].add(prop)

    # Assign composites back to each group
    composites = defaultdict(list)
    for group_ids, composite in groups_to_props.items():
        for group_id in group_ids:
            composites[group_id].append(tuple(sorted(composite)))

    return composites, props_map


def _make_optimized_sequences(
    composites: dict[int, list[tuple[tuple[str, tuple[str, ...]], ...]]],
) -> dict[int, list[tuple[str, tuple[str, ...]]]]:
    """Compute the best ordering of shared properties for each group."""
    unique_props = {}
    shared_props = {}
    sequences = defaultdict(list)
    counter = Counter(chain.from_iterable(composites.values()))

    for group_id, composite in composites.items():
        unique_props[group_id] = [p for g in composite for p in g if counter[g] == 1]
        shared_props[group_id] = [
            [p for g in perm for p in g]
            for perm in permutations(g for g in composite if counter[g] > 1)
        ]

    while shared_props:
        group, candidates = shared_props.popitem()

        def score(sequence: list) -> float:
            past_score = sum(len(list(takewhile(
                lambda x: x[0] == x[1],
                zip(sequence, chosen, strict=False),
            ))) for chosen in sequences.values())

            future_score = sum(
                sum(len(list(takewhile(
                    lambda x: x[0] == x[1],
                    zip(sequence, c, strict=False),
                ))) for c in future_group) / len(future_group)
                for future_group in shared_props.values()
            )

            return past_score + future_score

        sequences[group] = max(candidates, key=score)

    for group, props in unique_props.items():
        sequences[group].extend(props)

    return sequences

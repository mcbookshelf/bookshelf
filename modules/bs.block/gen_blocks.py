from bisect import insort
from collections import Counter
from datetime import datetime, timezone
from itertools import chain, permutations

import numpy as np
from beet import BlockTag, Context, Function, LootTable
from pydantic import BaseModel

from core.common.helpers import (
    cache_result,
    download_and_parse_json,
    gen_loot_table_tree,
    matching_len,
    render_snbt,
    with_prefix,
)
from core.definitions import (
    BLOCKS_URL,
    ITEMS_URL,
    MINECRAFT_VERSIONS,
    SPECIAL_ITEMS,
)

type StrDict = dict[str, str]
type StatesDict = dict[str, list[str]]
type StatesTuple = tuple[tuple[str, tuple[str, ...]], ...]
type RawBlocks = dict[str, tuple[StatesDict, StrDict]]

class Block(BaseModel):
    """Represents a Minecraft block."""

    type: str
    item: str | None
    group: int
    states: list["State"]

class State(BaseModel):
    """Represents the state of a Minecraft block within a sequence."""

    id: int
    name: str
    options: list[str]
    sequence_index: int
    sequence_ref: int | None


def beet_default(ctx: Context) -> None:
    """Generate files used by the bs.block module."""
    ctx.template.add_package(__name__)
    namespace = ctx.directory.name
    blocks = get_blocks(ctx, version := MINECRAFT_VERSIONS[-1])

    with ctx.override(generate_namespace=namespace):
        ctx.generate("has_state", gen_has_state_block_tag(blocks, version))

        ctx.generate("get/get_type", gen_get_type_loot_table(blocks))
        ctx.generate("get/get_block", gen_get_block_loot_table(blocks, namespace))
        for s in {s.id: s for b in blocks for s in b.states}.values():
            ctx.generate(f"get/{s.id}", gen_get_state_loot_table(s, namespace))

        ctx.generate("import/types_table",
            types=render_snbt({
                b.type: b.model_dump(exclude={"states"})
                for b in blocks
            }),
            render=Function(source_path="types_table.jinja"),
        )
        ctx.generate("import/items_table",
            items=render_snbt({
                b.item: b.model_dump(exclude={"states"})
                for b in reversed(blocks)
            }),
            render=Function(source_path="items_table.jinja"),
        )
        ctx.generate("import/groups_table",
            groups=render_snbt(format_groups_table(blocks)),
            render=Function(source_path="groups_table.jinja"),
        )


def get_blocks(ctx: Context, version: str) -> list[Block]:
    """Retrieve and optimizes blocks for the given version."""
    cache = ctx.cache[f"version/{version}"]

    @cache_result(cache, "blocks.json")
    def get_optimized_blocks() -> list:
        raw_blocks = download_and_parse_json(cache, BLOCKS_URL.format(version))
        if not isinstance(raw_blocks, dict):
            error_msg = f"Expected a dict, but got {type(raw_blocks)}"
            raise TypeError(error_msg)

        raw_items = download_and_parse_json(cache, ITEMS_URL.format(version))
        if not isinstance(raw_items, list):
            error_msg = f"Expected a list, but got {type(raw_items)}"
            raise TypeError(error_msg)

        items = {
            with_prefix(item): with_prefix(item)
            for item in raw_items
        } | SPECIAL_ITEMS
        return group_and_optimize_blocks(raw_blocks, items)

    return [Block.model_validate(data) for data in get_optimized_blocks()]


def group_and_optimize_blocks(raw_blocks: RawBlocks, items: StrDict) -> list:
    """Group blocks and optimizes block state sequences."""
    blocks: list[dict] = []
    groups: dict[StatesTuple, int] = {(): 0}

    for block, (states, properties) in raw_blocks.items():
        ordered_states = reorder_states_options(states, properties)
        insort(blocks, {
            "type": with_prefix(block),
            "item": items.get(with_prefix(block)),
            "group": groups.setdefault(ordered_states, len(groups)),
        }, key=lambda x: x["group"])

    optimized_groups = optimize_states_sequences(list(groups.keys()))
    return [{**block, "states": optimized_groups[block["group"]]} for block in blocks]


def reorder_states_options(states: StatesDict, properties: StrDict) -> StatesTuple:
    """Roll options to ensure the default state value appears first."""
    return tuple(
        (name, tuple(np.roll(options, -options.index(properties[name]))))
        for name, options in sorted(states.items())
    )


def optimize_states_sequences(groups: list[StatesTuple]) -> list[list[dict]]:
    """Optimize block state sequences by sorting and assigning unique IDs."""
    sequence_map = {}
    optimized_groups = []
    next_id = 1

    for group, states in zip(groups, get_best_sequences(groups), strict=True):
        ref = None
        sequence: StatesTuple = ()
        optimized_group = []
        for state in states:
            sequence += (state,)
            if sequence not in sequence_map:
                sequence_map[sequence] = next_id
                next_id += 1

            optimized_group.append({
                "id": sequence_map[sequence],
                "name": state[0],
                "options": next(x[1] for x in group if x[0] == state[0]),
                "sequence_index": len(sequence) - 1,
                "sequence_ref": ref,
            })
            ref = sequence_map[sequence]

        optimized_groups.append(optimized_group)

    return optimized_groups


def get_best_sequences(groups: list[StatesTuple]) -> list[StatesTuple]:
    """Find the most optimal state sequences based on frequency and matching lengths."""
    sorted_groups = [[(n, tuple(sorted(o))) for n, o in s] for s in groups]
    counter = Counter(chain.from_iterable(sorted_groups))

    sequences_perms: list[list[StatesTuple]] = [[
        perm + tuple(s for s in states if counter[s] <= 1)
        for perm in permutations([s for s in states if counter[s] > 1])
    ] for states in sorted_groups]

    sequences: list[StatesTuple] = []
    while sequences_perms:
        sequences.append(max(sequences_perms.pop(0), key=lambda seqs:
            sum(matching_len(seqs, seq) for seq in sequences) + sum(
                max(matching_len(seqs, seq) for seq in remaining_seqs)
                for remaining_seqs in sequences_perms
            ),
        ))

    return sequences


def format_block_entry(entry: dict, block: Block) -> dict:
    """Format a block entry for a loot table."""
    return {
        **entry,
        "functions": [{
            "function": "set_custom_data",
            "tag": render_snbt(block.model_dump(exclude={"states"})),
        }],
    }


def format_state_entry(entry: dict, option: str, state: State) -> dict:
    """Format a state entry for a loot table."""
    return {
        **entry,
        "functions": [{
            "function": "set_custom_data",
            "tag": render_snbt({
                "properties": {state.name: option},
                "_": {state.sequence_index: f"{state.name}={option},"},
            }),
        }],
        "conditions": [{
            "condition": "location_check",
            "predicate": {"block": {"state": {state.name: option}}},
        }],
    }


def format_groups_table(blocks: list[Block]) -> dict:
    """Organize block states groups into a structured format."""
    return {
        block.group: [{
            "i": state.sequence_index,
            "n": state.name,
            "o": [{
                "i": idx,
                "v": value,
                "p": {state.name: value},
                "s":  {state.sequence_index: f"{state.name}={value},"},
            } for idx, value in enumerate(state.options)],
        } for state in block.states]
        for block in blocks
    }


def gen_get_type_loot_table(blocks: list[Block]) -> LootTable:
    """Generate a loot table to retrieve block types."""
    return LootTable(
        gen_loot_table_tree(blocks, lambda block: format_block_entry({
            "type": "item",
            "name": "egg",
        }, block), lambda blocks: [{
            "condition": "location_check",
            "predicate": {"block": {"blocks": [b.type[10:] for b in blocks]}},
        }]),
    )


def gen_get_block_loot_table(blocks: list[Block], namespace: str) -> LootTable:
    """Generate a loot table to retrieve block data."""
    return LootTable(
        gen_loot_table_tree(blocks, lambda block: format_block_entry({
            "type": "item",
            "name": "egg",
        } if block.group == 0 else {
            "type": "loot_table",
            "value": f"{namespace}:get/{block.states[-1].id}",
        }, block), lambda blocks: [{
            "condition": "location_check",
            "predicate": {"block": {"blocks": [b.type[10:] for b in blocks]}},
        }]),
    )


def gen_get_state_loot_table(state: State, namespace: str) -> LootTable:
    """Generate a loot table to retrieve a single block state property."""
    return LootTable(
        {"pools": [{"rolls": 1, "entries": [{"type": "alternatives","children":[
            format_state_entry({
                "type": "loot_table",
                "value": f"{namespace}:get/{state.sequence_ref}",
            } if state.sequence_ref else {
                "type": "item",
                "name": "egg",
            }, option, state)
            for option in state.options
        ]}]}]},
    )


def gen_has_state_block_tag(blocks: list[Block], version: str) -> BlockTag:
    """Generate a block tag for blocks with states."""
    return BlockTag({
        "__bookshelf__": {
            "feature": True,
            "documentation": "https://docs.mcbookshelf.dev/en/latest/modules/block.html#has-state",
            "authors": ["Aksiome"],
            "created": {"date": "2024/01/15", "minecraft_version": "1.20.5"},
            "updated": {
                "date": datetime.now(timezone.utc).strftime("%Y/%m/%d"),
                "minecraft_version": version,
            },
        },
        "values": [b.type for b in blocks if b.group > 0],
    })

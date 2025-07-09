from bisect import insort
from collections import Counter
from itertools import chain, permutations

import numpy as np
from beet import BlockTag, Context, Function, LootTable
from pydantic import BaseModel

from bookshelf.definitions import MC_VERSIONS
from bookshelf.helpers import (
    cache_result,
    download_and_parse_json,
    gen_loot_table_tree,
    matching_len,
    render_snbt,
    with_prefix,
)

BLOCKS_META = "https://raw.githubusercontent.com/misode/mcmeta/{}-summary/blocks/data.min.json"
ITEMS_META = "https://raw.githubusercontent.com/misode/mcmeta/{}-registries/item/data.min.json"
SOUNDS_META = "https://raw.githubusercontent.com/mcbookshelf/mcdata/refs/tags/{}/blocks/sounds.min.json"
SPECIAL_ITEMS = {
  "minecraft:acacia_wall_hanging_sign": "minecraft:acacia_hanging_sign",
  "minecraft:acacia_wall_sign": "minecraft:acacia_sign",
  "minecraft:attached_melon_stem": "minecraft:melon_seeds",
  "minecraft:attached_pumpkin_stem": "minecraft:melon_seeds",
  "minecraft:bamboo_wall_hanging_sign": "minecraft:bamboo_hanging_sign",
  "minecraft:bamboo_wall_sign": "minecraft:bamboo_sign",
  "minecraft:beetroots": "minecraft:beetroot_seeds",
  "minecraft:big_dripleaf_stem": "minecraft:big_dripleaf",
  "minecraft:birch_wall_hanging_sign": "minecraft:birch_hanging_sign",
  "minecraft:birch_wall_sign": "minecraft:birch_sign",
  "minecraft:black_wall_banner": "minecraft:black_banner",
  "minecraft:blue_wall_banner": "minecraft:blue_banner",
  "minecraft:brain_coral_wall_fan": "minecraft:brain_coral_fan",
  "minecraft:brown_wall_banner": "minecraft:brown_banner",
  "minecraft:bubble_coral_wall_fan": "minecraft:bubble_coral_fan",
  "minecraft:carrots": "minecraft:carrot",
  "minecraft:cave_vines_plant": "minecraft:glow_berries",
  "minecraft:cave_vines": "minecraft:glow_berries",
  "minecraft:cherry_wall_hanging_sign": "minecraft:cherry_hanging_sign",
  "minecraft:cherry_wall_sign": "minecraft:cherry_sign",
  "minecraft:cocoa": "minecraft:cocoa_beans",
  "minecraft:creeper_wall_head": "minecraft:creeper_head",
  "minecraft:crimson_wall_hanging_sign": "minecraft:crimson_hanging_sign",
  "minecraft:crimson_wall_sign": "minecraft:crimson_sign",
  "minecraft:cyan_wall_banner": "minecraft:cyan_banner",
  "minecraft:dark_oak_wall_hanging_sign": "minecraft:dark_oak_hanging_sign",
  "minecraft:dark_oak_wall_sign": "minecraft:dark_oak_sign",
  "minecraft:dead_brain_coral_wall_fan": "minecraft:dead_brain_coral_fan",
  "minecraft:dead_bubble_coral_wall_fan": "minecraft:dead_bubble_coral_fan",
  "minecraft:dead_fire_coral_wall_fan": "minecraft:dead_fire_coral_fan",
  "minecraft:dead_horn_coral_wall_fan": "minecraft:dead_horn_coral_fan",
  "minecraft:dead_tube_coral_wall_fan": "minecraft:dead_tube_coral_fan",
  "minecraft:dragon_wall_head": "minecraft:dragon_head",
  "minecraft:fire_coral_wall_fan": "minecraft:fire_coral_fan",
  "minecraft:gray_wall_banner": "minecraft:gray_banner",
  "minecraft:green_wall_banner": "minecraft:green_banner",
  "minecraft:horn_coral_wall_fan": "minecraft:horn_coral_fan",
  "minecraft:jungle_wall_hanging_sign": "minecraft:jungle_hanging_sign",
  "minecraft:jungle_wall_sign": "minecraft:jungle_sign",
  "minecraft:lava_cauldron": "minecraft:cauldron",
  "minecraft:lava": "minecraft:lava_bucket",
  "minecraft:light_blue_wall_banner": "minecraft:light_blue_banner",
  "minecraft:light_gray_wall_banner": "minecraft:light_gray_banner",
  "minecraft:lime_wall_banner": "minecraft:lime_banner",
  "minecraft:magenta_wall_banner": "minecraft:magenta_banner",
  "minecraft:mangrove_wall_hanging_sign": "minecraft:mangrove_hanging_sign",
  "minecraft:mangrove_wall_sign": "minecraft:mangrove_sign",
  "minecraft:melon_stem": "minecraft:pumpkin_seeds",
  "minecraft:oak_wall_hanging_sign": "minecraft:oak_hanging_sign",
  "minecraft:oak_wall_sign": "minecraft:oak_sign",
  "minecraft:orange_wall_banner": "minecraft:orange_banner",
  "minecraft:pale_oak_wall_hanging_sign": "minecraft:pale_oak_hanging_sign",
  "minecraft:pale_oak_wall_sign": "minecraft:pale_oak_sign",
  "minecraft:piglin_wall_head": "minecraft:piglin_head",
  "minecraft:pink_wall_banner": "minecraft:pink_banner",
  "minecraft:pitcher_crop": "minecraft:pitcher_pod",
  "minecraft:player_wall_head": "minecraft:player_head",
  "minecraft:potatoes": "minecraft:potato",
  "minecraft:powder_snow_cauldron": "minecraft:cauldron",
  "minecraft:powder_snow": "minecraft:powder_snow_bucket",
  "minecraft:pumpkin_stem": "minecraft:pumpkin_seeds",
  "minecraft:purple_wall_banner": "minecraft:purple_banner",
  "minecraft:red_wall_banner": "minecraft:red_banner",
  "minecraft:redstone_wall_torch": "minecraft:redstone_torch",
  "minecraft:redstone_wire": "minecraft:redstone",
  "minecraft:skeleton_wall_skull": "minecraft:skeleton_skull",
  "minecraft:soul_wall_torch": "minecraft:soul_torch",
  "minecraft:spruce_wall_hanging_sign": "minecraft:spruce_hanging_sign",
  "minecraft:spruce_wall_sign": "minecraft:spruce_sign",
  "minecraft:sweet_berry_bush": "minecraft:sweet_berries",
  "minecraft:torchflower_crop": "minecraft:torchflower_seeds",
  "minecraft:tripwire": "minecraft:string",
  "minecraft:tube_coral_wall_fan": "minecraft:tube_coral_fan",
  "minecraft:wall_torch": "minecraft:torch",
  "minecraft:warped_wall_hanging_sign": "minecraft:warped_hanging_sign",
  "minecraft:warped_wall_sign": "minecraft:warped_sign",
  "minecraft:water_cauldron": "minecraft:cauldron",
  "minecraft:water": "minecraft:water_bucket",
  "minecraft:wheat": "minecraft:wheat_seeds",
  "minecraft:white_wall_banner": "minecraft:white_banner",
  "minecraft:wither_skeleton_wall_skull": "minecraft:wither_skeleton_skull",
  "minecraft:yellow_wall_banner": "minecraft:yellow_banner",
  "minecraft:zombie_wall_head": "minecraft:zombie_head",
}

type StrDict = dict[str, str]
type StatesDict = dict[str, list[str]]
type StatesTuple = tuple[tuple[str, tuple[str, ...]], ...]
type Blocks = dict[str, tuple[StatesDict, StrDict]]
type Items = StrDict
type Sounds = dict[str, StrDict]

class Block(BaseModel):
    """Represents a Minecraft block."""

    type: str
    item: str | None
    group: int
    sounds: dict[str, str]
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
    blocks = get_blocks(ctx, MC_VERSIONS[-1])

    with ctx.override(generate_namespace=namespace):
        ctx.data.block_tags \
            .get(f"{namespace}:has_state", BlockTag()) \
            .merge(gen_has_state_block_tag(blocks))

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
        blocks = download_and_parse_json(cache, BLOCKS_META.format(version))
        if not isinstance(blocks, dict):
            error_msg = f"Expected a dict, but got {type(blocks)}"
            raise TypeError(error_msg)

        items = download_and_parse_json(cache, ITEMS_META.format(version))
        if not isinstance(items, list):
            error_msg = f"Expected a list, but got {type(items)}"
            raise TypeError(error_msg)

        sounds = download_and_parse_json(cache, SOUNDS_META.format(version))
        if not isinstance(sounds, dict):
            error_msg = f"Expected a dict, but got {type(sounds)}"
            raise TypeError(error_msg)

        return group_and_optimize_blocks(blocks, {
            with_prefix(item): with_prefix(item)
            for item in items
        } | SPECIAL_ITEMS, sounds)

    return [Block.model_validate(data) for data in get_optimized_blocks()]


def group_and_optimize_blocks(blocks: Blocks, items: Items, sounds: Sounds) -> list:
    """Group blocks and optimizes block state sequences."""
    formatted_blocks: list[dict] = []
    groups: dict[StatesTuple, int] = {(): 0}

    for block, (states, properties) in blocks.items():
        ordered_states = reorder_states_options(states, properties)
        namespaced_block = with_prefix(block)
        insort(formatted_blocks, {
            "type": namespaced_block,
            "item": items.get(namespaced_block),
            "sounds": sounds.get(namespaced_block, {}),
            "group": groups.setdefault(ordered_states, len(groups)),
        }, key=lambda x: x["group"])

    optimized_groups = optimize_states_sequences(list(groups.keys()))
    return [
        {**block, "states": optimized_groups[block["group"]]}
        for block in formatted_blocks
    ]


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


def gen_has_state_block_tag(blocks: list[Block]) -> BlockTag:
    """Generate a block tag for blocks with states."""
    return BlockTag({
        "replace": True,
        "values": [b.type for b in blocks if b.group > 0],
    })

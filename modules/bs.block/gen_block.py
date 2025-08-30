from collections.abc import Sequence

from beet import BlockTag, Context, Function, LootTable

from bookshelf.definitions import MC_VERSIONS
from bookshelf.models import Block, StateNode, StatePredicate, StateProperty
from bookshelf.services import minecraft


def beet_default(ctx: Context) -> None:
    """Generate files used by the bs.block module."""
    namespace = ctx.directory.name
    blocks = minecraft.get_blocks(ctx, MC_VERSIONS[-1])

    loot_table = make_type_loot_table(blocks)
    ctx.generate(f"{namespace}:get/get_type", render=loot_table)
    loot_table = make_block_loot_table(blocks, f"{namespace}:get")
    ctx.generate(f"{namespace}:get/get_block", render=loot_table)

    for state in {s.group: s for b in blocks for s in b.properties}.values():
        loot_table = make_state_loot_table(state, f"{namespace}:get")
        ctx.generate(f"{namespace}:get/{state.group}", render=loot_table)

    for kind, formatter in {
        "types": format_types_table,
        "items": format_items_table,
        "groups": format_groups_table,
    }.items():
        ctx.generate(
            f"{namespace}:import/{kind}_table",
            render=Function(source_path=f"{kind}_table.jinja"),
            data=formatter(blocks),
        )

    if tag := ctx.data.block_tags.get(f"{namespace}:has_state"):
        tag.merge(BlockTag({
            "replace": True,
            "values": sorted(block.type for block in blocks if block.group > 0),
        }))


def format_types_table(blocks: Sequence[Block]) -> dict:
    """Return mapping of block type → block data."""
    # @deprecated sounds (removed in in 4.0.0)
    return {
        b.type: b.model_dump(include={"type", "item", "group", "sounds"})
        for b in blocks
    }


def format_items_table(blocks: Sequence[Block]) -> dict:
    """Return mapping of block item → block data."""
    # @deprecated sounds (removed in in 4.0.0)
    return {
        b.item: b.model_dump(include={"type", "item", "group", "sounds"})
        for b in reversed(blocks)
    }


def format_groups_table(blocks: Sequence[Block]) -> dict:
    """Return mapping of group → list of property definitions."""
    return {
        block.group: [{
            "i": prop.sequence_index,
            "n": prop.name,
            "o": [{
                "i": idx,
                "v": value,
                "p": {prop.name: value},
                "s":  {prop.sequence_index: f"{prop.name}={value},"},
            } for idx, value in enumerate(prop.options)],
        } for prop in block.properties]
        for block in blocks
    }


def format_block_entry(entry: dict, block: Block) -> dict:
    """Attach block data to a loot entry."""
    # @deprecated sounds (removed in in 4.0.0)
    return {
        **entry,
        "functions": [{
            "function": "set_custom_data",
            "tag": minecraft.render_snbt(block.model_dump(
                include={"type", "item", "group", "sounds"},
            )),
        }],
    }


def format_state_entry(entry: dict, state: StateProperty, option: str) -> dict:
    """Attach state data to a loot entry."""
    return {
        **entry,
        "functions": [{
            "function": "set_custom_data",
            "tag": minecraft.render_snbt({
                "properties": {state.name: option},
                "_": {state.sequence_index: f"{state.name}={option},"},
            }),
        }],
    }


def make_type_loot_table(blocks: Sequence[Block]) -> LootTable:
    """Create a loot table to retrieve block types."""
    return minecraft.make_binary_loot_table(
        blocks,
        lambda block: format_block_entry({
            "type": "item",
            "name": "egg",
        }, block),
        lambda blocks: [{
            "condition": "location_check",
            "predicate": {"block": {"blocks": [b.type[10:] for b in blocks]}},
        }],
    )


def make_block_loot_table(blocks: Sequence[Block], path: str) -> LootTable:
    """Create a loot table to retrieve block data."""
    return minecraft.make_binary_loot_table(
        blocks,
        lambda block: format_block_entry({
            "type": "item",
            "name": "egg",
        } if block.group == 0 else {
            "type": "loot_table",
            "value": f"{path}/{block.properties[-1].group}",
        }, block),
        lambda blocks: [{
            "condition": "location_check",
            "predicate": {"block": {"blocks": [b.type[10:] for b in blocks]}},
        }],
    )


def make_state_loot_table(state: StateProperty, path: str) -> LootTable:
    """Create a loot table to retrieve a single block state property."""
    return minecraft.make_state_loot_table(
        StatePredicate[tuple[StateProperty, str]](
            group=state.group,
            tree=StateNode(state.name, {o: (state, o) for o in state.options}),
        ),
        lambda entry: format_state_entry({
            "type": "loot_table",
            "value": f"{path}/{state.sequence_ref}",
        } if state.sequence_ref else {
            "type": "item",
            "name": "egg",
        }, entry[0], entry[1]),
    )

from collections import defaultdict
from collections.abc import Callable, Sequence
from itertools import chain

from beet import BlockTag, Context, Function, LootTable

from bookshelf.definitions import MC_VERSIONS
from bookshelf.models import Block, StateNode, StatePredicate, StateProperty, StateValue
from bookshelf.services import minecraft


def beet_default(ctx: Context) -> None:
    """Generate files used by the bs.block module."""
    namespace = ctx.directory.name
    blocks = minecraft.get_blocks(ctx, MC_VERSIONS[-1])

    loot_table = make_type_loot_table(blocks)
    ctx.generate(f"{namespace}:block/get_type", render=loot_table)
    loot_table = make_block_loot_table(blocks, f"{namespace}:block")
    ctx.generate(f"{namespace}:block/get_block", render=loot_table)

    for state in {s.group: s for b in blocks for s in b.properties}.values():
        loot_table = make_block_state_loot_table(state, f"{namespace}:block")
        ctx.generate(f"{namespace}:block/{state.group}", render=loot_table)

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
        tag.merge(make_block_tag(blocks, lambda b: b.group > 0))

    for attr in ["can_occlude", "ignited_by_lava"]:
        if tag := ctx.data.block_tags.get(f"{namespace}:{attr}"):
            tag.merge(make_block_tag(blocks, lambda b, attr = attr: getattr(b, attr)))

    for attr, groups in [
        ("blast_resistance", defaultdict(list)),
        ("friction", defaultdict(list)),
        ("hardness", defaultdict(list)),
        ("instrument", defaultdict(list)),
        ("jump_factor", defaultdict(list)),
        ("luminance", defaultdict(list)),
        ("sounds", defaultdict(list)),
        ("speed_factor", defaultdict(list)),
        ("is_conductive", defaultdict(list)),
        ("is_spawnable", defaultdict(list)),
    ]:
        seen = set()
        for block in blocks:
            value = getattr(block, attr)
            groups[value].append(block)
            if isinstance(value, StatePredicate) and value not in seen:
                seen.add(value)
                loot_table = make_attr_state_loot_table(attr, value)
                ctx.generate(f"{namespace}:{attr}/{value.group}", render=loot_table)

        loot_table = make_attr_loot_table(attr, groups, f"{namespace}:{attr}")
        ctx.generate(f"{namespace}:{attr}/get", render=loot_table)


def make_block_tag(
    blocks: Sequence[Block],
    predicate: Callable[[Block], bool],
    extras: list | None = None,
) -> BlockTag:
    """Create a block tag for blocks that match the predicate."""
    return BlockTag({
        "replace": True,
        "values": sorted(chain(
            extras or [],
            (block.type for block in blocks if predicate(block)),
        )),
    })


def format_types_table(blocks: Sequence[Block]) -> dict:
    """Return mapping of block type → block data."""
    return {
        b.type: b.model_dump(include={
            "type",
            "item",
            "group",
            "can_occlude",
            "ignited_by_lava",
            "blast_resistance",
            "friction",
            "hardness",
            "jump_factor",
            "speed_factor",
            "instrument",
            "sounds",
        })
        for b in blocks
    }


def format_items_table(blocks: Sequence[Block]) -> dict:
    """Return mapping of block item → block data."""
    return {
        b.item: b.model_dump(include={
            "type",
            "item",
            "group",
            "can_occlude",
            "ignited_by_lava",
            "blast_resistance",
            "friction",
            "hardness",
            "jump_factor",
            "speed_factor",
            "instrument",
            "sounds",
        })
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


def make_block_state_loot_table(state: StateProperty, path: str) -> LootTable:
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


def make_attr_loot_table[T](
    attr: str,
    groups: dict[StateValue[T], list[Block]],
    path: str,
) -> LootTable:
    """Create a loot table for a collection of blocks grouped by shape."""
    return minecraft.make_binary_loot_table(
        tuple(groups.items()),
        lambda entry: {
            "type": "loot_table",
            "value": f"{path}/{entry[0].group}",
        } if isinstance(entry[0], StatePredicate) else {
            "type": "item",
            "name": "egg",
            "functions": [{
                "function": "set_custom_data",
                "tag": minecraft.render_snbt({attr: entry[0]}),
            }],
        },
        lambda entries: [{
            "condition": "location_check",
            "predicate": {"block": {"blocks": [
                block.type[10:]
                for _, blocks in entries for block in blocks
            ]}},
        }],
    )


def make_attr_state_loot_table(attr: str, entry: StatePredicate) -> LootTable:
    """Create a loot table for a given state entry."""
    return minecraft.make_state_loot_table(
        entry,
        lambda value: {
            "type": "item",
            "name": "egg",
            "functions": [{
                "function": "set_custom_data",
                "tag": minecraft.render_snbt({attr: value}),
            }],
        },
    )

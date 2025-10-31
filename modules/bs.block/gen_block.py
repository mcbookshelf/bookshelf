from collections import defaultdict
from collections.abc import Sequence

from beet import Context, Function, LootTable, Predicate

from bookshelf.definitions import MC_VERSIONS
from bookshelf.models import Block, StateNode, StatePredicate, StateProperty, StateValue
from bookshelf.services import minecraft

ATTR_TAGS = [
    ("has_state", lambda b: b.group > 0),
    ("can_occlude", lambda b: b.can_occlude),
    ("ignited_by_lava", lambda b: b.ignited_by_lava),
]

ATTR_PREDICATES = [
    ("is_conductive", lambda b: b.is_conductive),
    ("is_spawnable", lambda b: b.is_spawnable),
]

ATTR_LOOT_TABLES = [
    ("blast_resistance", lambda b: b.blast_resistance),
    ("friction", lambda b: b.friction),
    ("hardness", lambda b: b.hardness),
    ("instrument", lambda b: b.instrument),
    ("jump_factor", lambda b: b.jump_factor),
    ("luminance", lambda b: b.luminance),
    ("sounds", lambda b: b.sounds),
    ("speed_factor", lambda b: b.speed_factor),
]

DATA_TABLE_INCLUDE = {
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
}


def beet_default(ctx: Context) -> None:
    """Generate files used by the bs.block module."""
    namespace = ctx.directory.name
    blocks = minecraft.get_blocks(ctx, MC_VERSIONS[-1])

    loot_table = make_block_loot_table(blocks)
    ctx.generate(f"{namespace}:internal/get_type", render=loot_table)
    loot_table = make_block_loot_table(blocks, f"{namespace}:internal")
    ctx.generate(f"{namespace}:internal/get_block", render=loot_table)

    for state in {s.group: s for b in blocks for s in b.properties}.values():
        loot_table = make_block_state_loot_table(state, f"{namespace}:internal")
        ctx.generate(f"{namespace}:internal/group_{state.group}", render=loot_table)

    for name, formatter in [
        ("types", format_types_table),
        ("items", format_items_table),
        ("groups", format_groups_table),
    ]:
        ctx.generate(
            f"{namespace}:import/{name}_table",
            render=Function(source_path=f"{name}_table.jinja"),
            data=formatter(blocks),
        )

    for name, predicate in ATTR_TAGS:
        tag = ctx.data.block_tags.get(f"{namespace}:{name}")
        tag.merge(minecraft.make_block_tag(blocks, predicate))

    for name, attribute in ATTR_PREDICATES:
        groups = defaultdict(list)
        for block in blocks:
            groups[attribute(block)].append(block)
        merge_attr_predicate(ctx.data.predicates.get(f"{namespace}:{name}"), groups)

    for name, attribute in ATTR_LOOT_TABLES:
        seen = set()
        groups = defaultdict(list)
        for block in blocks:
            groups[value := attribute(block)].append(block)
            if isinstance(value, StatePredicate) and value not in seen:
                seen.add(value)
                file = make_attr_state_loot_table(name, value)
                ctx.generate(f"{namespace}:internal/{name}_{value.group}", render=file)

        file = make_attr_loot_table(name, groups, f"{namespace}:internal")
        ctx.generate(f"{namespace}:internal/get_{name}", render=file)


def format_types_table(blocks: Sequence[Block]) -> dict:
    """Return mapping of block type → block data."""
    return {b.type: b.model_dump(include=DATA_TABLE_INCLUDE) for b in blocks}


def format_items_table(blocks: Sequence[Block]) -> dict:
    """Return mapping of block item → block data."""
    return {b.item: b.model_dump(include=DATA_TABLE_INCLUDE) for b in reversed(blocks)}


def format_groups_table(blocks: Sequence[Block]) -> dict:
    """Return mapping of group → list of property definitions."""
    return {block.group: [{
        "i": prop.sequence_index,
        "n": prop.name,
        "o": [{
            "i": idx,
            "v": value,
            "p": {prop.name: value},
            "s":  {prop.sequence_index: f"{prop.name}={value},"},
        } for idx, value in enumerate(prop.options)],
    } for prop in block.properties] for block in blocks}


def format_block_loot_entry(entry: dict, block: Block) -> dict:
    """Attach block data to a loot entry."""
    # @deprecated sounds (removed in in 4.0.0)
    return {**entry, "functions": [{
        "function": "set_custom_data",
        "tag": minecraft.render_snbt(block.model_dump(
            include={"type", "item", "group", "sounds"},
        )),
    }]}


def format_state_loot_entry(entry: dict, state: StateProperty, option: str) -> dict:
    """Attach state data to a loot entry."""
    return {**entry, "functions": [{
        "function": "set_custom_data",
        "tag": minecraft.render_snbt({
            "properties": {state.name: option},
            "_": {state.sequence_index: f"{state.name}={option},"},
        }),
    }]}


def make_block_loot_table(
    blocks: Sequence[Block],
    path: str | None = None,
) -> LootTable:
    """Create a loot table to retrieve block data."""
    return minecraft.make_loot_table_binary(
        blocks,
        lambda block: format_block_loot_entry({
            "type": "loot_table",
            "value": f"{path}/group_{block.properties[-1].group}",
        } if path and block.group != 0 else {
            "type": "item",
            "name": "egg",
        }, block),
        lambda blocks: [{
            "condition": "location_check",
            "predicate": {"block": {"blocks": [b.type[10:] for b in blocks]}},
        }],
    )


def make_block_state_loot_table(state: StateProperty, path: str) -> LootTable:
    """Create a loot table to retrieve a single block state property."""
    return minecraft.make_loot_table_state(
        StatePredicate[tuple[StateProperty, str]](
            group=state.group,
            tree=StateNode(state.name, {o: (state, o) for o in state.options}),
        ),
        lambda entry: format_state_loot_entry({
            "type": "loot_table",
            "value": f"{path}/group_{state.sequence_ref}",
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
    """Create a loot table for a collection of blocks grouped by attribute."""
    return minecraft.make_loot_table_binary(
        tuple(groups.items()),
        lambda entry: {
            "type": "loot_table",
            "value": f"{path}/{attr}_{entry[0].group}",
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
    return minecraft.make_loot_table_state(entry, lambda value: {
        "type": "item",
        "name": "egg",
        "functions": [{
            "function": "set_custom_data",
            "tag": minecraft.render_snbt({attr: value}),
        }],
    })


def merge_attr_predicate(
    predicate: Predicate,
    groups: dict[StateValue[bool], list[Block]],
) -> None:
    """Create a predicate for a collection of blocks grouped by attribute."""
    def optimize_entry(entry: dict) -> dict | None:
        terms = list(filter(None, entry.get("terms", [])))
        if len(terms) == 0:
            return None
        if len(terms) == 1:
            return terms[0]
        entry["terms"] = terms
        return entry

    def build_node[T: bool](node: StateNode[T] | T) -> dict | None:
        if not isinstance(node, StateNode):
            return {} if node else None

        terms = []
        for value, child in node.children.items():
            entry = build_node(child)
            if entry is not None:
                terms.append(optimize_entry({
                    "condition": "all_of",
                    "terms": [entry, {
                        "condition": "location_check",
                        "predicate": {"block": {"state": {node.name: value}}},
                    }],
                }))

        return optimize_entry({"condition":"any_of","terms":terms})

    predicate.set_content(optimize_entry({
        **predicate.deserialize(predicate.get_content()),
        "condition": "any_of",
        "terms": [optimize_entry({
            "condition": "all_of", "terms":[{
                "condition": "location_check",
                "predicate": {"block": {"blocks": [b.type[10:] for b in blocks]}},
            }, build_node(group.tree)],
        }) if isinstance(group, StatePredicate) else {
            "condition": "location_check",
            "predicate": {"block": {"blocks": [b.type[10:] for b in blocks]}},
        } for group, blocks in groups.items() if group],
    }))

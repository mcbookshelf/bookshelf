from collections import defaultdict

from beet import BlockTag, Context, LootTable
from pydantic import BaseModel

from bookshelf.definitions import MC_VERSIONS
from bookshelf.helpers import (
    download_and_parse_json,
    gen_loot_table_tree,
    render_snbt,
)

SHAPES_META = "https://raw.githubusercontent.com/mcbookshelf/mcdata/refs/tags/{}/blocks/shapes.min.json"

type Properties = dict[str, str]
type VoxelShape = list[list[float]]
type BlockShape = tuple[Properties, dict[str, VoxelShape]]

class BlockShapes(BaseModel):
    """Groups multiple blocks with similar shape definitions."""

    group: int
    blocks: list[str]
    offset: bool
    shapes: list[BlockShape]


def beet_default(ctx: Context) -> None:
    """Generate files used by the bs.hitbox module."""
    namespace = ctx.directory.name
    shapes = get_block_shapes(ctx, MC_VERSIONS[-1])

    ctx.data.block_tags \
        .get(f"{namespace}:can_pass_through", BlockTag()) \
        .merge(gen_can_pass_through_block_tag(shapes))
    ctx.data.block_tags \
        .get(f"{namespace}:has_offset", BlockTag()) \
        .merge(gen_has_offset_block_tag(shapes))
    ctx.data.block_tags \
        .get(f"{namespace}:intangible", BlockTag()) \
        .merge(gen_intangible_block_tag(shapes))
    ctx.data.block_tags \
        .get(f"{namespace}:is_full_cube", BlockTag()) \
        .merge(gen_is_full_cube_block_tag(shapes))

    with ctx.override(generate_namespace=namespace):
        ctx.generate("get/get_block", gen_get_block_loot_table(shapes, namespace))
        for entry in filter(lambda entry: entry.group > 0, shapes):
            ctx.generate(f"get/{entry.group}", gen_get_states_loot_table(entry.shapes))


def get_block_shapes(ctx: Context, version: str) -> list[BlockShapes]:
    """Retrieve and processes block shapes from the provided version."""
    cache = ctx.cache[f"version/{version}"]
    raw_shapes = download_and_parse_json(cache, SHAPES_META.format(version))
    if not isinstance(raw_shapes, (dict)):
        error_msg = f"Expected a dict, but got {type(raw_shapes)}"
        raise TypeError(error_msg)

    grouped_blocks = defaultdict(list)
    for block, entries in raw_shapes.items():
        offset = any(e["has_offset"] for e in entries)
        grouped_shapes = group_shapes_by_properties(entries)
        grouped_blocks[(offset, tuple(grouped_shapes.items()))].append(block)

    group = 0
    return [BlockShapes(
        blocks=blocks,
        offset=offset,
        shapes=[
            (dict(sorted(properties)), dict(shape))
            for properties, shape
            in shapes
        ],
        group=(group := group + 1) if len(shapes) > 1 else 0,
    ) for (offset, shapes), blocks in grouped_blocks.items()]


def group_shapes_by_properties(entries: list[dict]) -> dict:
    """Group shapes by their properties, keeping only those that affect the shape."""
    grouped_shapes = {
        frozenset(tuple(entry["properties"].items())): frozenset({
            key: tuple(tuple(v * 16 for v in box) for box in entry[field])
            for key, field in {
                "collision_shape": "collision_shape",
                "interaction_shape": "shape",
            }.items()
            if entry.get(field)
        }.items())
        for entry in entries
    }

    for prop, _ in next(iter(grouped_shapes.keys())):
        group = defaultdict(list)
        for key, shape in grouped_shapes.items():
            group[frozenset(k for k in key if k[0] != prop)].append(shape)
        if all(all(s == shapes[0] for s in shapes) for shapes in group.values()):
            grouped_shapes = {
                key: frozenset(shapes[0])
                for key, shapes in group.items()
            }

    return grouped_shapes


def format_shape_node(shapes: list[BlockShape], properties: list[str]) -> dict:
    """Format a loot table node for the given shapes and properties."""
    return format_shape_entry(shapes[0][1]) if len(properties) <= 1 else {
        "type": "alternatives",
        "children": format_shape_tree(shapes, properties[1:]),
    }


def format_shape_entry(shape: dict[str, VoxelShape]) -> dict:
    """Format a loot table entry for the given shape."""
    return {"type": "item", "name": "egg", "functions": [{
        "function": "set_custom_data",
        "tag": render_snbt(shape),
    }]}


def format_shape_tree(shapes: list[BlockShape], properties: list[str]) -> list:
    """Format a loot table tree for the given shapes and properties."""
    groups: defaultdict[str, list[BlockShape]] = defaultdict(list)
    for shape in shapes:
        value = shape[0][properties[0]]
        groups[value].append(shape)

    nodes = list(groups.items())

    return [{
        **format_shape_node(shapes, properties),
        "conditions": [{
            "condition": "location_check",
            "predicate": {"block": {"state": {properties[0]: value}}},
        }],
    } for value, shapes in nodes[:-1]] + [format_shape_node(nodes[-1][1], properties)]


def gen_get_block_loot_table(shapes: list[BlockShapes], namespace: str) -> LootTable:
    """Generate a loot table to retrieve simple block shapes."""
    return LootTable(
        gen_loot_table_tree(shapes, lambda entry: format_shape_entry(
            entry.shapes[0][1],
        ) if entry.group == 0 else {
            "type": "loot_table",
            "value": f"{namespace}:get/{entry.group}",
        }, lambda shapes: [{
            "condition": "location_check",
            "predicate": {"block": {"blocks": [
                block[10:]
                for entry in shapes for block in entry.blocks
            ]}},
        }]),
    )


def gen_get_states_loot_table(shape: list[BlockShape]) -> LootTable:
    """Generate a loot table to retrieve block shapes based on properties."""
    properties = {name: {entry[0][name] for entry in shape} for name in shape[0][0]}
    sorted_properties = sorted(properties, key=lambda name: len(properties[name]))

    return LootTable({"pools": [{"rolls": 1,"entries":[{
        "type": "alternatives",
        "children": format_shape_tree(shape, sorted_properties),
    }]}]})


def gen_can_pass_through_block_tag(shapes: list[BlockShapes]) -> BlockTag:
    """Generate a block tag for blocks that have no collision shape."""
    return BlockTag({
        "replace": True,
        "values": sorted([
            block for group in shapes
            for block in group.blocks
            if all(
                "collision_shape" not in shape[1]
                for shape in group.shapes
            ) and block != "minecraft:powder_snow"
        ]),
    })


def gen_has_offset_block_tag(shapes: list[BlockShapes]) -> BlockTag:
    """Generate a block tag for blocks with offsets."""
    return BlockTag({
        "replace": True,
        "values": sorted([
            block for group in shapes
            for block in group.blocks
            if group.offset
        ]),
    })


def gen_intangible_block_tag(shapes: list[BlockShapes]) -> BlockTag:
    """Generate a block tag for blocks that have no hitbox."""
    return BlockTag({
        "replace": True,
        "values": sorted([
            "minecraft:structure_void",
        ] + [
            block for group in shapes
            for block in group.blocks
            if all(shape[1] == {} for shape in group.shapes)
        ]),
    })


def gen_is_full_cube_block_tag(shapes: list[BlockShapes]) -> BlockTag:
    """Generate a block tag for simple cubes."""
    return BlockTag({
        "replace": True,
        "values": sorted([
            block for group in shapes
            for block in group.blocks
            if all(shape[1] == {
                "collision_shape": [[0.0, 0.0, 0.0, 16.0, 16.0, 16.0]],
                "interaction_shape": [[0.0, 0.0, 0.0, 16.0, 16.0, 16.0]],
            } for shape in group.shapes)
        ] + [
            # TODO: Remove in future versions.
            # Temporary hack for https://github.com/mcbookshelf/bookshelf/issues/462
            "minecraft:bubble_column",
            "minecraft:lava",
            "minecraft:water",
        ]),
    })

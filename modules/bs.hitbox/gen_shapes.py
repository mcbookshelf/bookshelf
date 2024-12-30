from collections import defaultdict
from datetime import datetime, timezone

from beet import BlockTag, Context, LootTable
from pydantic import BaseModel

from core.common.helpers import (
    download_and_parse_json,
    gen_loot_table_tree,
    render_snbt,
)
from core.definitions import MINECRAFT_VERSIONS, SHAPES_URL

type Properties = dict[str, str]
type VoxelShape = list[list[float]]
type BlockShape = tuple[Properties, VoxelShape]

class BlockShapes(BaseModel):
    """Groups multiple blocks with similar shape definitions."""

    group: int
    blocks: list[str]
    offset: bool
    shapes: list[BlockShape]


def beet_default(ctx: Context) -> None:
    """Generate files used by the bs.hitbox module."""
    namespace = ctx.directory.name
    shapes = get_block_shapes(ctx, version := MINECRAFT_VERSIONS[-1])

    with ctx.override(generate_namespace=namespace):
        ctx.generate("has_offset", gen_has_offset_block_tag(shapes, version))
        ctx.generate("is_composite", gen_is_composite_block_tag(shapes, version))

        ctx.generate("get/get_block", gen_get_block_loot_table(shapes, namespace))
        for entry in filter(lambda entry: entry.group > 0, shapes):
            ctx.generate(f"get/{entry.group}", gen_get_states_loot_table(entry.shapes))


def get_block_shapes(ctx: Context, version: str) -> list[BlockShapes]:
    """Retrieve and processes block shapes from the provided version."""
    cache = ctx.cache[f"version/{version}"]
    raw_shapes = download_and_parse_json(cache, SHAPES_URL.format(version))
    if not isinstance(raw_shapes, (dict)):
        error_msg = f"Expected a dict, but got {type(raw_shapes)}"
        raise TypeError(error_msg)

    grouped_blocks = defaultdict(list)
    for block, entries in raw_shapes.items():
        if not is_default_shape(entries):
            offset = any(e["has_offset"] for e in entries)
            grouped_shapes = group_shapes_by_properties(entries)
            grouped_blocks[(offset, tuple(grouped_shapes.items()))].append(block)

    group = 0
    return [BlockShapes(
        blocks=blocks,
        offset=offset,
        shapes=[(dict(properties), shape) for properties, shape in shapes],
        group=(group := group + 1) if len(shapes) > 1 else 0,
    ) for (offset, shapes), blocks in grouped_blocks.items()]


def is_default_shape(entries: list[dict]) -> bool:
    """Check if the entries contain only the default or empty shapes."""
    return all(e["shape"] in ([[0.0, 0.0, 0.0, 1.0, 1.0, 1.0]], []) for e in entries)


def group_shapes_by_properties(entries: list[dict]) -> dict:
    """Group shapes by their properties, keeping only those that affect the shape."""
    grouped_shapes = {
        frozenset(tuple(entry["properties"].items())): tuple(
            tuple(v * 16 for v in box)
            for box in entry["shape"]
        )
        for entry in entries
    }

    for prop, _ in next(iter(grouped_shapes.keys())):
        group = defaultdict(list)
        for key, shape in grouped_shapes.items():
            group[frozenset(k for k in key if k[0] != prop)].append(shape)
        if all(all(s == shapes[0] for s in shapes) for shapes in group.values()):
            grouped_shapes = {key: tuple(shapes[0]) for key, shapes in group.items()}

    return grouped_shapes


def format_shape_node(shapes: list[BlockShape], properties: list[str]) -> dict:
    """Format a loot table node for the given shapes and properties."""
    return format_shape_entry(shapes[0][1]) if len(properties) <= 1 else {
        "type": "alternatives",
        "children": format_shape_tree(shapes, properties[1:]),
    }


def format_shape_entry(shape: VoxelShape) -> dict:
    """Format a loot table entry for the given shape."""
    return {"type": "item", "name": "egg", "functions": [{
        "function": "set_custom_data",
        "tag": render_snbt({"shape": shape}),
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


def gen_has_offset_block_tag(shapes: list[BlockShapes], version: str) -> BlockTag:
    """Generate a block tag for blocks with offsets."""
    return BlockTag({
        "__bookshelf__": {
            "feature": True,
            "documentation": "https://docs.mcbookshelf.dev/en/latest/modules/hitbox.html#has-offset",
            "authors": ["Aksiome"],
            "created": {"date": "2024/09/28", "minecraft_version": "1.21"},
            "updated": {
                "date": datetime.now(timezone.utc).strftime("%Y/%m/%d"),
                "minecraft_version": version,
            },
        },
        "values": sorted([b for group in shapes for b in group.blocks if group.offset]),
    })


def gen_is_composite_block_tag(shapes: list[BlockShapes], version: str) -> BlockTag:
    """Generate a block tag for non simple cubes."""
    return BlockTag({
        "__bookshelf__": {
            "feature": True,
            "documentation": "https://docs.mcbookshelf.dev/en/latest/modules/hitbox.html#is-composite",
            "authors": ["Aksiome"],
            "created": {"date": "2024/09/28", "minecraft_version": "1.21"},
            "updated": {
                "date": datetime.now(timezone.utc).strftime("%Y/%m/%d"),
                "minecraft_version": version,
            },
        },
        "values": sorted([block for group in shapes for block in group.blocks]),
    })

from collections import defaultdict

from beet import Context, LootTable

from bookshelf.definitions import MC_VERSIONS
from bookshelf.models import Block, StatePredicate, StateValue, VoxelShape
from bookshelf.services import minecraft

CUBE = ((0.0, 0.0, 0.0, 16.0, 16.0, 16.0),)
INTANGIBLE = [
    "minecraft:light",
    "minecraft:structure_void",
]


def beet_default(ctx: Context) -> None:
    """Generate files used by the bs.hitbox module."""
    namespace = ctx.directory.name
    blocks = minecraft.get_blocks(ctx, MC_VERSIONS[-1])

    groups = {"shape": defaultdict(list), "collision": defaultdict(list)}
    seen = set()

    for block in blocks:
        groups["shape"][block.shape].append(block)
        groups["collision"][block.collision_shape].append(block)

        for shape in (block.shape, block.collision_shape):
            if isinstance(shape, StatePredicate) and shape.group not in seen:
                seen.add(shape.group)
                loot_table = make_loot_table_state(shape)
                ctx.generate(f"{namespace}:block/{shape.group}", render=loot_table)

    for name, mapping in groups.items():
        loot_table = make_shape_loot_table(mapping, f"{namespace}:block")
        ctx.generate(f"{namespace}:block/get_{name}", render=loot_table)

    for name, predicate in [
        ("has_shape_offset", lambda b: b.has_shape_offset),
        ("has_visual_offset", lambda b: b.has_visual_offset),
        ("can_pass_through", lambda b: not b.collision_shape),
        ("intangible", lambda b: b.type in INTANGIBLE or not b.shape),
        ("is_full_cube", lambda b: b.shape == CUBE and b.collision_shape == CUBE),
        ("is_waterloggable", lambda b:
            any(p.name == "waterlogged" for p in b.properties)),
    ]:
        if tag := ctx.data.block_tags.get(f"{namespace}:{name}"):
            tag.merge(minecraft.make_block_tag(blocks, predicate))


def make_shape_loot_table(
    groups: dict[StateValue[VoxelShape], list[Block]],
    path: str,
) -> LootTable:
    """Create a loot table for a collection of blocks grouped by shape."""
    return minecraft.make_loot_table_binary(
        tuple(groups.items()),
        lambda entry: {
            "type": "loot_table",
            "value": f"{path}/{entry[0].group}",
        } if isinstance(entry[0], StatePredicate) else {
            "type": "item",
            "name": "egg",
            "functions": [{
                "function": "set_custom_data",
                "tag": minecraft.render_snbt({"shape": entry[0]}),
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


def make_loot_table_state(entry: StatePredicate) -> LootTable:
    """Create a loot table for a given state entry."""
    return minecraft.make_loot_table_state(
        entry,
        lambda shape: {
            "type": "item",
            "name": "egg",
            "functions": [{
                "function": "set_custom_data",
                "tag": minecraft.render_snbt({"shape": shape}),
            }],
        },
    )

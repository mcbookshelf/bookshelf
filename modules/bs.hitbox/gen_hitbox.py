from collections import defaultdict
from collections.abc import Callable, Sequence
from itertools import chain

from beet import BlockTag, Context, LootTable

from bookshelf.definitions import MC_VERSIONS
from bookshelf.models import Block, StatePredicate, StateValue, VoxelShape
from bookshelf.services import minecraft


def beet_default(ctx: Context) -> None:
    """Generate files used by the bs.hitbox module."""
    namespace = ctx.directory.name
    blocks = minecraft.get_blocks(ctx, MC_VERSIONS[-1])

    groups = {"default": defaultdict(list), "collision": defaultdict(list)}
    seen = set()

    for block in blocks:
        groups["default"][block.shape].append(block)
        groups["collision"][block.collision_shape].append(block)

        for shape in (block.shape, block.collision_shape):
            if isinstance(shape, StatePredicate) and shape.group not in seen:
                seen.add(shape.group)
                loot_table = make_state_loot_table(shape)
                ctx.generate(f"{namespace}:block/{shape.group}", render=loot_table)

    for name, mapping in groups.items():
        loot_table = make_shape_loot_table(mapping, f"{namespace}:block")
        ctx.generate(f"{namespace}:block/{name}", render=loot_table)

    if tag := ctx.data.block_tags.get(f"{namespace}:has_shape_offset"):
        tag.merge(make_block_tag(blocks, lambda b: b.has_shape_offset))
    if tag := ctx.data.block_tags.get(f"{namespace}:has_visual_offset"):
        tag.merge(make_block_tag(blocks, lambda b: b.has_visual_offset))

    if tag := ctx.data.block_tags.get(f"{namespace}:can_pass_through"):
        tag.merge(make_block_tag(blocks, lambda b: not b.collision_shape))
    if tag := ctx.data.block_tags.get(f"{namespace}:intangible"):
        tag.merge(make_block_tag(blocks, lambda b: not b.shape, [
            "minecraft:light",
            "minecraft:structure_void",
        ]))

    if tag := ctx.data.block_tags.get(f"{namespace}:is_full_cube"):
        tag.merge(make_block_tag(blocks, lambda block: (
            block.shape == ((0.0, 0.0, 0.0, 16.0, 16.0, 16.0),)
            and block.collision_shape == ((0.0, 0.0, 0.0, 16.0, 16.0, 16.0),)
        )))


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


def make_shape_loot_table(
    groups: dict[StateValue[VoxelShape], list[Block]],
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


def make_state_loot_table(entry: StatePredicate) -> LootTable:
    """Create a loot table for a given state entry."""
    return minecraft.make_state_loot_table(
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

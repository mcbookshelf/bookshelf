from __future__ import annotations

from collections import defaultdict
from typing import TYPE_CHECKING

from beet import Context, LootTable, PackFile, Predicate

from bookshelf.services import minecraft

if TYPE_CHECKING:
    from collections.abc import Iterable, Sequence

    from bookshelf.models import Biome

SNOW_THRESHOLD = 0.4


@minecraft.generator
def beet_default(ctx: Context, version: str) -> Iterable[tuple[str, PackFile]]:
    """Generate files used by the environment module."""
    ns = ctx.directory.name
    biomes = minecraft.get_biomes(ctx.cache, version)

    yield f"{ns}:internal/get_biome", make_biome_loot_table(biomes)
    base = ctx.data.predicates[location := f"{ns}:can_snow"]
    yield location, make_can_snow_predicate(base, biomes)
    base = ctx.data.predicates[location := f"{ns}:has_precipitation"]
    yield location, make_has_precipitation_predicate(base, biomes)


def make_has_precipitation_predicate(
    base: Predicate,
    biomes: Sequence[Biome],
) -> Predicate:
    """Create a predicate to determine biomes with precipitation."""
    return Predicate({
        **base.data,
        "condition": "minecraft:location_check",
        "predicate": {"biomes": [b.type for b in biomes if b.has_precipitation]},
    })


def make_can_snow_predicate(
    base: Predicate,
    biomes: Sequence[Biome],
) -> Predicate:
    """Create a predicate to determine where snow can occur."""
    groups = defaultdict(list[str])
    for biome in filter(
        lambda b: b.temperature < SNOW_THRESHOLD and b.has_precipitation,
        biomes,
    ):
        # Calculate minimum y-level for snow based on biome temperature
        y = int((biome.temperature - 0.15) / 0.00125 + 80)
        groups[str(y if y > 0 else -2147483648)].append(biome.type)

    return Predicate({
        **base.data,
        "condition":"minecraft:any_of",
        "terms": [{
            "condition": "minecraft:location_check",
            "predicate": {
                "position": { "y": { "min": int(y) } },
                "biomes": biomes,
            },
        } for y, biomes in dict(sorted(groups.items())).items()],
    })


def make_biome_loot_table(biomes: Sequence[Biome]) -> LootTable:
    """Generate a loot table to retrieve biomes."""
    return minecraft.make_loot_table_binary(biomes, lambda biome: {
            "type": "item",
            "name": "egg",
            "functions": [{
                "function": "set_custom_data",
                "tag": minecraft.render_snbt(biome),
            }],
        }, lambda biomes: [{
            "condition": "minecraft:location_check",
            "predicate": {"biomes": [biome.type[10:] for biome in biomes]},
        }],
    )

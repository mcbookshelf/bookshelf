from collections import defaultdict
from collections.abc import Sequence

from beet import Context, LootTable, Predicate

from bookshelf.definitions import MC_VERSIONS
from bookshelf.models import Biome
from bookshelf.services import minecraft

SNOW_THRESHOLD = 0.4


def beet_default(ctx: Context) -> None:
    """Generate files used by the environment module."""
    namespace = ctx.directory.name
    biomes = minecraft.get_biomes(ctx, MC_VERSIONS[-1])

    loot_table = make_biome_loot_table(biomes)
    ctx.generate(f"{namespace}:biome/get", render=loot_table)

    if predicate := ctx.data.predicates.get(f"{namespace}:can_snow"):
        predicate.data.update(make_can_snow_predicate(biomes).data)
    if predicate := ctx.data.predicates.get(f"{namespace}:has_precipitation"):
        predicate.data.update(make_has_precipitation_predicate(biomes).data)


def make_has_precipitation_predicate(biomes: Sequence[Biome]) -> Predicate:
    """Create a predicate to determine biomes with precipitation."""
    return Predicate({
        "condition": "minecraft:location_check",
        "predicate": {"biomes": [b.type for b in biomes if b.has_precipitation]},
    })


def make_can_snow_predicate(biomes: Sequence[Biome]) -> Predicate:
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

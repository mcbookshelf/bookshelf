from collections import defaultdict
from datetime import datetime, timezone

from beet import Context, LootTable, Predicate
from pydantic import BaseModel

from core.common.helpers import (
    download_and_parse_json,
    gen_loot_table_tree,
    render_snbt,
    with_prefix,
)
from core.definitions import BIOMES_URL, MINECRAFT_VERSIONS

SNOW_THRESHOLD = 0.4

class Biome(BaseModel):
    """Represents a Minecraft biome."""

    type: str
    temperature: float
    has_precipitation: bool


def beet_default(ctx: Context) -> None:
    """Generate files used by the bs.environment module."""
    namespace = ctx.directory.name
    biomes = get_biomes(ctx, version := MINECRAFT_VERSIONS[-1])

    with ctx.override(generate_namespace=namespace):
        ctx.generate("get/get_biome", gen_get_biome_loot_table(biomes))
        ctx.generate("can_snow", gen_can_snow_predicate(biomes, version))
        ctx.generate(
            "has_precipitation",
            gen_has_precipitation_predicate(biomes, version),
        )


def get_biomes(ctx: Context, version: str) -> list[Biome]:
    """Retrieve biomes from the provided version."""
    cache = ctx.cache[f"version/{version}"]
    raw_biomes = download_and_parse_json(cache, BIOMES_URL.format(version))
    if not isinstance(raw_biomes, dict):
        error_msg = f"Expected a dict, but got {type(raw_biomes)}"
        raise TypeError(error_msg)

    return [
        Biome(type=with_prefix(biome), **data)
        for biome, data in raw_biomes.items()
    ]


def gen_get_biome_loot_table(biomes: list[Biome]) -> LootTable:
    """Generate a loot table to retrieve biomes."""
    return LootTable(
        gen_loot_table_tree(biomes, lambda biome: {
            "type": "item",
            "name": "egg",
            "functions": [{"function": "set_custom_data", "tag": render_snbt(biome)}],
        }, lambda biomes: [{
            "condition": "minecraft:location_check",
            "predicate": {"biomes": [biome.type[10:] for biome in biomes]},
        }]),
    )


def gen_can_snow_predicate(biomes: list[Biome], version: str) -> Predicate:
    """Generate a predicate to determine where snow can occur."""
    groups = defaultdict(list)
    for biome in filter(
        lambda b: b.temperature < SNOW_THRESHOLD and b.has_precipitation,
        biomes,
    ):
        # Calculate minimum y-level for snow based on biome temperature
        y = int((biome.temperature - 0.15) / 0.00125 + 80)
        groups[y if y > 0 else -2147483648].append(biome.type)

    return Predicate({
        "__bookshelf__": {
            "feature": True,
            "documentation": "https://docs.mcbookshelf.dev/en/latest/modules/environment.html#can-it-snow",
            "authors": ["Aksiome"],
            "created": {"date": "2024/04/22", "minecraft_version": "1.20.5"},
            "updated": {
                "date": datetime.now(timezone.utc).strftime("%Y/%m/%d"),
                "minecraft_version": version,
            },
        },
        "condition":"minecraft:any_of",
        "terms": [{
            "condition": "minecraft:location_check",
            "predicate": {
                "position": { "y": { "min": y } },
                "biomes": biomes,
            },
        } for y, biomes in dict(sorted(groups.items())).items()],
    })


def gen_has_precipitation_predicate(biomes: list[Biome], version: str) -> Predicate:
    """Generate a predicate to determine biomes with precipitation."""
    return Predicate({
        "__bookshelf__": {
            "feature": True,
            "documentation": "https://docs.mcbookshelf.dev/en/latest/modules/environment.html#can-it-rain-or-snow",
            "authors": ["Aksiome"],
            "created": {"date": "2024/04/22", "minecraft_version": "1.20.5"},
            "updated": {
                "date": datetime.now(timezone.utc).strftime("%Y/%m/%d"),
                "minecraft_version": version,
            },
        },
        "condition": "minecraft:location_check",
        "predicate": {"biomes": [b.type for b in biomes if b.has_precipitation]},
    })

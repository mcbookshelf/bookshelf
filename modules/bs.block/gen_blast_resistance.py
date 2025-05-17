from collections import defaultdict

from beet import Context, LootTable

from bookshelf.definitions import MC_VERSIONS
from bookshelf.helpers import (
    download_and_parse_json,
    gen_loot_table_tree,
    render_snbt,
)

DATA_META = "https://raw.githubusercontent.com/mcbookshelf/mcdata/refs/tags/{}/blocks/data.min.json"


def beet_default(ctx: Context) -> None:
    """Generate files used by the bs.block module."""
    namespace = ctx.directory.name
    entries = get_blast_resistances(ctx, MC_VERSIONS[-1])

    with ctx.override(generate_namespace=namespace):
        ctx.generate(
            "get/get_blast_resistance",
            gen_get_blast_resistance_loot_table(entries),
        )


def get_blast_resistances(ctx: Context, version: str) -> list[tuple[str, list[str]]]:
    """Retrieve block blast resistances for the given version."""
    cache = ctx.cache[f"version/{version}"]
    blocks = download_and_parse_json(cache, DATA_META.format(version))
    entries = defaultdict(list)
    for block, data in blocks.items():
        entries[data["blast_resistance"]].append(block)
    return list(entries.items())


def gen_get_blast_resistance_loot_table(entries: list) -> LootTable:
    """Generate a loot table to retrieve blast resistance."""
    return LootTable(
        gen_loot_table_tree(entries, lambda entry: {
            "type": "item",
            "name": "egg",
            "functions": [{
                "function": "set_custom_data",
                "tag": render_snbt({
                    "blast_resistance": entry[0],
                }),
            }],
        }, lambda entries: [{
            "condition": "location_check",
            "predicate": {"block": {"blocks": list({
                item for sublist
                in [b[10:] for _, b in entries]
                for item in sublist
            })}},
        }]),
    )

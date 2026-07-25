from __future__ import annotations

import re
from collections.abc import Callable, Mapping, Sequence
from functools import singledispatch, wraps
from typing import TYPE_CHECKING

import orjson
from beet import BlockTag, Context, JsonFileBase, LootTable, PackFile
from pydantic import BaseModel

from bookshelf.common import json
from bookshelf.definitions import MC_VERSIONS
from bookshelf.models import Block, StateNode, StatePredicate
from bookshelf.plugins.update_mcmeta import get_supported_formats

if TYPE_CHECKING:
    from collections.abc import Iterable

    from beet import ProjectCache


def quote_snbt_key(k: str) -> str:
    """Quote keys that contain colons or non-alphanumeric characters."""
    return f'"{k}"' if ":" in k or not re.fullmatch(r"[A-Za-z0-9]+", k) else k


@singledispatch
def render_snbt(obj: object) -> str:
    """Render any Python object as SNBT."""
    return str(obj)


@render_snbt.register
def render_snbt_model(obj: BaseModel) -> str:
    """Render a Pydantic BaseModel as SNBT."""
    return render_snbt(obj.model_dump())


@render_snbt.register
def render_snbt_float(obj: float) -> str:
    """Render a float as SNBT."""
    return f"{obj}d"


@render_snbt.register
def render_snbt_int(obj: int) -> str:
    """Render an int as SNBT."""
    return f"{obj}"


@render_snbt.register
def render_snbt_str(obj: str) -> str:
    """Render a string as SNBT."""
    return f'"{obj}"'


@render_snbt.register
def render_snbt_bool(obj: bool) -> str: # noqa: FBT001
    """Render a boolean as SNBT."""
    return "1b" if obj else "0b"


@render_snbt.register
def render_snbt_sequence(obj: Sequence) -> str:
    """Render a Sequence as SNBT."""
    return f'[{",".join(render_snbt(v) for v in obj)}]'


@render_snbt.register
def render_snbt_mapping(obj: Mapping) -> str:
    """Render a Mapping as SNBT."""
    pairs = ((str(k), v) for k, v in obj.items() if v is not None)
    return f"{{{','.join([
        f"{quote_snbt_key(k)}:{render_snbt(v)}"
        for k, v in sorted(pairs, key=lambda x: x[0])
    ])}}}"


def cache_version[T: BaseModel | dict | list](
    key: str,
    expected_type: type[T],
) -> Callable[[Callable[[str], T]], Callable[[ProjectCache, str], T]]:
    """Cache functions that accept a version to a JSON file."""
    def decorator(func: Callable[[str], T]) -> Callable[[ProjectCache, str], T]:
        @wraps(func)
        def wrapper(cache: ProjectCache, version: str) -> T:
            file = cache[f"version/{version}"].get_path(key).with_suffix(".json")
            if file.is_file():
                return json.load(file, expected_type)
            json.dump(file, result := func(version), None)
            return result
        return wrapper
    return decorator


def generator(
    func: Callable[[Context, str], Iterable[tuple[str, PackFile]]],
) -> Callable[[Context], None]:
    """Wrap a beet generator with overlay/compatibility logic."""
    def decorator(ctx: Context) -> None:
        seen = {}
        for version in reversed(ctx.meta.get("versions", MC_VERSIONS[-1:])):
            for location, file in func(ctx, version):
                if isinstance(file, JsonFileBase):
                    file.encoder = lambda obj: orjson.dumps(obj).decode()
                    file.decoder = lambda obj: orjson.loads(obj.encode())
                if location not in seen:
                    seen[location] = file.ensure_serialized()
                    ctx.data[location] = file
                elif seen[location] != file.ensure_serialized():
                    seen[location] = file.ensure_serialized()
                    overlay = ctx.data.overlays[version]
                    min_formats = get_supported_formats(ctx, MC_VERSIONS[0])
                    max_formats = get_supported_formats(ctx, version)
                    overlay.max_format = max_formats["data"]
                    overlay.min_format = min_formats["data"]
                    overlay[location] = file
    return decorator


def make_block_tag(
    base: BlockTag,
    blocks: Sequence[Block],
    predicate: Callable[[Block], bool],
) -> BlockTag:
    """Create or update a block tag for blocks that match the predicate."""
    values = sorted(block.type for block in blocks if predicate(block))
    return BlockTag({**base.data, "values": values})


def make_loot_table_binary[T](
    entries: Sequence[T],
    entry_factory: Callable[[T], dict],
    conditions_factory: Callable[[Sequence[T]], list],
) -> LootTable:
    """Build a binary loot table tree from a sequence of entries."""
    def build_node(entries: Sequence[T]) -> dict:
        if len(entries) == 1:
            return entry_factory(entries[0])

        mid = len(entries) // 2
        left = build_node(entries[:mid])
        right = build_node(entries[mid:])

        left["conditions"] = conditions_factory(entries[:mid])
        right["conditions"] = conditions_factory(entries[mid:])

        left_size = len(orjson.dumps(left["conditions"]))
        right_size = len(orjson.dumps(right["conditions"]))
        if left_size > right_size:
            left, right = right, left

        right.pop("conditions")
        return {"type":"alternatives","children":[left, right]}

    return LootTable({"pools":[{"rolls":1,"entries":[build_node(entries)]}]})


def make_loot_table_state[T](
    entry: StatePredicate[T],
    entry_factory: Callable[[T], dict],
    conditions_factory: Callable[[str, str], list] = lambda name, value: [{
        "condition": "location_check",
        "predicate": {"block": {"state": {name: value}}},
    }],
) -> LootTable:
    """Build a state loot table tree from a node entry."""
    def build_node(node: StateNode[T] | T) -> dict:
        if not isinstance(node, StateNode):
            return entry_factory(node)

        children = []
        branches = tuple(node.children.items())
        for value, child in branches[:-1]:
            entry = build_node(child)
            entry["conditions"] = conditions_factory(node.name, value)
            children.append(entry)
        children.append(build_node(branches[-1][1]))

        return {"type":"alternatives","children":children}

    return LootTable({"pools":[{"rolls":1,"entries":[build_node(entry.tree)]}]})

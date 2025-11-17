from __future__ import annotations

import re
from collections.abc import Callable, Mapping, Sequence
from functools import singledispatch, wraps
from itertools import chain
from typing import TYPE_CHECKING

import orjson
from beet import BlockTag, LootTable
from pydantic import BaseModel

from bookshelf.common import json
from bookshelf.models import Block, StateNode, StatePredicate

if TYPE_CHECKING:
    from beet import Context


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
) -> Callable[[Callable[[Context, str], T]], Callable[[Context, str], T]]:
    """Cache functions that accept a ctx and a version to a JSON file."""
    def decorator(func: Callable[[Context, str], T]) -> Callable[[Context, str], T]:
        @wraps(func)
        def wrapper(ctx: Context, version: str) -> T:
            file = ctx.cache[f"version/{version}"].get_path(key).with_suffix(".json")
            if file.is_file():
                return json.load(file, expected_type)
            json.dump(file, result := func(ctx, version), None)
            return result
        return wrapper
    return decorator


def make_block_tag(
    blocks: Sequence[Block],
    predicate: Callable[[Block], bool],
    extras: list | None = None,
) -> BlockTag:
    """Create a block tag for blocks that match the predicate."""
    values = chain(extras or [], (block.type for block in blocks if predicate(block)))
    return BlockTag({"replace":True,"values":sorted(values)})


def make_loot_table(content: dict) -> LootTable:
    """Build an optimized loot table from a dict using orjson."""
    loot_table = LootTable(content)
    loot_table.text = orjson.dumps(loot_table.data).decode("utf-8")
    return loot_table


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

    return make_loot_table({"pools":[{"rolls":1,"entries":[build_node(entries)]}]})


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

    return make_loot_table({"pools":[{"rolls":1,"entries":[build_node(entry.tree)]}]})

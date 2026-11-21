from collections.abc import Callable, Iterable
from typing import Self

import orjson

type Json = dict[str, Json] | list[Json] | str | float | bool | None
type Node = dict[str, Json] | str

# The checks whose predicate object merges with another on the same entity or at the same offset
MERGEABLE = frozenset({"entity_properties", "location_check"})
# The lists that mean "one of": two checks keep their intersection, either keeps their union
ONE_OF = frozenset({"entity_type", "blocks", "fluids", "gamemode"})


class Condition:
    """A condition of predicates and number providers. Combine with ``&``, ``|`` and ``~``."""

    __slots__ = ("node",)

    def __init__(self, node: Node) -> None:
        self.node: Node = node

    def __and__(self, other: Self) -> Condition:
        return all_of(self, other)

    def __or__(self, other: Self) -> Condition:
        return any_of(self, other)

    def __invert__(self) -> Condition:
        return inverted(self)

    def json(self) -> str:
        return orjson.dumps(self.node).decode()


def all_of(*conditions: Condition) -> Condition:
    """All of the conditions, flattened, with the checks they share merged into one."""
    return _combine("all_of", conditions, _intersect)


def any_of(*conditions: Condition) -> Condition:
    """Any of the conditions, flattened, with the checks told apart by one list merged."""
    return _combine("any_of", conditions, _unite)


def inverted(condition: Condition) -> Condition:
    node = condition.node
    if isinstance(node, dict) and node.get("type") == "inverted":
        term = node.get("term")
        if isinstance(term, dict | str):
            return Condition(term)
    return Condition({"type": "inverted", "term": node})


def _combine(
    kind: str,
    conditions: Iterable[Condition],
    merge: Callable[[dict[str, Json], dict[str, Json]], dict[str, Json] | None],
) -> Condition:
    terms = []
    for condition in conditions:
        node = condition.node
        nested = node.get("terms") if isinstance(node, dict) and node.get("type") == kind else None
        for term in nested if isinstance(nested, list) else [node]:
            if isinstance(term, dict | str):
                _add(terms, term, merge)
    if len(terms) == 1:
        return Condition(terms[0])
    return Condition({"type": kind, "terms": list[Json](terms)})


def _add(
    terms: list[Node],
    term: Node,
    merge: Callable[[dict[str, Json], dict[str, Json]], dict[str, Json] | None],
) -> None:
    """Add a term, merged into the first one it merges with."""
    for index, other in enumerate(terms):
        if other == term:
            return
        merged = _merge_checks(other, term, merge)
        if merged is not None:
            terms[index] = merged
            return
    terms.append(term)


def _merge_checks(
    a: Node,
    b: Node,
    merge: Callable[[dict[str, Json], dict[str, Json]], dict[str, Json] | None],
) -> Node | None:
    """Two checks as one: of the same kind, on the same entity or at the same offset."""
    if not isinstance(a, dict) or not isinstance(b, dict) or a.get("type") not in MERGEABLE:
        return None
    if _without_predicate(a) != _without_predicate(b):
        return None
    pa, pb = a.get("predicate"), b.get("predicate")
    if not isinstance(pa, dict) or not isinstance(pb, dict):
        return None
    merged = merge(pa, pb)
    return None if merged is None else {**a, "predicate": merged}


def _without_predicate(node: dict[str, Json]) -> dict[str, Json]:
    return {key: value for key, value in node.items() if key != "predicate"}


def _intersect(a: dict[str, Json], b: dict[str, Json]) -> dict[str, Json] | None:
    """What both objects require, or None when they clash."""
    out = dict(a)
    for key, value in b.items():
        if key not in out or out[key] == value:
            out[key] = value
            continue
        current = out[key]
        if isinstance(current, dict) and isinstance(value, dict):
            nested = _intersect(current, value)
            if nested is None:
                return None
            out[key] = nested
        elif key in ONE_OF and isinstance(current, list) and isinstance(value, list):
            out[key] = [item for item in current if item in value]
        else:
            return None
    return out


def _unite(a: dict[str, Json], b: dict[str, Json]) -> dict[str, Json] | None:
    """What either object allows, when they differ by one "one of" list only."""
    if a.keys() != b.keys():
        return None
    differ = [key for key in a if a[key] != b[key]]
    if len(differ) != 1:
        return None
    key = differ[0]
    first, second = a[key], b[key]
    if isinstance(first, dict) and isinstance(second, dict):
        nested = _unite(first, second)
        return None if nested is None else {**a, key: nested}
    if key in ONE_OF and isinstance(first, list) and isinstance(second, list):
        items = [*first, *second]
        if all(isinstance(item, str) for item in items):
            return {**a, key: list[Json](sorted({str(item) for item in items}))}
    return None


def block(blocks: Iterable[str]) -> Condition:
    return location({"block": {"blocks": [*sorted(b.removeprefix("minecraft:") for b in blocks)]}})


def block_state(name: str, value: str) -> Condition:
    return location({"block": {"state": {name: value}}})


def block_state_range(name: str, minimum: str = "", maximum: str = "") -> Condition:
    bounds = {"min": minimum, "max": maximum}
    return location({"block": {"state": {name: {k: v for k, v in bounds.items() if v}}}})


def component(name: str, value: Json) -> Condition:
    return entity({"components": {name: value}})


def cube_size(maximum: int) -> Condition:
    return entity({"type_specific/cube_mob": {"size": {"max": maximum}}})


def entity_type(types: Iterable[str]) -> Condition:
    return entity({"entity_type": [*sorted(t.removeprefix("minecraft:") for t in types)]})


def flag(name: str, *, value: bool = True) -> Condition:
    return entity({"flags": {name: value}})


def gamemode(*modes: str) -> Condition:
    return entity({"type_specific/player": {"gamemode": [*modes]}})


def nbt(value: str) -> Condition:
    return entity({"nbt": value})


def location(predicate: dict[str, Json], *, x: int = 0, y: int = 0, z: int = 0) -> Condition:
    offsets = {"offsetX": x, "offsetY": y, "offsetZ": z}
    node = {"type": "location_check", "predicate": predicate}
    return Condition(node | {key: offset for key, offset in offsets.items() if offset})


def entity(predicate: dict[str, Json]) -> Condition:
    return Condition({
        "type": "entity_properties",
        "entity": "this",
        "predicate": predicate,
    })

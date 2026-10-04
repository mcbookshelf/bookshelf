import math
from typing import TYPE_CHECKING, Literal, cast

import orjson

from mcbookshelf.minecraft.condition import Condition, Json

if TYPE_CHECKING:
    from collections.abc import Callable, Iterable, Mapping, Sequence

type Kind = Literal["int", "float"]
type Node = dict[str, Json] | str | float
type Operand = Expression | float | str
type Target = dict[str, Json]


class Expression:

    __slots__ = ("kind", "node")

    def __init__(self, node: Node, kind: Kind = "float") -> None:
        self.node: Node = node
        self.kind: Kind = kind

    def json(self) -> str:
        return orjson.dumps(self.node).decode()

    def __repr__(self) -> str:
        return f"Expression<{self.kind}>({self.json()})"

    def __add__(self, other: Operand) -> Expression:
        return _nary("add", self, other)

    def __radd__(self, other: Operand) -> Expression:
        return _nary("add", other, self)

    def __mul__(self, other: Operand) -> Expression:
        return _nary("mul", self, other)

    def __rmul__(self, other: Operand) -> Expression:
        return _nary("mul", other, self)

    def __sub__(self, other: Operand) -> Expression:
        return _binary("sub", self, other)

    def __rsub__(self, other: Operand) -> Expression:
        return _binary("sub", other, self)

    def __truediv__(self, other: Operand) -> Expression:
        return _binary("div", self, other)

    def __rtruediv__(self, other: Operand) -> Expression:
        return _binary("div", other, self)

    def __floordiv__(self, other: Operand) -> Expression:
        return _binary("floor_div", self, other)

    def __mod__(self, other: Operand) -> Expression:
        return _binary("mod", self, other)

    def __pow__(self, other: Operand) -> Expression:
        return _fields("pow", self.kind, base=self, exponent=other)

    def __rpow__(self, other: Operand) -> Expression:
        return _fields("pow", self.kind, base=other, exponent=self)

    def __neg__(self) -> Expression:
        """Negate: a number folds, and a conditional negates its branches instead."""
        node = self.node
        if isinstance(node, int | float) and not isinstance(node, bool):
            return Expression(-node, self.kind)
        if isinstance(node, dict) and node.get("type") == "conditional":
            branches = {
                key: (-Expression(cast("Node", node[key]), self.kind)).node
                for key in ("on_true", "on_false")
                if key in node
            }
            return Expression({**node, **branches}, self.kind)
        return _fields("negate", self.kind, input=self)

    def __abs__(self) -> Expression:
        return _fields("abs", self.kind, input=self)

    def floor_mod(self, other: Operand) -> Expression:
        return _binary("floor_mod", self, other)

    def floor(self) -> Expression:
        return _fields("floor", "float", input=self)

    def ceil(self) -> Expression:
        return _fields("ceil", "float", input=self)

    def round(self) -> Expression:
        return _fields("round", "float", input=self)

    def truncate(self) -> Expression:
        return _fields("truncate", "float", input=self)

    def sin(self) -> Expression:
        return _fields("sin", "float", input=self)

    def cos(self) -> Expression:
        return _fields("cos", "float", input=self)

    def sqrt(self) -> Expression:
        return _fields("sqrt", "float", input=self)

    def to_int(self) -> Expression:
        return _fields("from_float", "int", input=self)

    def to_float(self) -> Expression:
        return _fields("from_int", "float", input=self)

    def eq(self, value: Operand) -> Condition:
        return self._check(_lit(value, self.kind))

    def between(self, low: Operand, high: Operand) -> Condition:
        return self._check({"min": _lit(low, self.kind), "max": _lit(high, self.kind)})

    def ge(self, value: Operand) -> Condition:
        return self._check({"min": _lit(value, self.kind)})

    def le(self, value: Operand) -> Condition:
        return self._check({"max": _lit(value, self.kind)})

    def _check(self, value_range: Node) -> Condition:
        condition = "int_value_check" if self.kind == "int" else "float_value_check"
        return Condition(
            {"type": condition, "value": self.node, "test": value_range},
        )


def _lit(value: Operand, kind: Kind) -> Node:
    if isinstance(value, Expression):
        return value.node
    if isinstance(value, str):
        return value
    if isinstance(value, bool):
        msg = "bool is not a number provider value"
        raise TypeError(msg)
    if kind == "float":
        return float(value)
    if isinstance(value, float) and not value.is_integer():
        msg = f"{value!r} is not a whole number, this is an int expression"
        raise TypeError(msg)
    return int(value)


def _kind_of(*operands: Operand | None) -> Kind:
    for operand in operands:
        if isinstance(operand, Expression):
            return operand.kind
    for operand in operands:
        if isinstance(operand, float):
            return "float"
    return "int"


def _fields(op: str, kind: Kind, **fields: Operand) -> Expression:
    node: dict[str, Json] = {"type": op}
    for name, value in fields.items():
        node[name] = _lit(value, kind)
    return Expression(node, kind)


def _binary(op: str, left: Operand, right: Operand) -> Expression:
    return _fields(op, _kind_of(left, right), left=left, right=right)


def _nary(op: str, *operands: Operand) -> Expression:
    kind = _kind_of(*operands)
    inputs: list[Json] = []
    literals: list[float] = []
    for operand in operands:
        for item in _flattened(op, operand, kind):
            if isinstance(item, int | float) and not isinstance(item, bool):
                literals.append(item)
            else:
                inputs.append(item)
    if literals:
        folded = sum(literals) if op == "add" else math.prod(literals)
        identity = 0 if op == "add" else 1
        if folded != identity or not inputs:
            inputs.insert(0, _lit(folded, kind))
    if len(inputs) == 1:
        return Expression(cast("Node", inputs[0]), kind)
    return Expression({"type": op, "inputs": inputs}, kind)


def _flattened(op: str, operand: Operand, kind: Kind) -> list[Json]:
    nested = operand.node if isinstance(operand, Expression) else None
    if isinstance(nested, dict) and nested.get("type") == op and isinstance(nested["inputs"], list):
        return nested["inputs"]
    return [operand if isinstance(operand, int | float) else _lit(operand, kind)]


def _inputs(op: str, kind: Kind, operands: Sequence[Operand]) -> Expression:
    return Expression({"type": op, "inputs": [_lit(x, kind) for x in operands]}, kind)


def const(value: float) -> Expression:
    kind: Kind = "float" if isinstance(value, float) else "int"
    return Expression(_lit(value, kind), kind)


def ref(provider_id: str, kind: Kind = "float") -> Expression:
    return Expression(provider_id, kind)


def float_storage(storage_id: str, path: str, fallback: Operand | None = None) -> Expression:
    return _storage("float", storage_id, path, fallback)


def int_storage(storage_id: str, path: str, fallback: Operand | None = None) -> Expression:
    return _storage("int", storage_id, path, fallback)


def _storage(kind: Kind, storage_id: str, path: str, fallback: Operand | None) -> Expression:
    node: dict[str, Json] = {"type": "storage", "storage": storage_id, "path": path}
    if fallback is not None:
        node["fallback"] = _lit(fallback, kind)
    return Expression(node, kind)


def score(
    objective: str,
    target: Target,
    fallback: Operand | None = None,
) -> Expression:
    node: dict[str, Json] = {"type": "score", "score": objective, "target": target}
    if fallback is not None:
        node["fallback"] = _lit(fallback, "int")
    return Expression(node, "int")


def fixed_target(name: str) -> Target:
    """Score holder by name, e.g. ``fixed("#x")``."""
    return {"type": "fixed", "name": name}


def context_target(target: str = "this") -> Target:
    """Score holder taken from the evaluation context, e.g. ``target_entity``."""
    return {"type": "context", "target": target}


def uniform(low: Operand, high: Operand) -> Expression:
    """Random value in the closed range ``[low, high]``."""
    return _fields("uniform", _kind_of(low, high), min=low, max=high)


def binomial(n: Operand, p: Operand) -> Expression:
    """Get number of successes out of ``n`` coin flips with probability ``p``."""
    node: dict[str, Json] = {
        "type": "binomial",
        "n": _lit(n, "int"),
        "p": _lit(p, "float"),
    }
    return Expression(node, "int")


def environment_attribute(attribute: str, kind: Kind = "float") -> Expression:
    return Expression({"type": "environment_attribute", "attribute": attribute}, kind)


def weighted(*entries: tuple[Operand, int], kind: Kind | None = None) -> Expression:
    """Pick from ``(provider, weight)`` pairs, e.g. ``weighted((1, 3), (2, 1))``."""
    kind = kind or _kind_of(*(value for value, _ in entries))
    distribution: list[Json] = [
        {"data": _lit(value, kind), "weight": weight} for value, weight in entries
    ]
    return Expression({"type": "weighted_list", "distribution": distribution}, kind)


def add(*operands: Operand) -> Expression:
    return _nary("add", *operands)


def mul(*operands: Operand) -> Expression:
    return _nary("mul", *operands)


def min_(*operands: Operand) -> Expression:
    return _inputs("min", _kind_of(*operands), operands)


def max_(*operands: Operand) -> Expression:
    return _inputs("max", _kind_of(*operands), operands)


def avg(*operands: Operand) -> Expression:
    return _inputs("avg", _kind_of(*operands), operands)


def length(*operands: Operand) -> Expression:
    return _inputs("length", "float", operands)


def clamp(value: Operand, low: Operand, high: Operand) -> Expression:
    return min_(max_(value, low), high)


def cond(
    condition: Condition,
    on_true: Operand,
    on_false: Operand | None = None,
) -> Expression:
    kind = _kind_of(on_true, on_false)
    node: dict[str, Json] = {
        "type": "conditional",
        "condition": condition.node,
        "on_true": _lit(on_true, kind),
    }
    if on_false is not None:
        node["on_false"] = _lit(on_false, kind)
    return Expression(node, kind)


def first(*cases: tuple[Condition, Operand], default: Operand) -> Expression:
    """The value of the first case whose condition passes, in nested conditionals."""
    value = default if isinstance(default, Expression) else Expression(default, _kind_of(default))
    for condition, on_true in reversed(cases):
        value = cond(condition, on_true, value)
    return value


def dispatch(
    *cases: tuple[Condition, Operand],
    default: Operand | None = None,
) -> Expression:
    """First-match dispatcher over ``(condition, provider)`` pairs."""
    kind = _kind_of(*(value for _, value in cases), default)
    node: dict[str, Json] = {
        "type": "number_dispatcher",
        "cases": [
            {"condition": condition.node, "value": _lit(value, kind)}
            for condition, value in cases
        ],
    }
    if default is not None:
        node["default"] = _lit(default, kind)
    return Expression(node, kind)


def switch[K: (int, float)](
    key: Expression,
    table: Mapping[K, Operand],
    default: Operand | None = None,
) -> Expression:
    """Dispatcher on ``key == value`` for each table entry, in insertion order."""
    return dispatch(
        *((key.eq(value), provider) for value, provider in table.items()),
        default=default,
    )


def btree[T](
    items: Iterable[T],
    value: Callable[[T], Expression],
    test: Callable[[list[T]], Condition],
    weight: Callable[[T], float] | None = None,
) -> Expression:
    """Pick the value of each item in a binary tree, in log2(n) tests."""
    leaves: dict[str, tuple[Expression, list[T]]] = {}
    problems = []
    for item in items:
        try:
            found = value(item)
        except ValueError as error:
            problems.append(f"{getattr(item, 'id', item)}: {error}")
            continue
        leaves.setdefault(found.json(), (found, []))[1].append(item)
    if problems:
        listed = "\n".join(f"  {problem}" for problem in sorted(problems))
        raise ValueError(f"no value for:\n{listed}")
    leaf_weight = None if weight is None else lambda leaf: sum(map(weight, leaf[1]))
    return _tree(list(leaves.values()), test, leaf_weight)


def _tree[T](
    leaves: list[tuple[Expression, list[T]]],
    test: Callable[[list[T]], Condition],
    weight: Callable[[tuple[Expression, list[T]]], float] | None,
) -> Expression:
    if len(leaves) == 1:
        return leaves[0][0]
    mid = len(leaves) // 2 if weight is None else _balance(leaves, weight)
    first, second = leaves[:mid], leaves[mid:]
    return cond(
        test([item for _, found in first for item in found]),
        _tree(first, test, weight),
        _tree(second, test, weight),
    )


def _balance[T](entries: Sequence[T], weight: Callable[[T], float]) -> int:
    """The split whose two sides weigh the closest, keeping both sides filled."""
    total = sum(map(weight, entries))
    best, best_gap, before = 1, math.inf, 0.0
    for index, entry in enumerate(entries[:-1], 1):
        before += weight(entry)
        if (gap := abs(total - 2 * before)) < best_gap:
            best, best_gap = index, gap
    return best


__all__ = [
    "Expression",
    "Json",
    "Kind",
    "Node",
    "Operand",
    "Target",
    "add",
    "avg",
    "binomial",
    "btree",
    "clamp",
    "cond",
    "const",
    "context_target",
    "dispatch",
    "environment_attribute",
    "first",
    "fixed_target",
    "float_storage",
    "int_storage",
    "length",
    "max_",
    "min_",
    "mul",
    "ref",
    "score",
    "switch",
    "uniform",
    "weighted",
]

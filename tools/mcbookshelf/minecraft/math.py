import json
import math
from typing import TYPE_CHECKING, Literal, Self

if TYPE_CHECKING:
    from collections.abc import Mapping, Sequence

type Kind = Literal["int", "float"]
type Json = dict[str, Json] | list[Json] | str | float | bool | None
type Node = dict[str, Json] | str | float
type Operand = Expression | float | str
type Target = dict[str, Json]


class Expression:

    __slots__ = ("kind", "node", "op")
    __hash__ = None

    def __init__(self, node: Node, kind: Kind = "float", op: str | None = None) -> None:
        self.node: Node = node
        self.kind: Kind = kind
        self.op: str | None = op

    def json(self, indent: int = 2) -> str:
        return json.dumps(self.node, indent=indent)

    def inline(self) -> str:
        return json.dumps(self.node, separators=(",", ":"))

    def __repr__(self) -> str:
        return f"Expression<{self.kind}>({self.inline()})"

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

    def eq(self, value: Operand) -> Predicate:
        return self._check(_lit(value, self.kind))

    def between(self, low: Operand, high: Operand) -> Predicate:
        return self._check({"min": _lit(low, self.kind), "max": _lit(high, self.kind)})

    def ge(self, value: Operand) -> Predicate:
        return self._check({"min": _lit(value, self.kind)})

    def le(self, value: Operand) -> Predicate:
        return self._check({"max": _lit(value, self.kind)})

    def __eq__(self, other: object) -> Predicate:  # ty: ignore[invalid-method-override]
        return self.eq(_operand(other))

    def __ge__(self, other: Operand) -> Predicate:
        return self.ge(other)

    def __le__(self, other: Operand) -> Predicate:
        return self.le(other)

    def _check(self, value_range: Node) -> Predicate:
        condition = "int_value_check" if self.kind == "int" else "float_value_check"
        return Predicate(
            {"type": condition, "value": self.node, "test": value_range},
        )


class Predicate:
    """A loot-table style predicate. Combine with ``&``, ``|`` and ``~``."""

    __slots__ = ("node",)

    def __init__(self, node: dict[str, Json] | str) -> None:
        self.node: dict[str, Json] | str = node

    def __and__(self, other: Self) -> Predicate:
        return Predicate({"type": "all_of", "terms": [self.node, other.node]})

    def __or__(self, other: Self) -> Predicate:
        return Predicate({"type": "any_of", "terms": [self.node, other.node]})

    def __invert__(self) -> Predicate:
        return Predicate({"type": "inverted", "term": self.node})

    def json(self, indent: int = 2) -> str:
        return json.dumps(self.node, indent=indent)

    def inline(self) -> str:
        return json.dumps(self.node, separators=(",", ":"))


def _operand(value: object) -> Operand:
    if isinstance(value, Expression | str) or (
        isinstance(value, int | float) and not isinstance(value, bool)
    ):
        return value
    msg = f"cannot use {value!r} as a number provider"
    raise TypeError(msg)


def _lit(value: Operand, kind: Kind) -> Node:
    if isinstance(value, Expression):
        return value.node
    if isinstance(value, str):
        return value
    if isinstance(value, bool):
        msg = "bool is not a number provider value"
        raise TypeError(msg)
    return float(value) if kind == "float" else int(value)


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
    return Expression(node, kind, op)


def _fold(op: str, left: float, right: float, kind: Kind) -> Expression:
    if op == "sub":
        result = left - right
    elif op == "div":
        result = left / right if kind == "float" else int(left / right)
    elif op == "floor_div":
        result = left // right
    elif op == "mod":
        result = left - right * int(left / right)
    else:
        result = left % right
    return const(float(result) if kind == "float" else int(result))


def _binary(op: str, left: Operand, right: Operand) -> Expression:
    kind = _kind_of(left, right)
    if isinstance(left, int | float) and isinstance(right, int | float):
        return _fold(op, left, right, kind)
    return _fields(op, kind, left=left, right=right)


def _nary(op: str, *operands: Operand) -> Expression:
    kind = _kind_of(*operands)
    inputs: list[Json] = []
    literals: list[float] = []
    for operand in operands:
        if isinstance(operand, Expression) and operand.op == op:
            nested = operand.node
            if isinstance(nested, dict) and isinstance(nested["inputs"], list):
                for item in nested["inputs"]:
                    if isinstance(item, int | float) and not isinstance(item, bool):
                        literals.append(item)
                    else:
                        inputs.append(item)
        elif isinstance(operand, int | float):
            literals.append(operand)
        else:
            inputs.append(_lit(operand, kind))
    if literals:
        folded = sum(literals) if op == "add" else math.prod(literals)
        identity = 0 if op == "add" else 1
        if folded != identity or not inputs:
            inputs.insert(0, _lit(folded, kind))
    if len(inputs) == 1 and isinstance(inputs[0], int | float):
        return const(inputs[0])
    return Expression({"type": op, "inputs": inputs}, kind, op)


def _inputs(op: str, kind: Kind, operands: Sequence[Operand]) -> Expression:
    return Expression({"type": op, "inputs": [_lit(x, kind) for x in operands]}, kind, op)


def const(value: float) -> Expression:
    kind: Kind = "float" if isinstance(value, float) else "int"
    return Expression(_lit(value, kind), kind, "const")


def ref(provider_id: str, kind: Kind = "float") -> Expression:
    return Expression(provider_id, kind, "ref")


def float_storage(storage_id: str, path: str, fallback: Operand | None = None) -> Expression:
    node: dict[str, Json] = {"type": "storage", "storage": storage_id, "path": path}
    if fallback is not None:
        node["fallback"] = _lit(fallback, "float")
    return Expression(node, "float", "storage")


def int_storage(storage_id: str, path: str, fallback: Operand | None = None) -> Expression:
    node: dict[str, Json] = {"type": "storage", "storage": storage_id, "path": path}
    if fallback is not None:
        node["fallback"] = _lit(fallback, "int")
    return Expression(node, "int", "storage")


def score(
    objective: str,
    target: Target,
    fallback: Operand | None = None,
) -> Expression:
    node: dict[str, Json] = {"type": "score", "score": objective, "target": target}
    if fallback is not None:
        node["fallback"] = _lit(fallback, "int")
    return Expression(node, "int", "score")


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
    return Expression(node, "int", "binomial")


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


def lerp(a: Operand, b: Operand, t: Operand) -> Expression:
    return add(a, mul(t, _binary("sub", b, a)))


def clamp(value: Operand, low: Operand, high: Operand) -> Expression:
    return min_(max_(value, low), high)


def cond(
    predicate: Predicate,
    on_true: Operand,
    on_false: Operand | None = None,
) -> Expression:
    kind = _kind_of(on_true, on_false)
    node: dict[str, Json] = {
        "type": "conditional",
        "condition": predicate.node,
        "on_true": _lit(on_true, kind),
    }
    if on_false is not None:
        node["on_false"] = _lit(on_false, kind)
    return Expression(node, kind, "conditional")


def dispatch(
    *cases: tuple[Predicate, Operand],
    default: Operand | None = None,
) -> Expression:
    """First-match dispatcher over ``(predicate, provider)`` pairs."""
    kind = _kind_of(*(value for _, value in cases), default)
    node: dict[str, Json] = {
        "type": "number_dispatcher",
        "cases": [
            {"condition": predicate.node, "value": _lit(value, kind)}
            for predicate, value in cases
        ],
    }
    if default is not None:
        node["default"] = _lit(default, kind)
    return Expression(node, kind, "dispatch")


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


def btree(
    key: Expression,
    pieces: Sequence[tuple[float, Operand]],
    last: Operand,
) -> Expression:
    """`key <= b0 -> e0`, `key <= b1 -> e1`, ..., else `last`, in log2(n) tests."""
    if not pieces:
        return last if isinstance(last, Expression) else _as_expression(last)
    mid = len(pieces) // 2
    bound, provider = pieces[mid]
    left = btree(key, pieces[:mid], provider)
    right = btree(key, pieces[mid + 1 :], last)
    return cond(key.le(bound), left, right)


def _as_expression(value: float | str) -> Expression:
    return ref(value) if isinstance(value, str) else const(value)


__all__ = [
    "Expression",
    "Json",
    "Kind",
    "Node",
    "Operand",
    "Predicate",
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
    "fixed_target",
    "float_storage",
    "int_storage",
    "length",
    "lerp",
    "max_",
    "min_",
    "mul",
    "ref",
    "score",
    "switch",
    "uniform",
    "weighted",
]

"""Tiny Python DSL for Minecraft 26.3+ number providers.

Write providers as ordinary Python expressions and serialize them with
``.node`` (plain JSON data) or ``.inline()`` (compact string for commands).

    e = storage("bs.animation:", "_.e")
    d = storage("bs.animation:", "_.d[0]")
    t = e / d
    x = p0 + 3 * (1 - t) * t * ((1 - t) * (p1 - p0) + t * (p2 - p0)) + t**3 * (p3 - p0)
    x.inline()  # -> {"type":"add",...}

Kinds: every Expression carries kind "float" or "int". Python int literals are
int, float literals are float, storage() is float (use istorage() for int),
score() is int. Arithmetic keeps the kind of its first typed operand and
coerces bare literals to it. Use .to_int() / .to_float() to cross over.
Comparisons (==, >=, <=, .between) build value-check predicates whose type
follows the kind of the expression.
"""

from __future__ import annotations

import json
import math
from typing import TYPE_CHECKING, Literal, Self

if TYPE_CHECKING:
    from collections.abc import Mapping, Sequence

type Kind = Literal["int", "float"]
type Json = dict[str, Json] | list[Json] | str | float | bool | None
type Node = dict[str, Json] | str | float
"""A provider node: an inline object, a registry ID, or a bare number."""
type Operand = Expression | float | str
"""Anything accepted where a provider is expected."""
type Target = dict[str, Json]
"""A score-holder spec, see :func:`fixed` and :func:`context_target`."""


class Expression:
    """A number provider expression tree."""

    __slots__ = ("kind", "node", "op")
    __hash__ = None  # pyright: ignore[reportAssignmentType]

    def __init__(self, node: Node, kind: Kind = "float", op: str | None = None) -> None:
        """Wrap a raw provider node with its kind and originating operation."""
        self.node: Node = node
        self.kind: Kind = kind
        self.op: str | None = op

    def json(self, indent: int = 2) -> str:
        """Serialize as indented JSON."""
        return json.dumps(self.node, indent=indent)

    def inline(self) -> str:
        """Serialize as a single line usable inside a command."""
        return json.dumps(self.node, separators=(",", ":"))

    def __repr__(self) -> str:
        """Debug representation."""
        return f"Expression<{self.kind}>({self.inline()})"

    # -- arithmetic -------------------------------------------------------

    def __add__(self, other: Operand) -> Expression:
        """Addition, e.g. ``x + 2``."""
        return _nary("add", self, other)

    def __radd__(self, other: Operand) -> Expression:
        """Addition, e.g. ``2 + x``."""
        return _nary("add", other, self)

    def __mul__(self, other: Operand) -> Expression:
        """Multiplication, e.g. ``x * 2``."""
        return _nary("mul", self, other)

    def __rmul__(self, other: Operand) -> Expression:
        """Multiplication, e.g. ``x * 2``."""
        return _nary("mul", other, self)

    def __sub__(self, other: Operand) -> Expression:
        """Subtraction, e.g. ``x - 2``."""
        return _binary("sub", self, other)

    def __rsub__(self, other: Operand) -> Expression:
        """Subtraction, e.g. ``2 - x``."""
        return _binary("sub", other, self)

    def __truediv__(self, other: Operand) -> Expression:
        """Division, e.g. ``x / 2``."""
        return _binary("div", self, other)

    def __rtruediv__(self, other: Operand) -> Expression:
        """Division, e.g. ``2 / x``."""
        return _binary("div", other, self)

    def __floordiv__(self, other: Operand) -> Expression:
        """Floor division, e.g. ``x // 2``."""
        return _binary("floor_div", self, other)

    def __mod__(self, other: Operand) -> Expression:
        """Modulo, e.g. ``x % 2``."""
        return _binary("mod", self, other)

    def __pow__(self, other: Operand) -> Expression:
        """Exponentiation, e.g. ``x ** 2``."""
        return _fields("pow", self.kind, base=self, exponent=other)

    def __neg__(self) -> Expression:
        """Negate a number provider."""
        return _fields("negate", self.kind, input=self)

    def __abs__(self) -> Expression:
        """Absolute value."""
        return _fields("abs", self.kind, input=self)

    def floor_mod(self, other: Operand) -> Expression:
        """Floored modulus (rounds toward negative infinity)."""
        return _binary("floor_mod", self, other)

    # -- float unary helpers ------------------------------------------------

    def floor(self) -> Expression:
        """Round toward negative infinity."""
        return _fields("floor", "float", input=self)

    def ceil(self) -> Expression:
        """Round toward positive infinity."""
        return _fields("ceil", "float", input=self)

    def round(self) -> Expression:
        """Round to the nearest integer, ties toward positive infinity."""
        return _fields("round", "float", input=self)

    def truncate(self) -> Expression:
        """Round toward zero."""
        return _fields("truncate", "float", input=self)

    def sin(self) -> Expression:
        """Sine of a value in radians."""
        return _fields("sin", "float", input=self)

    def cos(self) -> Expression:
        """Cosine of a value in radians."""
        return _fields("cos", "float", input=self)

    def sqrt(self) -> Expression:
        """Square root."""
        return _fields("sqrt", "float", input=self)

    # -- kind conversion ------------------------------------------------------

    def to_int(self) -> Expression:
        """Convert a float provider to an int provider (truncates)."""
        return _fields("from_float", "int", input=self)

    def to_float(self) -> Expression:
        """Convert an int provider to a float provider."""
        return _fields("from_int", "float", input=self)

    # -- predicates ------------------------------------------------------------

    def eq(self, value: Operand) -> Predicate:
        """Value check: this == value."""
        return self._check(_lit(value, self.kind))

    def between(self, low: Operand, high: Operand) -> Predicate:
        """Value check: low <= this <= high."""
        return self._check({"min": _lit(low, self.kind), "max": _lit(high, self.kind)})

    def ge(self, value: Operand) -> Predicate:
        """Value check: this >= value."""
        return self._check({"min": _lit(value, self.kind)})

    def le(self, value: Operand) -> Predicate:
        """Value check: this <= value."""
        return self._check({"max": _lit(value, self.kind)})

    def __eq__(self, other: object) -> Predicate:  # type: ignore[override]
        """Value check: this == other."""
        return self.eq(_operand(other))

    def __ge__(self, other: Operand) -> Predicate:
        """Value check: this >= other."""
        return self.ge(other)

    def __le__(self, other: Operand) -> Predicate:
        """Value check: this <= other."""
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
        """Wrap a raw predicate object or a predicate registry ID."""
        self.node: dict[str, Json] | str = node

    def __and__(self, other: Self) -> Predicate:
        """Combine two predicates with logical AND, e.g. ``p1 & p2``."""
        return Predicate({"type": "all_of", "terms": [self.node, other.node]})

    def __or__(self, other: Self) -> Predicate:
        """Combine two predicates with logical OR, e.g. ``p1 | p2``."""
        return Predicate({"type": "any_of", "terms": [self.node, other.node]})

    def __invert__(self) -> Predicate:
        """Invert the predicate, e.g. ``~p``."""
        return Predicate({"type": "inverted", "term": self.node})

    def json(self, indent: int = 2) -> str:
        """Serialize as indented JSON."""
        return json.dumps(self.node, indent=indent)

    def inline(self) -> str:
        """Serialize as a single line usable inside a command."""
        return json.dumps(self.node, separators=(",", ":"))


# -- internals ------------------------------------------------------------------


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
    if isinstance(value, str):  # registry id
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
    """Build add / mul, flattening nested nodes and folding literals."""
    kind = _kind_of(*operands)
    inputs: list[Json] = []
    literals: list[float] = []
    for operand in operands:
        if isinstance(operand, Expression) and operand.op == op:
            nested = operand.node
            if isinstance(nested, dict) and isinstance(nested["inputs"], list):
                inputs.extend(nested["inputs"])
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
    return Expression(
        {"type": op, "inputs": [_lit(x, kind) for x in operands]},
        kind,
        op,
    )


# -- leaves -----------------------------------------------------------------------


def const(value: float) -> Expression:
    """Wrap a literal number, int or float deciding the kind."""
    kind: Kind = "float" if isinstance(value, float) else "int"
    return Expression(_lit(value, kind), kind, "const")


def ref(provider_id: str, kind: Kind = "float") -> Expression:
    """Create a reference to a registry provider, e.g. ``ref("ns:path")``."""
    return Expression(provider_id, kind, "ref")


def storage(storage_id: str, path: str, fallback: Operand | None = None) -> Expression:
    """Read a float from command storage, using ``fallback`` when path is missing."""
    node: dict[str, Json] = {"type": "storage", "storage": storage_id, "path": path}
    if fallback is not None:
        node["fallback"] = _lit(fallback, "float")
    return Expression(node, "float", "storage")


def istorage(storage_id: str, path: str, fallback: Operand | None = None) -> Expression:
    """Read an int from command storage, using ``fallback`` when the path is missing."""
    node: dict[str, Json] = {"type": "storage", "storage": storage_id, "path": path}
    if fallback is not None:
        node["fallback"] = _lit(fallback, "int")
    return Expression(node, "int", "storage")


def score(
    objective: str,
    target: Target,
    fallback: Operand | None = None,
) -> Expression:
    """Read a score for ``target``, see :func:`fixed` and :func:`context_target`."""
    node: dict[str, Json] = {"type": "score", "score": objective, "target": target}
    if fallback is not None:
        node["fallback"] = _lit(fallback, "int")
    return Expression(node, "int", "score")


def fixed(name: str) -> Target:
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
    """Read an environment attribute."""
    return Expression({"type": "environment_attribute", "attribute": attribute}, kind)


def weighted(*entries: tuple[Operand, int], kind: Kind | None = None) -> Expression:
    """Pick from ``(provider, weight)`` pairs, e.g. ``weighted((1, 3), (2, 1))``."""
    kind = kind or _kind_of(*(value for value, _ in entries))
    distribution: list[Json] = [
        {"data": _lit(value, kind), "weight": weight} for value, weight in entries
    ]
    return Expression({"type": "weighted_list", "distribution": distribution}, kind)


# -- n-ary math -------------------------------------------------------------------


def add(*operands: Operand) -> Expression:
    """Sum of the operands."""
    return _nary("add", *operands)


def mul(*operands: Operand) -> Expression:
    """Product of the operands."""
    return _nary("mul", *operands)


def min_(*operands: Operand) -> Expression:
    """Smallest of the operands."""
    return _inputs("min", _kind_of(*operands), operands)


def max_(*operands: Operand) -> Expression:
    """Largest of the operands."""
    return _inputs("max", _kind_of(*operands), operands)


def avg(*operands: Operand) -> Expression:
    """Arithmetic mean of the operands."""
    return _inputs("avg", _kind_of(*operands), operands)


def length(*operands: Operand) -> Expression:
    """Euclidean length: square root of the sum of squares."""
    return _inputs("length", "float", operands)


def lerp(a: Operand, b: Operand, t: Operand) -> Expression:
    """Linear interpolation ``a + t * (b - a)``."""
    return add(a, mul(t, _binary("sub", b, a)))


def clamp(value: Operand, low: Operand, high: Operand) -> Expression:
    """Clamp ``value`` into ``[low, high]``."""
    return min_(max_(value, low), high)


# -- control flow -----------------------------------------------------------------


def cond(
    predicate: Predicate,
    on_true: Operand,
    on_false: Operand | None = None,
) -> Expression:
    """Evaluate ``on_true`` if the predicate passes, else ``on_false``."""
    kind = _kind_of(on_true, on_false)
    node: dict[str, Json] = {
        "type": "conditional",
        "conditions": predicate.node,
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
    """Balanced binary tree of conditionals.

    ``key <= b0 -> e0``, ``key <= b1 -> e1``, ..., else ``last``. Lookup depth is
    ``log2(n)`` instead of the linear scan of a dispatcher.
    """
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
    "fixed",
    "istorage",
    "length",
    "lerp",
    "max_",
    "min_",
    "mul",
    "ref",
    "score",
    "storage",
    "switch",
    "uniform",
    "weighted",
]

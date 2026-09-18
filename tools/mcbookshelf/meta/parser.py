import re
from functools import cache
from pathlib import Path
from typing import Any

from lark import Lark, Token, Transformer, UnexpectedInput, v_args
from lark.tree import Meta

from . import syntax
from .errors import MetadataError

GRAMMAR_DIR = Path(__file__).with_name("grammar")
GRAMMAR_FILES = ("module.lark", "types.lark", "terminals.lark")

TOKEN_NAMES = {
    "_NL": "end of line",
    "_RANGE": "'..'",
    "AT": "'@'",
    "COLON": "':'",
    "COMMA": "','",
    "DOC": "a '>' description",
    "EQUAL": "'='",
    "FLOAT_TYPE": "a type",
    "FLOAT": "a number",
    "ID": "a name",
    "INT_TYPE": "a type",
    "INT": "a whole number",
    "KIND": "a kind",
    "LBRACE": "'{'",
    "LSQB": "'['",
    "OPTIONAL": "'?'",
    "PLAIN_TYPE": "a type",
    "RBRACE": "'}'",
    "REGISTRY": "a registry",
    "RESOURCE_LOCATION": "a resource location",
    "RSQB": "']'",
    "SLASH": "'/'",
    "TEXT": "a value",
    "VBAR": "'|'",
}


def parse(text: str, file: Path | None = None) -> syntax.Module:
    try:
        tree = _parser().parse(text.rstrip("\r\n\t ") + "\n")
    except UnexpectedInput as error:
        where = {"file": file, "line": error.line, "column": error.column}
        raise MetadataError(_describe(error), **where) from None
    return _Transform().transform(tree)


@cache
def _parser() -> Lark:
    return Lark(
        "".join((GRAMMAR_DIR / name).read_text("utf-8") for name in GRAMMAR_FILES),
        parser="lalr",
        lexer="contextual",
        propagate_positions=True,
        start="module",
    )


def _name(token: Token) -> str:
    return str(token).removeprefix("^")


def _number(token: Token) -> int | float:
    return int(token) if token.type == "INT" else float(token)


def _nodes(items: list[Any]) -> list[Any]:
    return [i for i in items if not isinstance(i, Token)]


def _text(doc: Token) -> str:
    lines = (line.strip()[1:].strip() for line in str(doc).splitlines())
    return "\n".join(lines)


def _desc(items: list[Any]) -> str | None:
    docs = [_text(i) for i in items if isinstance(i, Token) and i.type == "DOC"]
    return "\n".join(docs) if docs else None


def _describe(error: UnexpectedInput) -> str:
    token = getattr(error, "token", None)
    if isinstance(token, Token) and re.match(r"-?[0-9]*\.[0-9]", str(token)):
        return "a fraction is not allowed here, expected a whole number"
    expected = getattr(error, "expected", None) or getattr(error, "allowed", None) or ()
    names = sorted({TOKEN_NAMES.get(name, name.lower()) for name in expected})
    if not names:
        return "unexpected input"
    return f"unexpected input, expected {', '.join(names)}"


@v_args(meta=True)
class _Transform(Transformer[Token, Any]):

    def module(self, _meta: Meta, items: list[Any]) -> syntax.Module:
        return syntax.Module(description=_desc(items), slots=tuple(_nodes(items)), line=1)

    def feature(self, meta: Meta, items: list[Any]) -> syntax.Feature:
        registry, id_, *rest = items
        return syntax.Feature(
            registry=str(registry),
            id=_name(id_),
            description=_desc(rest),
            slots=tuple(_nodes(rest)),
            line=meta.line,
        )

    def property(self, meta: Meta, items: list[Token]) -> syntax.Property:
        key, value = items
        return syntax.Property(key=_name(key), value=str(value).strip(), line=meta.line)

    def variable(self, meta: Meta, items: list[Any]) -> syntax.Variable:
        name, declaration = items
        return syntax.Variable(name=_name(name), declaration=declaration, line=meta.line)

    def context(self, meta: Meta, items: list[Any]) -> syntax.Context:
        return syntax.Context(value=items[0], line=meta.line)

    def input(self, meta: Meta, items: list[Any]) -> syntax.Input:
        return syntax.Input(value=items[0], line=meta.line)

    def output(self, meta: Meta, items: list[Any]) -> syntax.Output:
        return syntax.Output(value=items[0], line=meta.line)

    def path(self, _meta: Meta, items: list[Token]) -> str:
        return "/".join(map(_name, items))

    def type(self, meta: Meta, items: list[syntax.Type]) -> syntax.Type:
        if len(items) == 1:
            return items[0]
        return syntax.Union(members=tuple(items), line=meta.line)

    def member(self, meta: Meta, items: list[Any]) -> syntax.Type:
        element, *sizes = items
        for size in sizes:
            element = syntax.Array(element=element, size=size, line=meta.line)
        return element

    def exact_range(self, meta: Meta, items: list[Token]) -> syntax.Range:
        value = _number(items[0])
        return syntax.Range(min=value, max=value, line=meta.line)

    def full_range(self, meta: Meta, items: list[Token]) -> syntax.Range:
        low, high = items
        return syntax.Range(min=_number(low), max=_number(high), line=meta.line)

    def min_range(self, meta: Meta, items: list[Token]) -> syntax.Range:
        return syntax.Range(min=_number(items[0]), line=meta.line)

    def max_range(self, meta: Meta, items: list[Token]) -> syntax.Range:
        return syntax.Range(max=_number(items[0]), line=meta.line)

    def array(self, _meta: Meta, items: list[syntax.Range]) -> syntax.Range | None:
        return items[0] if items else None

    def primitive(self, meta: Meta, items: list[Any]) -> syntax.Primitive:
        name, *range_ = items
        kind = syntax.PrimitiveKind(str(name))
        bounds = range_[0] if range_ else None
        return syntax.Primitive(kind=kind, range=bounds, line=meta.line)

    def list_type(self, meta: Meta, items: list[Any]) -> syntax.List:
        element, *range_ = items
        size = range_[0] if range_ else None
        return syntax.List(element=element, size=size, line=meta.line)

    def tuple_type(self, meta: Meta, items: list[syntax.Type]) -> syntax.Tuple:
        return syntax.Tuple(elements=tuple(items), line=meta.line)

    def struct(self, meta: Meta, items: list[syntax.Entry]) -> syntax.Struct:
        return syntax.Struct(entries=tuple(items), line=meta.line)

    def entry(self, meta: Meta, items: list[Any]) -> syntax.Entry:
        return syntax.Entry(
            name=_name(items[0]),
            type=next(iter(_nodes(items))),
            optional=any(isinstance(i, Token) and i.type == "OPTIONAL" for i in items),
            description=_desc(items),
            line=meta.line,
        )

    def reference(self, meta: Meta, items: list[Token]) -> syntax.Reference:
        name = _name(items[0])
        return syntax.Reference(name=name, description=_desc(items), line=meta.line)

    def storage(self, meta: Meta, items: list[Any]) -> syntax.Storage:
        return syntax.Storage(
            id=next((str(i) for i in items if isinstance(i, Token)), None),
            path=next((i for i in items if not isinstance(i, Token)), None),
            line=meta.line,
        )

    def declaration(self, meta: Meta, items: list[Any]) -> syntax.Declaration:
        kind, *rest = items
        return syntax.Declaration(
            kind=syntax.Kind(str(kind)) if isinstance(kind, Token) else kind,
            type=next(iter(_nodes(rest)), None),
            description=_desc(rest),
            line=meta.line,
        )

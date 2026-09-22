from dataclasses import replace
from functools import cache
from pathlib import Path
from typing import Any

from lark import Lark, Token, Transformer, UnexpectedInput, v_args
from lark.tree import Meta

from . import syntax
from .diagnostics import Diagnostic, MetadataError

GRAMMAR = Path(__file__).with_name("grammar.lark")


def parse(text: str, file: Path | None = None) -> syntax.Module:
    """Parse a file, raising the one syntax error it may have."""
    try:
        tree = _parser().parse(text.rstrip("\r\n\t ") + "\n")
    except UnexpectedInput as error:
        diagnostic = Diagnostic(str(error), file=file, line=error.line, column=error.column)
        raise MetadataError(diagnostic) from None
    return _Transform().transform(tree)


@cache
def _parser() -> Lark:
    return Lark(
        GRAMMAR.read_text("utf-8"),
        parser="lalr",
        lexer="contextual",
        propagate_positions=True,
        start="document",
    )


def _name(token: Token) -> str:
    return str(token).removeprefix("$")


def _number(token: Token) -> int | float:
    return int(token) if token.type == "INT" else float(token)


def _nodes(items: list[Any]) -> list[Any]:
    return [i for i in items if not isinstance(i, Token)]


def _description(items: list[Any]) -> str | None:
    docs = [_text(i) for i in items if isinstance(i, Token) and i.type == "DOC"]
    return "\n".join(docs) if docs else None


def _text(doc: Token) -> str:
    lines = (line.strip()[1:].strip() for line in str(doc).splitlines())
    return "\n".join(lines)


@v_args(meta=True)
class _Transform(Transformer[Token, Any]):

    def document(self, _meta: Meta, items: list[Any]) -> syntax.Module:
        return syntax.Module(description=_description(items), lines=tuple(_nodes(items)), line=1)

    def feature(self, meta: Meta, items: list[Any]) -> syntax.Feature:
        registry, id_, *rest = items
        return syntax.Feature(
            registry=str(registry),
            id=_name(id_),
            description=_description(rest),
            lines=tuple(_nodes(rest)),
            line=meta.line,
        )

    def slot(self, meta: Meta, items: list[Any]) -> syntax.Slot:
        kept = [i for i in items if not (isinstance(i, Token) and i.type == "DOC")]
        if (doc := _description(items)) is not None:
            kept[-1] = replace(kept[-1], description=doc)
        return syntax.Slot(role=syntax.Role(str(kept[0])), value=kept[1], line=meta.line)

    def property(self, meta: Meta, items: list[Token]) -> syntax.Property:
        key, value = items
        return syntax.Property(key=_name(key), value=str(value).strip(), line=meta.line)

    def variable(self, meta: Meta, items: list[Any]) -> syntax.Variable:
        name, value = (i for i in items if not (isinstance(i, Token) and i.type == "DOC"))
        return syntax.Variable(
            name=_name(name),
            value=value,
            description=_description(items),
            line=meta.line,
        )

    def reference(self, meta: Meta, items: list[Token]) -> syntax.Reference:
        return syntax.Reference(name=_name(items[0]), line=meta.line)

    def declaration(self, meta: Meta, items: list[Any]) -> syntax.Declaration:
        kind, *rest = items
        id_ = next((str(i) for i in rest if isinstance(i, Token)), None)
        path = next((i for i in rest if isinstance(i, str) and not isinstance(i, Token)), None)
        storage = None
        if id_ is not None or path is not None:
            storage = syntax.Storage(id=id_, path=path, line=meta.line)
        return syntax.Declaration(
            kind=syntax.Kind(str(kind)),
            storage=storage,
            type=next((i for i in rest if not isinstance(i, str)), None),
            line=meta.line,
        )

    def path(self, _meta: Meta, items: list[Token]) -> str:
        return "/".join(map(_name, items))

    def type(self, meta: Meta, items: list[syntax.Type]) -> syntax.Type:
        if len(items) == 1:
            return items[0]
        return syntax.Union(members=tuple(items), line=meta.line)

    def member(self, _meta: Meta, items: list[Any]) -> syntax.Type:
        *attributes, base = items
        if not attributes:
            return base
        return replace(base, attributes=tuple(str(a) for a in attributes))

    def array(self, meta: Meta, items: list[Any]) -> syntax.Array:
        element, *size = items
        return syntax.Array(element=element, size=size[0] if size else None, line=meta.line)

    def array_element(self, meta: Meta, items: list[Any]) -> syntax.Primitive:
        name, *bound = items
        kind = syntax.PrimitiveKind(str(name))
        return syntax.Primitive(kind=kind, range=bound[0] if bound else None, line=meta.line)

    def list_type(self, meta: Meta, items: list[Any]) -> syntax.List:
        element, *range_ = items
        size = range_[0] if range_ else None
        return syntax.List(element=element, size=size, line=meta.line)

    def tuple_type(self, meta: Meta, items: list[syntax.Type]) -> syntax.Tuple:
        return syntax.Tuple(elements=tuple(items), line=meta.line)

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

    def primitive(self, meta: Meta, items: list[Any]) -> syntax.Primitive:
        name, *range_ = items
        kind = syntax.PrimitiveKind(str(name))
        bounds = range_[0] if range_ else None
        return syntax.Primitive(kind=kind, range=bounds, line=meta.line)

    def struct(self, meta: Meta, items: list[syntax.Entry]) -> syntax.Struct:
        return syntax.Struct(entries=tuple(items), line=meta.line)

    def entry(self, meta: Meta, items: list[Any]) -> syntax.Entry:
        return syntax.Entry(
            name=_name(items[0]),
            type=next(iter(_nodes(items))),
            optional=any(isinstance(i, Token) and i.type == "OPTIONAL" for i in items),
            description=_description(items),
            line=meta.line,
        )

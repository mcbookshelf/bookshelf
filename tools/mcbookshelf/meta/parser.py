from collections.abc import Iterator
from dataclasses import replace
from functools import cache
from pathlib import Path
from typing import Any

from lark import Lark, Token, Transformer, UnexpectedInput, v_args
from lark.indenter import DedentError, Indenter
from lark.tree import Meta

from . import syntax
from .diagnostics import Diagnostic, MetadataError

GRAMMAR = Path(__file__).with_name("grammar.lark")
INDENT = 2


def parse(text: str, file: Path | None = None) -> syntax.Module:
    """Parse a file, raising the one syntax error it may have."""
    try:
        tree = _parser().parse(text.rstrip("\r\n\t ") + "\n")
    except UnexpectedInput as error:
        diagnostic = Diagnostic(str(error), file=file, line=error.line, column=error.column)
        raise MetadataError(diagnostic) from None
    except _IndentError as error:
        raise MetadataError(Diagnostic(error.message, file=file, line=error.line)) from None
    return _Transform().transform(tree)


@cache
def _parser() -> Lark:
    return Lark(
        GRAMMAR.read_text("utf-8"),
        parser="lalr",
        lexer="contextual",
        postlex=_Indenter(),
        propagate_positions=True,
        start="document",
        cache=True,
    )


class _IndentError(Exception):

    def __init__(self, message: str, line: int) -> None:
        super().__init__(message)
        self.message = message
        self.line = line


class _Indenter(Indenter):
    """A block is a line and the lines under it, indented by two spaces and no tab."""

    NL_type = "_NL"
    OPEN_PAREN_types = ()
    CLOSE_PAREN_types = ()
    INDENT_type = "_INDENT"
    DEDENT_type = "_DEDENT"
    tab_len = INDENT

    def handle_NL(self, token: Token) -> Iterator[Token]:  # noqa: N802
        indent = token.rsplit("\n", 1)[1]
        line = token.end_line or 0
        if "\t" in indent:
            raise _IndentError("a line is indented with spaces, not tabs", line)
        extra = len(indent) - self.indent_level[-1]
        if extra > 0 and extra != INDENT:
            raise _IndentError(f"a block is indented by {INDENT} spaces, not {extra}", line)
        try:
            yield from super().handle_NL(token)
        except DedentError:
            message = "a line is indented like the block it belongs to, this one like none"
            raise _IndentError(message, line) from None


def _name(token: Token) -> str:
    return str(token).removeprefix("$")


def _number(token: Token) -> int | float:
    return int(token) if token.type == "INT" else float(token)


def _is(item: Any, *types: str) -> bool:  # noqa: ANN401
    return isinstance(item, Token) and item.type in types


def _nodes(items: list[Any]) -> tuple[Any, ...]:
    return tuple(i for i in items if not isinstance(i, Token | tuple) and i is not None)


def _description(items: list[Any]) -> str | None:
    """The doc of a line: written on it, on the next one or as the first line of its block."""
    flat = (i for item in items for i in (item if isinstance(item, tuple) else (item,)))
    docs = [_text(i) for i in flat if _is(i, "DOC")]
    return "\n".join(docs) if docs else None


def _text(doc: Token) -> str:
    lines = (line.strip() for line in str(doc).splitlines())
    return "\n".join(line[1:].strip() for line in lines if line.startswith(">"))


def _type(items: list[Any]) -> syntax.Type | None:
    return next((i for i in items if isinstance(i, syntax.Type.__value__)), None)


def _fields(items: list[Any]) -> tuple[syntax.Member, ...]:
    block = next((i for i in items if isinstance(i, tuple)), ())
    return tuple(i for i in block if not isinstance(i, Token))


@v_args(meta=True)
class _Transform(Transformer[Token, Any]):

    def document(self, _meta: Meta, items: list[Any]) -> syntax.Module:
        return syntax.Module(description=_description(items), lines=_nodes(items), line=1)

    def property(self, meta: Meta, items: list[Token]) -> syntax.Property:
        key, value = items
        return syntax.Property(key=str(key), value=str(value).strip(), line=meta.line)

    def metadata(self, meta: Meta, items: list[Token]) -> syntax.Metadata:
        key, *value = items
        text = str(value[0]).strip() if value else None
        return syntax.Metadata(key=str(key), value=text, line=meta.line)

    def alias(self, meta: Meta, items: list[Any]) -> syntax.Definition:
        return syntax.Definition(
            name=_name(items[0]),
            type=_type(items),
            description=_description(items),
            body=_fields(items),
            line=meta.line,
        )

    def block(self, meta: Meta, items: list[Any]) -> syntax.Definition:
        name, *body = items
        return syntax.Definition(
            name=_name(name),
            description=_description(body),
            body=_nodes(body),
            line=meta.line,
        )

    def list_items(self, meta: Meta, items: list[Any]) -> syntax.Items:
        name, names, *properties = items
        return syntax.Items(
            name=_name(name),
            items=names,
            properties=_nodes(properties),
            line=meta.line,
        )

    def items(self, _meta: Meta, items: list[Token]) -> tuple[str, ...]:
        return tuple(map(str, items))

    def item_property(self, meta: Meta, items: list[Token]) -> syntax.Property:
        key, value = items
        return syntax.Property(key=str(key), value=str(value).strip(), line=meta.line)

    def feature(self, meta: Meta, items: list[Any]) -> syntax.Feature:
        _, registry, id_, *rest = items
        return syntax.Feature(
            registry=str(registry),
            id=str(id_),
            description=_description(rest),
            lines=_nodes(rest),
            line=meta.line,
        )

    def context(self, meta: Meta, items: list[Any]) -> syntax.Slot:
        return syntax.Slot(
            role=syntax.Role.CONTEXT,
            kind=syntax.Kind(str(items[0]).removeprefix("@")),
            type=_type(items),
            description=_description(items),
            line=meta.line,
        )

    def slot(self, meta: Meta, items: list[Any]) -> syntax.Slot:
        role, kind, id_, path, *rest = items
        storage = None
        if id_ is not None or path is not None:
            storage = syntax.Storage(id=id_ and str(id_), path=path, line=meta.line)
        return syntax.Slot(
            role=syntax.Role(str(role)),
            kind=syntax.Kind(str(kind)),
            type=_type(rest),
            storage=storage,
            description=_description(rest),
            fields=_fields(rest),
            line=meta.line,
        )

    def paste(self, meta: Meta, items: list[Token]) -> syntax.Paste:
        return syntax.Paste(name=_name(items[0]), line=meta.line)

    def fields(self, _meta: Meta, items: list[Any]) -> tuple[Any, ...]:
        # a doc which opens the block is the one of the line above: it is handed back to it
        return (*(i for i in items if _is(i, "DOC")), *_nodes(items))

    def field(self, meta: Meta, items: list[Any]) -> syntax.Field:
        return syntax.Field(
            name=_name(items[0]),
            type=_type(items),
            optional=any(_is(i, "OPTIONAL") for i in items),
            description=_description(items),
            fields=_fields(items),
            line=meta.line,
        )

    def path(self, _meta: Meta, items: list[Token]) -> str:
        return "/".join(map(str, items))

    def reference(self, meta: Meta, items: list[Token]) -> syntax.Reference:
        return syntax.Reference(name=_name(items[0]), line=meta.line)

    def struct(self, meta: Meta, _items: list[Token]) -> syntax.Struct:
        return syntax.Struct(line=meta.line)

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
        low, operator, high = items
        low, high = _number(low), _number(high)
        return syntax.Range(min=low, max=high, operator=str(operator), line=meta.line)

    def min_range(self, meta: Meta, items: list[Token]) -> syntax.Range:
        low, operator = items
        return syntax.Range(min=_number(low), operator=str(operator), line=meta.line)

    def max_range(self, meta: Meta, items: list[Token]) -> syntax.Range:
        operator, high = items
        return syntax.Range(max=_number(high), operator=str(operator), line=meta.line)

    def primitive(self, meta: Meta, items: list[Any]) -> syntax.Primitive:
        name, *range_ = items
        kind = syntax.PrimitiveKind(str(name))
        bounds = range_[0] if range_ else None
        return syntax.Primitive(kind=kind, range=bounds, line=meta.line)

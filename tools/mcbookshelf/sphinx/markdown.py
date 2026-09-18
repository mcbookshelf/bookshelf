import re
from collections.abc import Iterator, Sequence

from mcbookshelf.meta import Feature, Slot, models, syntax
from mcbookshelf.meta.syntax import PrimitiveKind

STORAGE, MACRO = "storage", "macro"

ROOTS = {models.Role.INPUT: "arguments", models.Role.OUTPUT: "result"}

EXECUTION = {
    syntax.Kind.EXECUTOR: "as",
    syntax.Kind.POSITION: "at",
    syntax.Kind.ROTATION: "rotated as",
    syntax.Kind.DIMENSION: "in",
}

PLACES = {
    syntax.Kind.POSITION: "positioned <x> <y> <z>",
    syntax.Kind.ROTATION: "rotated <x> <y>",
    syntax.Kind.DIMENSION: "in <dimension>",
}

ICONS = {
    syntax.PrimitiveKind.BOOLEAN: "bool",
    syntax.PrimitiveKind.BYTE: "byte",
    syntax.PrimitiveKind.SHORT: "short",
    syntax.PrimitiveKind.INT: "int",
    syntax.PrimitiveKind.LONG: "long",
    syntax.PrimitiveKind.FLOAT: "float",
    syntax.PrimitiveKind.DOUBLE: "double",
    syntax.PrimitiveKind.STRING: "string",
}


def title(name: str) -> str:
    return name.replace("/", " ").replace("_", " ").capitalize()


def tabs(reference: str, content: Sequence[str] = ()) -> str:
    longest = max((len(m) for m in re.findall(r"`+", "\n".join(content))), default=0)
    fence = "`" * max(3, longest + 1)
    body = "\n".join(["", *content]) if content else ""
    lines = [":::::{tab-set}"]
    for label, form in (("Storage", STORAGE), ("Macro", MACRO)):
        inner = f"{fence}{{feature}} {reference}\n:form: {form}\n{body}\n{fence}"
        lines += [f"::::{{tab-item}} {label}", inner, "::::"]
    return "\n".join([*lines, ":::::"])


def feature(feature: Feature, *, macro: bool = False) -> str:
    lines = []
    if feature.experimental:
        note = "still in the making: it ships in the nightly only, and may change"
        lines += [f"{{bdg-warning}}`experimental` {note}", ""]
    lines += [feature.description or "", ""]
    arguments = feature.macro_struct if macro else None
    for role in models.Role:
        slots = [s for s in feature.of(role) if s.kind is not syntax.Kind.MACRO]
        if role is models.Role.INPUT and arguments is not None:
            slots = [s for s in slots if s.target is None]
        if not slots and not (role is models.Role.INPUT and arguments is not None):
            continue
        lines.append(f":{_heading(role)}:")
        for slot in slots:
            lines.extend(f"  {line}" for line in _slot(slot, role))
        if role is models.Role.INPUT and arguments is not None:
            described = feature.input_macro.description if feature.input_macro else None
            lines.append("  **Macro**:")
            lines.extend(f"  {line}" for line in _treeview(described or "arguments", arguments))
        lines.append("")
    return "\n".join(lines)


def _heading(role: models.Role) -> str:
    return "Context" if role is models.Role.CONTEXT else f"{role.capitalize()}s"


def _slot(slot: Slot, role: models.Role) -> Iterator[str]:
    doc = f": {slot.description}" if slot.description else ""
    if slot.target is not None:
        label = f"**Storage `{slot.target.display}`**"
        if isinstance(slot.type, syntax.Struct):
            yield f"{label}:"
            yield from _treeview(slot.description or ROOTS[role], slot.type)
        elif slot.type is not None:
            yield f"{label}: {{nbt}}`{_icon(slot.type)}` {slot.description or ''}".rstrip()
        return
    if slot.kind in EXECUTION and slot.type is not None:
        yield f"**Execution `{_execution(slot.kind, slot.type)}`**{doc}"
        return
    code = f" `{slot.type}`" if slot.type is not None else ""
    yield f"**{str(slot.kind).capitalize()}**{code}{doc}"


def _execution(kind: syntax.Kind, value: syntax.Type) -> str:
    """The execute subcommand a context is read as, such as `as <players>`."""
    match value:
        case syntax.Union(members=members):
            return "` or `".join(_execution(kind, member) for member in members)
        case syntax.Array(element=syntax.Primitive(kind=element)) if kind is syntax.Kind.EXECUTOR:
            return f"as <{element}s>"
        case syntax.Array(element=element):
            return _execution(kind, element)
        case syntax.Primitive(kind=who) if who in (PrimitiveKind.PLAYER, PrimitiveKind.ENTITY):
            return f"{EXECUTION[kind]} <{who}>"
    return PLACES[kind]


def _treeview(root: str, struct: syntax.Struct) -> Iterator[str]:
    yield ":::{treeview}"
    yield f"- {{nbt}}`compound` {root}"
    yield from _entries(struct, "  ")
    yield ":::"


def _entries(struct: syntax.Struct, indent: str) -> Iterator[str]:
    for entry in struct.entries:
        optional = " *(optional)*" if entry.optional else ""
        doc = f": {entry.description}" if entry.description else ""
        yield f"{indent}- {{nbt}}`{_icon(entry.type)}` **{entry.name}**{optional}{doc}"
        if isinstance(entry.type, syntax.Struct):
            yield from _entries(entry.type, indent + "  ")


def _icon(value: syntax.Type) -> str:
    match value:
        case syntax.Struct():
            return "compound"
        case syntax.Array() | syntax.List() | syntax.Tuple():
            return "list"
        case syntax.Primitive(kind=kind):
            return ICONS.get(kind, "any")
    return "any"

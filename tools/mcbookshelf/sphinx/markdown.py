import re
from collections.abc import Iterator, Sequence

from mcbookshelf.meta import Feature, Slot, models, syntax

STORAGE, MACRO = "storage", "macro"

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
    for role in models.Role:
        slots = feature.of(role)
        if role is models.Role.INPUT and macro and feature.macro_struct is not None:
            lines.append(":Inputs:")
            lines.extend(
                f"  {line}"
                for line in _treeview("**arguments**", feature.macro_struct)
            )
            lines.append("")
            continue
        if not slots:
            continue
        lines.append(f":{_heading(role)}:")
        for slot in slots:
            if slot.kind is syntax.Kind.MACRO:
                continue
            lines.extend(f"  {line}" for line in _slot(slot))
        lines.append("")
    return "\n".join(lines)


def _heading(role: models.Role) -> str:
    return "Context" if role is models.Role.CONTEXT else f"{role.capitalize()}s"


def _slot(slot: Slot) -> Iterator[str]:
    doc = f": {slot.description}" if slot.description else ""
    if slot.target is None:
        code = f" `{slot.type}`" if slot.type is not None else ""
        yield f"**{str(slot.kind).capitalize()}**{code}{doc}"
        return
    label = f"**`{slot.target.display}`**"
    if isinstance(slot.type, syntax.Struct):
        yield from _treeview(label, slot.type)
    elif slot.type is not None:
        yield f"{{nbt}}`{_icon(slot.type)}` {label}{doc}"


def _treeview(root: str, struct: syntax.Struct) -> Iterator[str]:
    yield ":::{treeview}"
    yield f"- [+] {{nbt}}`compound` {root}"
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

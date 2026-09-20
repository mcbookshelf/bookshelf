from collections.abc import Iterator

from mcbookshelf.meta import Feature, Role, Slot, syntax

TREEVIEW = {
    Role.INPUT: "arguments",
    Role.OUTPUT: "result",
}

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
    syntax.PrimitiveKind.NUMBER: "number",
    syntax.PrimitiveKind.STRING: "string",
}


def feature(feature: Feature, *, macro: bool = False) -> str:
    lines = []
    if feature.experimental:
        note = "still in the making: it ships in the nightly only, and may change"
        lines += [f"{{bdg-warning}}`experimental` {note}", ""]
    lines += [feature.description or "", ""]
    arguments = feature.macro_struct if macro else None
    for role in Role:
        slots = [s for s in feature.of(role) if s.kind is not syntax.Kind.MACRO]
        if role is Role.INPUT and arguments is not None:
            slots = [s for s in slots if s.target is None]
        if not slots and not (role is Role.INPUT and arguments is not None):
            continue
        lines.append(f":{_heading(role)}:")
        for slot in slots:
            lines.extend(f"  {line}" for line in _slot(slot, role))
        if role is Role.INPUT and arguments is not None:
            described = feature.macro.description if feature.macro else None
            lines.append("  **Macro**:")
            tree = _treeview(described or "arguments", arguments, macro=True)
            lines.extend(f"  {line}" for line in tree)
        lines.append("")
    return "\n".join(lines)


def _heading(role: Role) -> str:
    return "Context" if role is Role.CONTEXT else f"{role.capitalize()}s"


def _slot(slot: Slot, role: Role) -> Iterator[str]:
    doc = f": {slot.description}" if slot.description else ""
    if slot.target is not None:
        label = f"**Storage `{slot.target.display}`**"
        if isinstance(slot.type, syntax.Struct):
            yield f"{label}:"
            yield from _treeview(slot.description or TREEVIEW[role], slot.type)
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
            plural = "entities" if element is syntax.PrimitiveKind.ENTITY else f"{element}s"
            return f"as <{plural}>"
        case syntax.Array(element=element):
            return _execution(kind, element)
        case syntax.Primitive(kind=who) if who in (
            syntax.PrimitiveKind.PLAYER,
            syntax.PrimitiveKind.ENTITY,
        ):
            return f"{EXECUTION[kind]} <{who}>"
    return PLACES[kind]


def _treeview(root: str, struct: syntax.Struct, *, macro: bool = False) -> Iterator[str]:
    yield ":::{treeview}"
    yield f"- {{nbt}}`compound` {root}"
    yield from _entries(struct, "  ", macro=macro)
    yield ":::"


def _entries(struct: syntax.Struct, indent: str, *, macro: bool = False) -> Iterator[str]:
    """The entries of a struct, a nested one collapsible: not the `with` of a macro, always read."""
    for entry in struct.entries:
        optional = " *(optional)*" if entry.optional else ""
        doc = f": {entry.description}" if entry.description else ""
        nested = list(_structs(entry.type))
        expanded = macro and entry.name == "with"
        collapse = "[-] " if any(s.entries for s in nested) and not expanded else ""
        yield f"{indent}- {collapse}{_badges(entry.type)} **{entry.name}**{optional}{doc}"
        for struct_ in nested:
            yield from _entries(struct_, indent + "  ")


def _badges(value: syntax.Type) -> str:
    """One `{nbt}` badge per type, a union showing each of its members."""
    if isinstance(value, syntax.Union):
        return "".join(_badges(m) for m in value.members)
    return f"{{nbt}}`{_icon(value)}`"


def _structs(value: syntax.Type) -> Iterator[syntax.Struct]:
    """The structs a type shows the entries of: itself, or the struct members of a union."""
    match value:
        case syntax.Struct():
            yield value
        case syntax.Union(members=members):
            for member in members:
                yield from _structs(member)


def _icon(value: syntax.Type) -> str:
    match value:
        case syntax.Struct():
            return "compound"
        case syntax.Array(element=syntax.Primitive(kind=kind)) if kind in ICONS:
            return f"{ICONS[kind]}-array"
        case syntax.Array() | syntax.List() | syntax.Tuple():
            return "list"
        case syntax.Primitive(kind=kind):
            return ICONS.get(kind, "any")
    return "any"

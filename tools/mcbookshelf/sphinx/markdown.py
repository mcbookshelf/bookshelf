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

ARRAYS = (syntax.PrimitiveKind.INT, syntax.PrimitiveKind.BYTE, syntax.PrimitiveKind.LONG)

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


def render(feature: Feature, *, macro: bool = False) -> str:
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
        # What a function returns reads last, after what it writes
        entries = [_slot(slot, role) for slot in sorted(slots, key=lambda s: s.target is None)]
        if role is Role.INPUT and arguments is not None:
            described = feature.macro.description if feature.macro else None
            tree = _treeview(described or "arguments", arguments, macro=True)
            entries.append(("Macro", list(tree)))
        lines.append(f":{_heading(role)}:")
        for label, body in entries:
            lines.extend(_entry(label, body))
    return "\n".join(lines)


def _entry(label: str, body: list[str]) -> Iterator[str]:
    """One entry of a section, in a block of its own: its kind as a badge, then what it holds."""
    kind, _, name = label.partition(" ")
    head = f"{{bdg-secondary}}`{kind}`" + (f" **{name}**:" if name else ":")
    yield "  ::::{div} bs-entry"
    if body and body[0].startswith(":::"):
        yield f"  {head}"
        yield from (f"  {line}" for line in body)
    else:
        first, *rest = body or [""]
        yield f"  {head} {first}".rstrip()
        yield from (f"  {line}" for line in rest)
    yield "  ::::"
    yield ""


def _heading(role: Role) -> str:
    return "Context" if role is Role.CONTEXT else f"{role.capitalize()}s"


def _slot(slot: Slot, role: Role) -> tuple[str, list[str]]:
    """A slot as its label and the lines of its body: its description, or the tree of a struct."""
    description = slot.description.splitlines() if slot.description else []
    if slot.target is not None:
        label = f"Storage `{slot.target.display}`"
        if isinstance(slot.type, syntax.Struct):
            return label, list(_treeview(slot.description or TREEVIEW[role], slot.type))
        if slot.type is not None:
            first, *rest = description or [""]
            return label, [f"{_badges(slot.type)} {first}".rstrip(), *rest]
    if slot.kind in EXECUTION and slot.type is not None:
        return f"Execution `{_execution(slot.kind, slot.type)}`", description
    return str(slot.kind).capitalize(), description


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
        case syntax.Primitive(kind=where) if where in (
            syntax.PrimitiveKind.OVERWORLD,
            syntax.PrimitiveKind.NETHER,
            syntax.PrimitiveKind.END,
        ):
            return f"{EXECUTION[kind]} <{where}>"
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
        case syntax.Array(element=syntax.Primitive(kind=kind)) if kind in ARRAYS:
            return f"{ICONS[kind]}-array"
        case syntax.Array() | syntax.List() | syntax.Tuple():
            return "list"
        case syntax.Primitive(kind=kind):
            return ICONS.get(kind, "any")
    return "any"

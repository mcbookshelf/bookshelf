from . import syntax
from .models import Module, Storage

NUMBER_TYPE = "(byte | short | int | long | float | double)"


def render_module(module: Module) -> str:
    return "\n".join(render_storage(s) for s in module.storages.values())


def render_storage(storage: Storage) -> str:
    struct = render_struct(storage.struct, 0)
    return f"dispatch minecraft:storage[{storage.id}] to {struct}\n"


def render_struct(struct: syntax.Struct, depth: int) -> str:
    pad = "\t" * (depth + 1)
    lines = ["struct {"]
    for entry in struct.entries:
        description = (entry.description or "").splitlines()
        lines.extend(f"{pad}/// {line}" for line in description)
        optional = "?" if entry.optional else ""
        value = render_type(entry.type, depth + 1)
        lines.append(f"{pad}{entry.name}{optional}: {value},")
    lines.append(f"{'\t' * depth}}}")
    return "\n".join(lines)


def render_type(value: syntax.Type, depth: int = 0) -> str:
    match value:
        case syntax.Primitive(kind=kind, range=bounds):
            name = NUMBER_TYPE if kind is syntax.PrimitiveKind.NUMBER else kind
            return f"{name}{syntax.bounded(bounds)}"
        case syntax.Array(element=element, size=size):
            return f"{render_type(element, depth)}[]{syntax.bounded(size)}"
        case syntax.List(element=element, size=size):
            return f"[{render_type(element, depth)}]{syntax.bounded(size)}"
        case syntax.Tuple(elements=elements):
            return f"[{', '.join(render_type(e, depth) for e in elements)}]"
        case syntax.Union(members=members):
            return f"({' | '.join(render_type(m, depth) for m in members)})"
        case syntax.Struct():
            return render_struct(value, depth)

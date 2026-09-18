from beet import Context

from mcbookshelf import constants
from mcbookshelf.meta import Module, models, syntax

from . import ensure_function, ensure_function_tag


def beet_default(ctx: Context) -> None:
    module: Module = ctx.meta["module"]

    for feature in module.functions:
        key = f"{module.id}:{feature.name}"
        ensure_function_tag(ctx, key, [f"{key}/__main__"])

        slot = feature.input_macro or feature.input_storage
        if slot and slot.target and isinstance(slot.type, syntax.Struct):
            ensure_function(ctx, f"{key}/__macro__", commands(key, slot.target, slot.type))
            ensure_function_tag(ctx, f"{key}{constants.MACRO_SUFFIX}", [f"{key}/__macro__"])


def argument(entry: syntax.Entry) -> str:
    value = f'"$({entry.name})"' if models.is_string(entry.type) else f"$({entry.name})"
    return f"{entry.name}:{value}"


def required(struct: syntax.Struct) -> str | None:
    fields = [argument(e) for e in struct.entries if not e.optional]
    return f"{{{ ",".join(fields)}}}" if fields else None


def commands(key: str, target: models.Target, struct: syntax.Struct) -> list[str]:
    start = f"$data modify storage {target.display}"
    value = required(struct)
    lines = [f"{start} set value {value}"] if value else []
    if any(e.optional for e in struct.entries):
        lines.append(f"{start} merge value $(with)")
    return [*lines, f"function #{key}"]

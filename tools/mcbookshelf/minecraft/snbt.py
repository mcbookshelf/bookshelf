import re
from collections.abc import Mapping, Sequence
from dataclasses import asdict, is_dataclass
from functools import singledispatch

KEY = re.compile(r"[A-Za-z0-9._+-]+")


@singledispatch
def dumps(value: object) -> str:
    """Render a value as compact SNBT, as commands take it: `{type:"mul",inputs:[0.5,2]}`."""
    if is_dataclass(value) and not isinstance(value, type):
        return dumps(asdict(value))
    raise TypeError(f"cannot render {value!r} as SNBT")


@dumps.register
def _(value: bool) -> str:  # noqa: FBT001
    return "true" if value else "false"


@dumps.register
def _(value: int) -> str:
    return repr(value)


@dumps.register
def _(value: float) -> str:
    """The shortest double that reads back exactly, like `1.`, `.5`, `-.25` or `1e-5`."""
    mantissa, _, exponent = repr(value).partition("e")
    if exponent:
        return f"{mantissa.removesuffix('.0')}e{int(exponent)}"
    mantissa = mantissa.removesuffix("0") if mantissa.endswith(".0") else mantissa
    return re.sub(r"^(-?)0\.(?=\d)", r"\1.", mantissa)


@dumps.register
def _(value: str) -> str:
    return '"' + value.replace("\\", "\\\\").replace('"', '\\"') + '"'


@dumps.register
def _(value: Mapping) -> str:
    pairs = (
        f"{k if isinstance(k, str) and KEY.fullmatch(k) else dumps(str(k))}:{dumps(v)}"
        for k, v in value.items()
        if v is not None
    )
    return f"{{{','.join(pairs)}}}"


@dumps.register
def _(value: Sequence) -> str:
    return f"[{','.join(map(dumps, value))}]"

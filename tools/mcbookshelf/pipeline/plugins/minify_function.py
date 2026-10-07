from collections.abc import Generator

from beet import Context


def beet_default(ctx: Context) -> Generator[None]:
    yield

    for function in ctx.data.functions.values():
        function.set_content(minify(function.text.splitlines()))


def minify(lines: list[str]) -> list[str]:
    """Drop comments and blank lines, joining continued lines as Minecraft does."""
    kept = []
    pending = None
    for raw in lines:
        line = raw.strip()
        if pending is not None:
            line, pending = pending + line, None
        if line.endswith("\\"):
            pending = line[:-1]
        elif line and not line.startswith("#"):
            kept.append(line)
    if pending is not None:
        kept.append(f"{pending}\\")
    return kept

from collections.abc import Generator

from beet import Context, TagFile


def beet_default(ctx: Context) -> Generator:
    """Set the replace flag to True for all tags."""
    yield
    for _, file in ctx.data.all(f"{ctx.directory.name}:*", extend=TagFile): # type: ignore[type-var]
        pos = list(file.data.keys()).index("values")
        items = list(file.data.items())
        items.insert(pos, ("replace", True))
        file.set_content(dict(items))

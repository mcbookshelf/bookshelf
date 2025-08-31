from __future__ import annotations

import re
from typing import TYPE_CHECKING

from bookshelf.definitions import DOC_DIR, MC_VERSIONS, RELEASE_DIR, VERSION
from bookshelf.services.publishers import PublishSpec

if TYPE_CHECKING:
    from collections.abc import Generator

    from beet import Context


def beet_default(ctx: Context) -> Generator:
    """Build pack to output then attempt to publish them to platforms."""
    yield
    if pack := ctx.data or ctx.assets:
        pack.name = f"{pack.name}-{MC_VERSIONS[-1]}-v{VERSION}"
        file = pack.save(RELEASE_DIR, overwrite=True)

        publish = ctx.meta["publish"]
        publish(PublishSpec(
            file=file,
            name=f"Bookshelf {ctx.meta.get('name', '')}".strip(),
            kind="datapack" if ctx.data else "resourcepack",
            slug=ctx.meta["slug"],
            icon=ctx.directory / "pack.png",
            readme=ctx.directory / "README.md",
            changelog=create_specialized_changelog(ctx.directory.name),
            description=ctx.meta.get("description", ""),
            documentation=ctx.meta.get("documentation", ""),
        ))


def create_specialized_changelog(module: str) -> str:
    """Create a changelog specific to the given module."""
    changelog = (DOC_DIR / f"changelog/v{VERSION}.md").read_text("utf-8")
    sections = re.split(r"(###.*?)$", changelog, flags=re.MULTILINE)
    return sections.pop(0) + "".join(
        "".join(sections[i:i+2])
        for i in range(0, len(sections) - 1, 2)
        if module in sections[i]
    ) if module.startswith("bs.") else changelog

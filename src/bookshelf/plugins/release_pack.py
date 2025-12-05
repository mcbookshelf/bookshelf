from __future__ import annotations

import re
from collections.abc import Callable  # noqa: TC003
from pathlib import Path  # noqa: TC003
from typing import TYPE_CHECKING

from beet import Context, PluginOptions, configurable

from bookshelf.definitions import DOC_DIR, MC_VERSIONS, VERSION
from bookshelf.services.publishers import PublishSpec

if TYPE_CHECKING:
    from collections.abc import Generator


class ReleaseOptions(PluginOptions):
    """Options for the release pack plugin."""

    output: Path
    enqueue: Callable[[PublishSpec], None]


@configurable("release", validator=ReleaseOptions)
def beet_default(ctx: Context, opts: ReleaseOptions) -> Generator:
    """Build pack to output then attempt to publish them to platforms."""
    yield
    for pack in list(filter(None, ctx.packs)):
        pack.name = f"{pack.name}-{MC_VERSIONS[-1]}-v{VERSION}"
        file = pack.save(opts.output, overwrite=True, zipped=True)

        opts.enqueue(PublishSpec(
            file=file,
            name=f"Bookshelf {ctx.meta.get('name', '')}".strip(),
            kind="datapack" if ctx.data else "resourcepack",
            slug=ctx.meta["slug"],
            icon=ctx.directory / "pack.png",
            readme=ctx.directory / "README.md",
            changelog=make_changelog(ctx.directory.name),
            description=ctx.meta.get("description", ""),
            documentation=ctx.meta.get("documentation", ""),
        ))


def make_changelog(module: str) -> str:
    """Create a changelog specific to the given module."""
    file = DOC_DIR / f"changelog/v{VERSION}.md"
    changelog = file.read_text("utf-8")
    sections = re.split(r"(###.*?)$", changelog, flags=re.MULTILINE)

    return sections.pop(0) + "".join(
        "".join(sections[i:i+2])
        for i in range(0, len(sections) - 1, 2)
        if module in sections[i]
    ) if module.startswith("bs.") else changelog

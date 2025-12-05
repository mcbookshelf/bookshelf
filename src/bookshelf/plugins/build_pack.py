
from __future__ import annotations

from pathlib import Path  # noqa: TC003
from typing import TYPE_CHECKING

from beet import Context, PluginOptions, configurable
from beet.contrib.link import LinkManager

if TYPE_CHECKING:
    from collections.abc import Generator


class BuildOptions(PluginOptions):
    """Options for building packs."""

    output: Path
    tests: bool = True
    link: bool = True


@configurable("build", validator=BuildOptions)
def beet_default(ctx: Context, opts: BuildOptions) -> Generator:
    """Plugin that outputs the data pack and the resource pack in a local directory."""
    if opts.tests:
        ctx.require("bookshelf.plugins.include_tests")
    yield

    link = ctx.inject(LinkManager)
    for pack, link_directory in zip(
        ctx.packs,
        [link.resource_pack, link.data_pack],
        strict=True,
    ):
        if pack:
            pack.save(opts.output, overwrite=True)
            if opts.link and link_directory:
                link.dirty.append(str(pack.save(link_directory, overwrite=True)))

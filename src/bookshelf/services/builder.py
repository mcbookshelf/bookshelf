# ruff: noqa: TC003
from __future__ import annotations

from pathlib import Path
from typing import Any

from beet import PackConfig, Project, ProjectBuilder, ProjectConfig
from beet.contrib.link import LinkManager
from pydantic import BaseModel, Field

from bookshelf.definitions import EXAMPLES_DIR, MODULES_DIR, ROOT_DIR


class BuildOptions(BaseModel):
    """Configuration controlling how the build process operates."""

    pipeline: list[str] = Field(default_factory=list)
    require: list[str] = Field(default_factory=list)
    meta: dict[str, Any] = Field(default_factory=dict)
    output: Path | None = None
    zipped: bool = False


def clean_links() -> None:
    """Remove the previously linked files and folders."""
    project = Project(ProjectConfig().resolve(ROOT_DIR))
    LinkManager(project.cache).clean()


def make_pack_config(*, zipped: bool) -> PackConfig:
    """Generate a Beet pack configuration with optional compression."""
    return PackConfig(
        compression="deflate",
        compression_level=9,
        zipped=True,
    ) if zipped else PackConfig()


def build_module(module: str, options: BuildOptions) -> None:
    """Run the Beet build pipeline for a single module."""
    with ProjectBuilder(Project(ProjectConfig(
        extend="module.json", # type: ignore[arg-type]
        broadcast=[MODULES_DIR / module], # type: ignore[arg-type]
        data_pack=make_pack_config(zipped=options.zipped),
        resource_pack=make_pack_config(zipped=options.zipped),
        pipeline=[*options.pipeline],
        require=[*options.require, "bookshelf.plugins.update_mcmeta"],
        meta=options.meta,
        output=options.output,
    ).resolve(ROOT_DIR)), root=False).build():
        pass


def build_example(example: str, options: BuildOptions) -> None:
    """Run the Beet build pipeline for a single example."""
    with ProjectBuilder(Project(ProjectConfig(
        broadcast=[EXAMPLES_DIR / f"{example}.md"], # type: ignore[arg-type]
        data_pack=make_pack_config(zipped=options.zipped),
        resource_pack=make_pack_config(zipped=options.zipped),
        pipeline=[*options.pipeline, "lectern"],
        require=[*options.require, "lectern.contrib.require"],
        meta={**options.meta, "lectern": {"load": "."}},
        output=options.output,
    ).resolve(ROOT_DIR)), root=False).build():
        pass

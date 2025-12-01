# ruff: noqa: TC003
from __future__ import annotations

from collections.abc import Iterable
from pathlib import Path
from typing import Any

from beet import PackConfig, Project, ProjectBuilder, ProjectConfig
from pydantic import BaseModel, Field

from bookshelf.definitions import EXAMPLES_DIR, MODULES_DIR, ROOT_DIR


class BaseBuilder(BaseModel):
    """Base class for build process implementations."""

    pipeline: list[str] = Field(default_factory=list)
    require: list[str] = Field(default_factory=list)
    meta: dict[str, Any] = Field(default_factory=dict)
    output: Path | None = None
    zipped: bool = False

    def build(self, _: Iterable[str]) -> None:
        """Run the Beet build pipeline for multiple entries."""
        raise NotImplementedError

    def clean_links(self) -> None:
        """Remove the previously linked files and folders."""
        project = Project(ProjectConfig().resolve(ROOT_DIR))
        with ProjectBuilder(project=project, root=True).build():
            pass

    def make_pack_config(self, *, zipped: bool) -> PackConfig:
        """Generate a Beet pack configuration with optional compression."""
        return PackConfig(
            compression="deflate",
            compression_level=9,
            zipped=True,
        ) if zipped else PackConfig()


class ModuleBuilder(BaseBuilder):
    """Builder for modules."""

    def build(self, modules: Iterable[str]) -> None:
        """Run the Beet build pipeline for a single module."""
        self.clean_links()
        for module in modules:
            with ProjectBuilder(Project(ProjectConfig(
                id=module,
                output=self.output,
                extend="module.json",
                broadcast=[MODULES_DIR / module],
                data_pack=self.make_pack_config(zipped=self.zipped),
                resource_pack=self.make_pack_config(zipped=self.zipped),
                pipeline=[*self.pipeline],
                require=[*self.require, "bookshelf.plugins.update_mcmeta"],
                meta=self.meta,
            ).resolve(ROOT_DIR)), root=False).build():
                pass


class ExampleBuilder(BaseBuilder):
    """Builder for examples."""

    def build(self, examples: Iterable[str]) -> None:
        """Run the Beet build pipeline for a single example."""
        self.clean_links()
        for example in examples:
            with ProjectBuilder(Project(ProjectConfig(
                id=example,
                output=self.output,
                broadcast=[EXAMPLES_DIR / f"{example}.md"],
                data_pack=self.make_pack_config(zipped=self.zipped),
                resource_pack=self.make_pack_config(zipped=self.zipped),
                meta={**self.meta, "lectern": {"load": "."}},
                pipeline=["lectern", *self.pipeline],
                require=[
                    "lectern.contrib.require",
                    *self.require,
                    "bookshelf.plugins.update_mcmeta",
                ],
            ).resolve(ROOT_DIR)), root=False).build():
                pass

from __future__ import annotations

from typing import TYPE_CHECKING, Any

from beet import Context, PackConfig, Project, ProjectBuilder, ProjectConfig
from pydantic import BaseModel, Field

from bookshelf.definitions import EXAMPLES_DIR, MODULES_DIR, ROOT_DIR

if TYPE_CHECKING:
    from collections.abc import Iterable


class BaseBuilder(BaseModel):
    """Base class for build process implementations."""

    require: list[str] = Field(default_factory=list)
    pipeline: list[str] = Field(default_factory=list)
    meta: dict[str, Any] = Field(default_factory=dict)
    zipped: bool = False

    def run(self, ctx: Context, entries: Iterable[str]) -> None:
        """Run the Beet build pipeline for multiple entries."""
        raise NotImplementedError

    def build(self, entries: Iterable[str]) -> None:
        """Run the builder for multiple entries."""
        project = Project(ProjectConfig().resolve(ROOT_DIR))
        with ProjectBuilder(project=project, root=True).build() as ctx:
            self.run(ctx, entries)

    def make_pack_config(self, *, zipped: bool) -> PackConfig:
        """Generate a Beet pack configuration with optional compression."""
        return PackConfig(
            compression="deflate",
            compression_level=9,
            zipped=True,
        ) if zipped else PackConfig()


class ModuleBuilder(BaseBuilder):
    """Builder for modules."""

    def run(self, _: Context, modules: Iterable[str]) -> None:
        """Run the Beet build pipeline the given modules."""
        for module in modules:
            with ProjectBuilder(Project(ProjectConfig(
                extend="module.json",
                data_pack=self.make_pack_config(zipped=self.zipped),
                resource_pack=self.make_pack_config(zipped=self.zipped),
                require=[*self.require, "bookshelf.plugins.update_mcmeta"],
                pipeline=self.pipeline,
                meta={**self.meta, "autosave": {"link": False}},
            ).resolve(MODULES_DIR / module))).build():
                pass


class ExampleBuilder(BaseBuilder):
    """Builder for examples."""

    def run(self, _: Context, examples: Iterable[str]) -> None:
        """Run the Beet build pipeline for a single example."""
        for example in examples:
            with ProjectBuilder(Project(ProjectConfig(
                data_pack=self.make_pack_config(zipped=self.zipped),
                resource_pack=self.make_pack_config(zipped=self.zipped),
                require=["lectern.contrib.require", *self.require],
                pipeline=["lectern", *self.pipeline],
                meta={
                    **self.meta,
                    "autosave": {"link": False},
                    "lectern": {"load": "."},
                },
            ).resolve(EXAMPLES_DIR / f"{example}.md"))).build():
                pass

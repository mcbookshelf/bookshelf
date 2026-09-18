from collections.abc import Iterable
from dataclasses import dataclass, replace
from pathlib import Path
from typing import Any

from beet import PackConfig, ProjectConfig

from mcbookshelf import constants, workspace

PLUGINS = f"{__package__}.plugins"


@dataclass(frozen=True)
class Build:

    tests: bool = True
    minify: bool = False
    zipped: bool = False
    versioned: bool = False
    link: bool = False
    experimental: bool = True

    @property
    def nested(self) -> Build:
        return replace(self, zipped=False, link=False)


def module_config(name: str, options: Build, *, output: Path | None = None) -> ProjectConfig:
    module = workspace.load_module(name)
    return _config(
        name,
        pack=module.id,
        directory=workspace.directory(name),
        description=module.description,
        version=module.version,
        load=True,
        build=options,
        output=output,
        pipeline=(
            f"{PLUGINS}.load_templates",
            f"{PLUGINS}.load_plugins",
            f"{PLUGINS}.gen_entry",
            f"{PLUGINS}.gen_help",
            f"{PLUGINS}.gen_test",
            f"{PLUGINS}.gen_load",
            f"{PLUGINS}.gen_unload",
            f"{PLUGINS}.include_deps",
            f"{PLUGINS}.update_mcmeta",
            f"{PLUGINS}.update_tags",
        ),
    )


def bundle_config(name: str, options: Build, *, output: Path | None = None) -> ProjectConfig:
    bundle = workspace.load_bundle(name)
    return _config(
        name,
        pack=bundle.id,
        directory=workspace.directory(name),
        description=bundle.description,
        version=bundle.version,
        build=options,
        output=output,
        members=workspace.members(name),
        pipeline=(f"{PLUGINS}.make_bundle", f"{PLUGINS}.update_mcmeta"),
    )


def example_config(name: str, options: Build, *, output: Path | None = None) -> ProjectConfig:
    return _config(
        name,
        pack=f"example-{name}",
        directory=constants.EXAMPLES_DIR,
        version=workspace.release_version(),
        build=options,
        output=output,
        pipeline=("lectern",),
        require=("lectern.contrib.require",),
        meta={"lectern": {"load": f"{name}.md"}},
    )


def ward_config(names: Iterable[str]) -> ProjectConfig:
    """The configuration of every module in one pack, for the game tests."""
    return _config(
        "bookshelf",
        pack="bookshelf",
        directory=constants.MODULES_DIR,
        version=workspace.release_version(),
        build=Build(),
        members=tuple(names),
        pipeline=(f"{PLUGINS}.make_bundle", f"{PLUGINS}.update_mcmeta"),
    )


def _config(  # noqa: PLR0913
    name: str,
    *,
    pack: str,
    directory: Path,
    version: str,
    build: Build,
    description: str = "",
    load: bool = False,
    output: Path | None = None,
    pipeline: tuple[str, ...] = (),
    require: tuple[str, ...] = (),
    members: tuple[str, ...] = (),
    meta: dict[str, Any] | None = None,
) -> ProjectConfig:
    required = [*require]
    if build.tests:
        required.append("mcward.beet.plugin")
    return ProjectConfig(
        id=pack,
        name=name,
        description=description,
        version=version,
        output=output,
        require=required,
        pipeline=[*pipeline, *_plugins(build)],
        data_pack=_pack(pack, version, build, load=load),
        meta={**(meta or {}), **_meta(name, members, build)},
    ).resolve(directory)


def _meta(name: str, members: tuple[str, ...], build: Build) -> dict[str, Any]:
    meta = {"build": build, "autosave": {"link": build.link}}
    if members:
        meta["members"] = list(members)
    elif name in workspace.modules():
        meta["module"] = workspace.load_module(name)
    return meta


def _pack(pack: str, version: str, build: Build, *, load: bool) -> PackConfig:
    data = {"name": pack}
    if load:
        data["load"] = ["."]
    if build.versioned:
        data["name"] = f"{pack}-v{version}+{constants.GAME_VERSION}"
    if build.zipped:
        data.update(zipped=True, compression="deflate", compression_level=9)
    return PackConfig.model_validate(data)


def _plugins(build: Build) -> list[str]:
    plugins = []
    if not build.tests:
        plugins.append(f"{PLUGINS}.strip_test_registries")
    if build.minify:
        plugins.append(f"{PLUGINS}.minify_json")
    if not build.experimental:
        plugins.append(f"{PLUGINS}.strip_experimental")
    return plugins

from collections.abc import Callable, Iterable
from pathlib import Path

from beet import Context, Project, ProjectBuilder, ProjectCache, ProjectConfig

from mcbookshelf import constants, workspace

from .artifacts import write_manifest, write_stub
from .config import Build, bundle_config, example_config, module_config

type Report = Callable[[str, str | None], None]


def build(
    name: str,
    options: Build,
    report: Report,
    output: Path | None = None,
) -> Context | None:
    """Build one module, bundle or example and report the outcome."""
    try:
        config = config_for(name, options, output=output)
        with ProjectBuilder(project(config), root=True).build() as ctx:
            pass
    except Exception as error:  # noqa: BLE001
        report(name, str(error))
        return None
    report(name, None)
    return ctx


def release(
    names: Iterable[str],
    options: Build,
    report: Report,
    output: Path,
) -> None:
    """Build modules, bundles, stubs, and write the manifest."""
    built = {}
    for name in (*names, *workspace.bundles()):
        if ctx := build(name, options, report, output=output):
            built[name] = ctx
            write_stub(name, ctx, output)
    modules = {name: ctx for name, ctx in built.items() if name in workspace.modules()}
    bundles = {name: ctx for name, ctx in built.items() if name in workspace.bundles()}
    write_manifest(modules, bundles, output)


def project(config: ProjectConfig) -> Project:
    """Make a root project whose cache lives at the repository root."""
    cache = ProjectCache(
        directory=constants.BEET_CACHE_DIR,
        generated_directory=Path(config.directory) / "generated",
    )
    return Project(resolved_config=config, resolved_cache=cache)


def config_for(name: str, options: Build, *, output: Path | None = None) -> ProjectConfig:
    """The configuration of a module, a bundle or an example, whichever `name` is."""
    if name in workspace.modules():
        return module_config(name, options, output=output)
    if name in workspace.bundles():
        return bundle_config(name, options, output=output)
    if name in workspace.examples():
        return example_config(name, options, output=output)
    raise ValueError(f"Unknown module, bundle, or example: {name}")

from collections.abc import Iterable
from functools import cache
from pathlib import Path

from mcbookshelf import constants, meta
from mcbookshelf.meta import Bundle, Module
from mcbookshelf.workspace import dependencies


def modules() -> tuple[str, ...]:
    """Ids of the modules."""
    return tuple(sorted(_modules()))


def bundles() -> tuple[str, ...]:
    """Ids of the bundles."""
    return tuple(sorted(_bundles()))


def released() -> tuple[str, ...]:
    """Ids of the modules at 1.0.0 or above."""
    return tuple(m for m in modules() if load_module(m).released)


def examples() -> tuple[str, ...]:
    """Names of the lectern examples."""
    if not constants.EXAMPLES_DIR.is_dir():
        return ()
    return tuple(sorted(f.stem for f in constants.EXAMPLES_DIR.glob("*.md")))


def directory(name: str) -> Path:
    """Locate the sources of a module or bundle by its id."""
    directory = _modules().get(name) or _bundles().get(name)
    if directory is None:
        raise KeyError(f"Unknown module or bundle: {name}")
    return directory


def file(name: str) -> Path:
    """Locate the metadata file of a module or bundle."""
    kind = constants.BUNDLE_FILE if name in _bundles() else constants.MODULE_FILE
    return directory(name) / kind


@cache
def load_module(name: str) -> Module:
    """Metadata of a module, parsed once and only when asked for."""
    return meta.load_module(_modules()[name] / constants.MODULE_FILE)


@cache
def load_bundle(name: str) -> Bundle:
    """Metadata of a bundle, parsed once and only when asked for."""
    return meta.load_bundle(_bundles()[name] / constants.BUNDLE_FILE)


def suite() -> Bundle:
    """Find the suite bundle: the release is versioned after it."""
    suites = [b for b in map(load_bundle, bundles()) if b.suite]
    if len(suites) != 1:
        raise ValueError("one single bundle must select every module with 'tags: *'")
    return suites[0]


def members(name: str) -> tuple[str, ...]:
    """Ids of the released modules a bundle selects, at least one."""
    bundle = load_bundle(name)
    selected = select(bundle, (load_module(m) for m in modules()))
    if not selected:
        where = meta.diagnostics.locate(directory(name) / constants.BUNDLE_FILE, None)
        raise ValueError(f"{where}: no module carries the tags {', '.join(bundle.tags)}")
    return tuple(m.id for m in selected)


def select(bundle: Bundle, candidates: Iterable[Module]) -> tuple[Module, ...]:
    """Keep the released modules carrying any tag of the bundle, or all for `*`."""
    tags = set(bundle.tags)
    return tuple(
        m
        for m in candidates
        if m.released and (bundle.suite or tags & set(m.tags))
    )


def forget() -> None:
    """Drop everything read from the repository, so the next call reads it again."""
    from mcbookshelf.workspace import history, ownership  # noqa: PLC0415

    for cached in (
        _modules,
        _bundles,
        load_module,
        load_bundle,
        history.changed_files,
        history.bundle_at,
        history.modules_at,
        history.members_at,
        history.previous_tag,
        ownership.index,
        ownership.sources,
        dependencies.strong,
    ):
        cached.cache_clear()

@cache
def _modules() -> dict[str, Path]:
    files = constants.MODULES_DIR.glob(f"*/{constants.MODULE_FILE}")
    return {file.parent.name: file.parent for file in sorted(files)}


@cache
def _bundles() -> dict[str, Path]:
    files = constants.MODULES_DIR.glob(f"*/{constants.BUNDLE_FILE}")
    return {file.parent.name: file.parent for file in sorted(files)}

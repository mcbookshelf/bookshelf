from collections.abc import Callable, Hashable, Iterable
from functools import cache, wraps
from pathlib import Path
from typing import Any, Concatenate

from mcbookshelf import constants, meta
from mcbookshelf.meta import Bundle, Module


def cached[**P, R](
    function: Callable[Concatenate[Workspace, P], R],
) -> Callable[Concatenate[Workspace, P], R]:
    """Cache a function of a workspace on the workspace itself: a new one reads everything again."""

    @wraps(function)
    def wrapper(ws: Workspace, *args: P.args, **kwargs: P.kwargs) -> R:
        key = (function, args, frozenset(kwargs.items()))
        if key not in ws.cache:
            ws.cache[key] = function(ws, *args, **kwargs)
        return ws.cache[key]

    return wrapper


class Workspace:
    """The repository as read once: its modules, bundles and examples."""

    def __init__(self) -> None:
        self.cache: dict[Hashable, Any] = {}

    def modules(self) -> tuple[str, ...]:
        """Ids of the modules."""
        return tuple(sorted(self._modules()))

    def bundles(self) -> tuple[str, ...]:
        """Ids of the bundles."""
        return tuple(sorted(self._bundles()))

    def released(self) -> tuple[str, ...]:
        """Ids of the modules at 1.0.0 or above."""
        return tuple(m for m in self.modules() if self.load_module(m).released)

    def examples(self) -> tuple[str, ...]:
        """Names of the lectern examples."""
        if not constants.EXAMPLES_DIR.is_dir():
            return ()
        return tuple(sorted(f.stem for f in constants.EXAMPLES_DIR.glob("*.md")))

    def directory(self, name: str) -> Path:
        """Locate the sources of a module or bundle by its id."""
        directory = self._modules().get(name) or self._bundles().get(name)
        if directory is None:
            raise KeyError(f"Unknown module or bundle: {name}")
        return directory

    def file(self, name: str) -> Path:
        """Locate the metadata file of a module or bundle."""
        kind = constants.BUNDLE_FILE if name in self._bundles() else constants.MODULE_FILE
        return self.directory(name) / kind

    @cached
    def load_module(self, name: str) -> Module:
        """Metadata of a module, parsed once and only when asked for."""
        return meta.load_module(self._modules()[name] / constants.MODULE_FILE)

    @cached
    def load_bundle(self, name: str) -> Bundle:
        """Metadata of a bundle, parsed once and only when asked for."""
        return meta.load_bundle(self._bundles()[name] / constants.BUNDLE_FILE)

    def suite(self) -> Bundle:
        """Find the suite bundle: the release is versioned after it."""
        suites = [b for b in map(self.load_bundle, self.bundles()) if b.suite]
        if len(suites) != 1:
            raise ValueError("one single bundle must select every module with 'tags: *'")
        return suites[0]

    def members(self, name: str) -> tuple[str, ...]:
        """Ids of the released modules a bundle selects, at least one."""
        bundle = self.load_bundle(name)
        selected = select(bundle, (self.load_module(m) for m in self.modules()))
        if not selected:
            where = meta.diagnostics.locate(self.file(name), None)
            raise ValueError(f"{where}: no module carries the tags {', '.join(bundle.tags)}")
        return tuple(m.id for m in selected)

    @cached
    def _modules(self) -> dict[str, Path]:
        files = constants.MODULES_DIR.glob(f"*/{constants.MODULE_FILE}")
        return {file.parent.name: file.parent for file in sorted(files)}

    @cached
    def _bundles(self) -> dict[str, Path]:
        files = constants.MODULES_DIR.glob(f"*/{constants.BUNDLE_FILE}")
        return {file.parent.name: file.parent for file in sorted(files)}


@cache
def current() -> Workspace:
    """The workspace of this process; `current.cache_clear()` makes the next call read it again."""
    return Workspace()


def select(bundle: Bundle, candidates: Iterable[Module]) -> tuple[Module, ...]:
    """Keep the released modules carrying any tag of the bundle, or all for `*`."""
    tags = set(bundle.tags)
    return tuple(
        m
        for m in candidates
        if m.released and (bundle.suite or tags & set(m.tags))
    )

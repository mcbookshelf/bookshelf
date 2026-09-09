from collections import defaultdict
from collections.abc import Collection, Iterable, Iterator
from dataclasses import dataclass, field
from functools import cache

from beet import Context

from mcbookshelf import constants, workspace
from mcbookshelf.meta import Feature, MetadataError, Module
from mcbookshelf.references import (
    Index,
    Owner,
    Reason,
    Reference,
    Resolution,
    longest_prefix,
    parse,
)
from mcbookshelf.workspace import history

type FileText = tuple[str, str | None]

HOOKS = frozenset({"__load__", "__unload__"})
SOURCE_SUFFIXES = frozenset({".mcfunction", ".json"})
TEST_REGISTRIES = frozenset({"test", "test_environment", "test_instance"})


@dataclass(frozen=True, slots=True)
class Location:

    registry: str
    parts: tuple[str, ...]
    feature: str | None

    @property
    def public(self) -> bool:
        """Whether the file is part of the API: a tag, predicate or loot table, not private."""
        if self.registry == "function" or not self.parts:
            return False
        return not any(part.startswith(constants.PRIVATE_PREFIX) for part in self.parts)

    @property
    def hook(self) -> bool:
        """Whether the file is `__load__` or `__unload__`, generated and not analyzed."""
        if self.registry != "function" or len(self.parts) != 1:
            return False
        return self.parts[0].partition(".")[0] in HOOKS


@dataclass(frozen=True, slots=True)
class Occurrence:
    """One reference found in a file, and what it resolved to."""

    path: str
    reference: Reference
    resolution: Resolution

    @property
    def message(self) -> str:
        where = f"{self.path}:{self.reference.line}"
        return f"{where}: '{self.reference.id}' cannot be attributed: {self.resolution}"


@dataclass
class Ownership:
    """The files of a module by owner, and the references each owner makes."""

    module: Module
    files: dict[Owner, list[str]] = field(default_factory=dict)
    references: dict[Owner, list[Occurrence]] = field(default_factory=dict)

    @property
    def shared(self) -> Owner:
        """The owner of the files that belong to no feature."""
        return Owner(self.module.id)

    @property
    def problems(self) -> list[Occurrence]:
        """The references that could not be attributed to an owner."""
        return [
            occurrence
            for occurrences in self.references.values()
            for occurrence in occurrences
            if isinstance(occurrence.resolution, Reason)
        ]

    @property
    def targets(self) -> set[Owner]:
        """Every owner the module references, in any of its files."""
        return {target for owner in self.references for target in self.dependencies(owner)}

    def dependencies(self, owner: Owner) -> set[Owner]:
        """The owners one owner references, itself and the shared part left out."""
        targets = {
            occurrence.resolution
            for occurrence in self.references.get(owner, ())
            if isinstance(occurrence.resolution, Owner)
        }
        return targets - {owner, self.shared}

    def without(self, paths: Collection[str]) -> Ownership:
        """The same ownership once the given files are removed from the pack."""
        return Ownership(
            self.module,
            {o: [p for p in files if p not in paths] for o, files in self.files.items()},
            {o: [r for r in refs if r.path not in paths] for o, refs in self.references.items()},
        )


class OwnershipError(ValueError):
    """References that could not be attributed, which the release refuses."""

    def __init__(self, problems: Iterable[Occurrence]) -> None:
        super().__init__("\n".join(p.message for p in problems))


@cache
def sources(name: str) -> Ownership:
    """Ownership of a module's sources, analyzed once."""
    return analyze(name)


def analyze(name: str, files: Iterable[FileText] | None = None) -> Ownership:
    """Attribute files to owners and resolve their references; sources by default."""
    module = workspace.load_module(name)
    known = index()
    owned: dict[Owner, list[str]] = defaultdict(list)
    occurrences: dict[Owner, list[Occurrence]] = defaultdict(list)
    for path, text in source_files(name) if files is None else files:
        location = locate_in(name, path)
        if location is None:
            continue
        owner = Owner(name, location.feature)
        owned[owner].append(path)
        if text is None or location.hook:
            continue
        for reference in parse(text):
            resolution = known.resolve(reference)
            occurrences[owner].append(Occurrence(path, reference, resolution))
    files_by_owner = {owner: sorted(paths) for owner, paths in owned.items()}
    return Ownership(module, files_by_owner, dict(occurrences))


@cache
def index() -> Index:
    """Index the features of every module, with their macro aliases."""
    suffix = constants.MACRO_SUFFIX
    features = {name: _features(name) for name in workspace.modules()}
    return Index(
        {name: frozenset(f.name for f in declared) for name, declared in features.items()},
        {
            name: {f"{f.name}{suffix}": f.name for f in declared if f.macro_struct}
            for name, declared in features.items()
        },
    )


def _features(name: str) -> tuple[Feature, ...]:
    """Features of a module, none when it does not load: it is still a known module."""
    try:
        return workspace.load_module(name).features
    except MetadataError:
        return ()


def locate_in(name: str, path: str) -> Location | None:
    """Locate a path of the module, unless it is a test or lies outside its data."""
    prefix = f"data/{name}/"
    if not path.startswith(prefix):
        return None
    location = locate(path.removeprefix(prefix), workspace.load_module(name).names)
    return None if location.registry in TEST_REGISTRIES else location


def locate(path: str, features: Collection[str] = ()) -> Location:
    """Locate a path under `data/<module>/`: functions by folder, other files by name."""
    parts = path.replace("\\", "/").strip("/").split("/")
    width = 2 if parts[0] == "tags" else 1
    registry, rest = "/".join(parts[:width]), parts[width:]
    if not rest:
        return Location(registry, (), None)
    if registry == "function":
        feature = longest_prefix(features, "/".join(rest[:-1]))
    elif rest[0].startswith(constants.PRIVATE_PREFIX):
        feature = longest_prefix(features, "/".join([rest[0][1:], *rest[1:]]))
    else:
        name = "/".join(rest)
        name = name.rsplit(".", 1)[0] if "." in rest[-1] else name
        if registry == "tags/function":
            name = name.removesuffix(constants.MACRO_SUFFIX)
        feature = name if name in features else None
    return Location(registry, tuple(rest), feature)


def pack_files(ctx: Context, name: str) -> Iterator[FileText]:
    """The files of a module in a built pack, with their text when they have one."""
    prefix = f"data/{name}/"
    for path, file in ctx.data.list_files():
        if path.startswith(prefix):
            text = getattr(file, "text", None)
            yield path, text if isinstance(text, str) else None


def source_files(name: str) -> Iterator[FileText]:
    """The source files of a module, with their text."""
    base = workspace.directory(name)
    root = base / "data" / name
    for file in sorted(root.rglob("*")):
        if file.is_file() and file.suffix in SOURCE_SUFFIXES:
            path = file.relative_to(base).as_posix()
            yield path, file.read_text("utf-8", "replace")


def changed_owners(tag: str, name: str) -> dict[Owner, list[str]]:
    """The owners whose files changed since a tag, with those files."""
    changed: dict[Owner, list[str]] = defaultdict(list)
    for path in history.changed_files(tag, name):
        location = locate_in(name, path)
        if location is not None:
            changed[Owner(name, location.feature)].append(path)
    return dict(changed)

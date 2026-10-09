from collections import defaultdict
from collections.abc import Collection, Iterable, Iterator
from dataclasses import dataclass, field

from beet import Context

from mcbookshelf import constants
from mcbookshelf.meta import Feature, MetadataError, Module
from mcbookshelf.references import (
    Index,
    Owner,
    Reason,
    Reference,
    Resolution,
    groups,
    longest_prefix,
    parents,
    parse,
)
from mcbookshelf.workspace import Workspace, cached, history

type FileText = tuple[str, str | None]

HOOKS = frozenset({"__load__", "__unload__"})
ENTRIES = frozenset({"__main__", "__macro__"})
SOURCE_SUFFIXES = frozenset({".mcfunction", ".json"})
TEST_RESOURCES = frozenset({"test", "test_environment", "test_instance"})


@dataclass(frozen=True, slots=True)
class Location:

    resource: str
    parts: tuple[str, ...]
    feature: str | None

    @property
    def requires_feature(self) -> bool:
        """Whether others reach the file by its own id, so a feature must declare it.

        Functions are left out: they are reached through the tag of their feature.
        """
        if self.resource == "function" or not self.parts:
            return False
        return not any(part.startswith(constants.PRIVATE_PREFIX) for part in self.parts)

    @property
    def hook(self) -> bool:
        if self.resource != "function" or len(self.parts) != 1:
            return False
        return self.parts[0].partition(".")[0] in HOOKS


@dataclass(frozen=True, slots=True)
class Occurrence:
    """One reference found in a file, and what it resolved to."""

    path: str
    reference: Reference
    resolution: Resolution

    @property
    def reason(self) -> str:
        return f"'{self.reference.id}' cannot be attributed: {self.resolution}"

    @property
    def message(self) -> str:
        return f"{self.path}:{self.reference.line}: {self.reason}"


@dataclass
class Ownership:
    """The files of a module by owner, and the references each owner makes."""

    module: Module
    files: dict[Owner, list[str]] = field(default_factory=dict)
    references: dict[Owner, list[Occurrence]] = field(default_factory=dict)

    @property
    def shared(self) -> Owner:
        """The owner of the files that belong to no feature and to no group."""
        return Owner(self.module.id)

    @property
    def leaks(self) -> list[Occurrence]:
        """The references to private files of another feature, group or module.

        A feature that calls the entry of another feature of the module depends on it, and may
        use its private files as well.
        """
        return [
            occurrence
            for owner, occurrences in self.references.items()
            for occurrence in occurrences
            if isinstance(target := occurrence.resolution, Owner)
            and _private(occurrence.reference, entries=target.module == self.module.id)
            and target not in {owner, self.shared, *self.parents(owner), *self.called(owner)}
        ]

    def called(self, owner: Owner) -> set[Owner]:
        """The features of the module whose entry an owner calls."""
        return {
            target
            for occurrence in self.references.get(owner, ())
            if isinstance(target := occurrence.resolution, Owner)
            and target.module == self.module.id
            and occurrence.reference.static.rsplit("/", 1)[-1] in ENTRIES
        }

    def parents(self, owner: Owner) -> set[Owner]:
        """The groups of the module an owner lies in."""
        if owner.module != self.module.id:
            return set()
        return parents(owner, groups(self.module.names))

    def shipped(self, owner: Owner) -> list[str]:
        """The files an owner ships: its own and those of its groups."""
        owners = {owner, *self.parents(owner)}
        return sorted(path for o in owners for path in self.files.get(o, ()))

    def needs(self, owner: Owner) -> set[Owner]:
        """What an owner and its groups reference, for the files it ships."""
        owners = {owner, *self.parents(owner)}
        return {target for o in owners for target in self.dependencies(o)} - owners

    @property
    def targets(self) -> set[Owner]:
        """Every owner the module references, in any of its files."""
        return {target for owner in self.references for target in self.dependencies(owner)}

    @property
    def problems(self) -> list[Occurrence]:
        """The references that could not be attributed to an owner."""
        return [
            occurrence
            for occurrences in self.references.values()
            for occurrence in occurrences
            if isinstance(occurrence.resolution, Reason)
        ]

    def dependencies(self, owner: Owner) -> set[Owner]:
        """The owners one owner references, itself, its groups and the shared part left out."""
        targets = {
            occurrence.resolution
            for occurrence in self.references.get(owner, ())
            if isinstance(occurrence.resolution, Owner)
        }
        return targets - {owner, self.shared, *self.parents(owner)}


class OwnershipError(ValueError):
    """References that could not be attributed, which the release refuses."""

    def __init__(self, problems: Iterable[Occurrence]) -> None:
        super().__init__("\n".join(p.message for p in problems))


@cached
def sources(ws: Workspace, name: str) -> Ownership:
    """Ownership of a module's sources, analyzed once."""
    return analyze(ws, name)


def analyze(ws: Workspace, name: str, files: Iterable[FileText] | None = None) -> Ownership:
    """Attribute files to owners and resolve their references; sources by default."""
    module = ws.load_module(name)
    known = index(ws)
    owned: dict[Owner, list[str]] = defaultdict(list)
    occurrences: dict[Owner, list[Occurrence]] = defaultdict(list)
    for path, text in source_files(ws, name) if files is None else files:
        location = locate_in(ws, name, path)
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


@cached
def index(ws: Workspace) -> Index:
    """Index the features of every module, with their macro aliases."""
    return Index.from_ids({
        name: [(f.id, f.aliases) for f in _features(ws, name)] for name in ws.modules()
    })


def _features(ws: Workspace, name: str) -> tuple[Feature, ...]:
    """Features of a module, none when it does not load: it is still a known module."""
    try:
        return ws.load_module(name).features
    except MetadataError:
        return ()


def locate_in(ws: Workspace, name: str, path: str) -> Location | None:
    """Locate a path of the module, unless it is a test or lies outside its data."""
    prefix = f"data/{name}/"
    if not path.startswith(prefix):
        return None
    location = locate(path.removeprefix(prefix), ws.load_module(name).names)
    return None if location.resource in TEST_RESOURCES else location


def locate(path: str, features: Collection[str] = ()) -> Location:
    """Locate a path under `data/<module>/`: functions by folder, other files by name.

    Functions and private files go to the deepest feature or group of features they lie in.
    """
    parts = path.replace("\\", "/").strip("/").split("/")
    width = 2 if parts[0] == "tags" else 1
    resource, rest = "/".join(parts[:width]), parts[width:]
    if not rest:
        return Location(resource, (), None)
    owners = {*features, *groups(features)}
    if resource == "function":
        feature = longest_prefix(owners, "/".join(rest[:-1]))
    elif any(part.startswith(constants.PRIVATE_PREFIX) for part in rest):
        folder = (part.removeprefix(constants.PRIVATE_PREFIX) for part in rest[:-1])
        feature = longest_prefix(owners, "/".join(folder))
    else:
        name = "/".join(rest)
        name = name.rsplit(".", 1)[0] if "." in rest[-1] else name
        if resource == "tags/function":
            name = name.removesuffix(constants.MACRO_SUFFIX)
        feature = name if name in features else None
    return Location(resource, tuple(rest), feature)


def _private(reference: Reference, *, entries: bool) -> bool:
    """Whether a reference reaches a private file: entries of features are public in `entries`."""
    *folders, name = reference.static.split("/")
    if entries and name in ENTRIES:
        return any(part.startswith(constants.PRIVATE_PREFIX) for part in folders)
    return any(part.startswith(constants.PRIVATE_PREFIX) for part in (*folders, name))


def pack_files(ctx: Context, name: str) -> Iterator[FileText]:
    """The files of a module in a built pack, with their text when they have one."""
    prefix = f"data/{name}/"
    for path, file in ctx.data.list_files():
        if path.startswith(prefix):
            text = getattr(file, "text", None)
            yield path, text if isinstance(text, str) else None


@cached
def source_files(ws: Workspace, name: str) -> tuple[tuple[str, str], ...]:
    """The source files of a module with their text, read once."""
    base = ws.directory(name)
    return tuple(
        (file.relative_to(base).as_posix(), file.read_text("utf-8", "replace"))
        for file in sorted((base / "data" / name).rglob("*"))
        if file.is_file() and file.suffix in SOURCE_SUFFIXES
    )


def changed_owners(ws: Workspace, tag: str, name: str) -> dict[Owner, list[str]]:
    """The owners whose files changed since a tag, with those files."""
    changed: dict[Owner, list[str]] = defaultdict(list)
    for path in history.changed_files(ws, tag, name):
        location = locate_in(ws, name, path)
        if location is not None:
            changed[Owner(name, location.feature)].append(path)
    return dict(changed)


def shipped_changes(ws: Workspace, tag: str, name: str) -> dict[Owner, list[str]]:
    """The changed owners a release ships: the experimental features left out."""
    experimental = ws.load_module(name).experimental
    changed = changed_owners(ws, tag, name)
    return {owner: paths for owner, paths in changed.items() if owner.feature not in experimental}

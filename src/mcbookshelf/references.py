import re
from collections.abc import Callable, Iterable, Iterator, Mapping, Sequence
from dataclasses import dataclass, field
from enum import StrEnum

from mcbookshelf.releases import ModuleEntry

REFERENCE = re.compile(
    r"#?\b(?P<namespace>bs\.[a-z0-9_]+):"
    r"(?P<path>(?:[a-z0-9_./-]|\$\([A-Za-z0-9_]*\))+)",
)


type Resolution = Owner | Reason


class Reason(StrEnum):
    """Why a reference could not be resolved to an owner."""

    UNKNOWN_MODULE = "unknown module"
    DYNAMIC_ID = "the feature part is dynamic"
    AMBIGUOUS = "the static part could name a feature or a shared path"


@dataclass(frozen=True, slots=True)
class Reference:
    """A `bs.<module>:<path>` reference found in text."""

    namespace: str
    path: str
    line: int = 0

    @property
    def id(self) -> str:
        return f"{self.namespace}:{self.path}"

    @property
    def dynamic(self) -> bool:
        return "$(" in self.path

    @property
    def static(self) -> str:
        return self.path.partition("$(")[0]


@dataclass(frozen=True, slots=True)
class Owner:
    """What owns a reference: a feature, a group of features sharing a folder, or a module."""

    module: str
    feature: str | None = None

    @property
    def id(self) -> str:
        return f"{self.module}:{self.feature}" if self.feature else self.module

    @classmethod
    def parse(cls, text: str) -> Owner:
        module, _, feature = text.lstrip("#").partition(":")
        return cls(module, feature or None)


@dataclass(frozen=True)
class Index:
    """Index of module features and their aliases."""

    features: Mapping[str, frozenset[str]]
    aliases: Mapping[str, Mapping[str, str]] = field(default_factory=dict)
    groups: Mapping[str, frozenset[str]] = field(default_factory=dict)

    @classmethod
    def from_modules(cls, modules: Mapping[str, ModuleEntry]) -> Index:
        """Index manifest entries."""
        return cls.from_ids({
            module_id: [(f["id"], f["aliases"]) for f in module["features"]]
            for module_id, module in modules.items()
        })

    @classmethod
    def from_ids(cls, modules: Mapping[str, Sequence[tuple[str, Sequence[str]]]]) -> Index:
        """Index each module's feature ids with their aliases; `#` and namespaces are dropped."""
        features: dict[str, frozenset[str]] = {}
        aliases: dict[str, dict[str, str]] = {}

        def name(feature_id: str) -> str:
            return feature_id.partition(":")[2]

        for module_id, declared in modules.items():
            features[module_id] = frozenset(name(feature_id) for feature_id, _ in declared)
            aliases[module_id] = {
                name(alias): name(feature_id)
                for feature_id, feature_aliases in declared for alias in feature_aliases
            }

        return cls(features, aliases, {m: groups(f) for m, f in features.items()})

    def resolve(self, reference: Reference) -> Resolution:
        """Resolve a reference to an owner, or say why it cannot be."""
        features = self.features.get(reference.namespace)
        if features is None:
            return Reason.UNKNOWN_MODULE
        module = reference.namespace
        folders = self.groups.get(module, frozenset())
        if not reference.dynamic:
            return self._static(module, features, folders, reference.path)
        prefix = reference.static.rsplit("/", 1)[0] if "/" in reference.static else ""
        if not prefix:
            return Reason.DYNAMIC_ID
        owner = longest_prefix(features, prefix)
        if owner is not None:
            return Owner(module, owner)
        if any(candidate.startswith(f"{prefix}/") for candidate in features):
            return Reason.AMBIGUOUS
        return Owner(module, longest_prefix(folders, prefix))

    def _static(
        self,
        module: str,
        features: frozenset[str],
        folders: frozenset[str],
        path: str,
    ) -> Owner:
        if path in features:
            return Owner(module, path)
        if (alias := self.aliases.get(module, {}).get(path)) is not None:
            return Owner(module, alias)
        parts = path.split("/")
        if any(part.startswith("_") for part in parts):
            # A private file belongs to the feature or group of its folder, like a function.
            path = "/".join(part.removeprefix("_") for part in parts[:-1])
        return Owner(module, longest_prefix(features | folders, path))


def strong(owners: Iterable[Owner], weak: Iterable[str]) -> set[Owner]:
    """Keep the owners not declared weak, as a feature or as a whole module."""
    declared = {Owner.parse(entry) for entry in weak}
    return {o for o in owners if o not in declared and Owner(o.module) not in declared}


def required(start: Iterable[Owner], requires: Callable[[Owner], Iterable[Owner]]) -> set[Owner]:
    """Every owner reached from the start: what is wanted, and what that needs in turn."""
    reached: set[Owner] = set()
    pending = list(start)
    while pending:
        owner = pending.pop()
        if owner not in reached:
            reached.add(owner)
            pending.extend(requires(owner))
    return reached


def groups(features: Iterable[str]) -> frozenset[str]:
    """The folders holding features, whose other files the features in them share."""
    return frozenset(
        feature.rsplit("/", depth)[0]
        for feature in features
        for depth in range(1, feature.count("/") + 1)
    )


def parents(owner: Owner, folders: Iterable[str]) -> set[Owner]:
    """The groups an owner lies in, whose files come with it."""
    path = owner.feature or ""
    return {Owner(owner.module, g) for g in folders if path.startswith(f"{g}/")}


def longest_prefix(ids: Iterable[str], path: str) -> str | None:
    """Find the longest id equal to `path` or to a `/`-bounded prefix of it."""
    matches = [i for i in ids if path == i or path.startswith(f"{i}/")]
    return max(matches, key=len) if matches else None


def parse(text: str) -> Iterator[Reference]:
    """Yield every reference in `text`, with its line number."""
    line, counted = 1, 0
    for match in REFERENCE.finditer(text):
        line += text.count("\n", counted, match.start())
        counted = match.start()
        yield Reference(namespace=match["namespace"], path=match["path"], line=line)

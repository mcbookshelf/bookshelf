import re
from collections.abc import Iterable, Iterator, Mapping
from dataclasses import dataclass, field
from enum import StrEnum

from mcbookshelf.assets import ModuleEntry

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
    """What owns a reference: a feature or a module."""

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

    @classmethod
    def from_modules(cls, modules: Mapping[str, ModuleEntry]) -> Index:
        """Index manifest entries; `#` on ids is dropped."""
        features: dict[str, frozenset[str]] = {}
        aliases: dict[str, dict[str, str]] = {}

        def name(feature_id: str) -> str:
            return feature_id.partition(":")[2]

        for module_id, module in modules.items():
            features[module_id] = frozenset(name(f["id"]) for f in module["features"])
            aliases[module_id] = {
                name(alias): name(f["id"])
                for f in module["features"] for alias in f["aliases"]
            }

        return cls(features, aliases)

    def resolve(self, reference: Reference) -> Resolution:
        """Resolve a reference to an owner, or say why it cannot be."""
        features = self.features.get(reference.namespace)
        if features is None:
            return Reason.UNKNOWN_MODULE
        module = reference.namespace
        if not reference.dynamic:
            return self._static(module, features, reference.path)
        prefix = reference.static.rsplit("/", 1)[0] if "/" in reference.static else ""
        if not prefix:
            return Reason.DYNAMIC_ID
        owner = longest_prefix(features, prefix)
        if owner is not None:
            return Owner(module, owner)
        if any(candidate.startswith(f"{prefix}/") for candidate in features):
            return Reason.AMBIGUOUS
        return Owner(module)

    def _static(self, module: str, features: frozenset[str], path: str) -> Owner:
        if path in features:
            return Owner(module, path)
        if (alias := self.aliases.get(module, {}).get(path)) is not None:
            return Owner(module, alias)
        owner = longest_prefix(features, path)
        return Owner(module, owner) if owner is not None else Owner(module)


def longest_prefix(ids: Iterable[str], path: str) -> str | None:
    """Find the longest id equal to `path` or to a `/`-bounded prefix of it."""
    matches = [i for i in ids if path == i or path.startswith(f"{i}/")]
    return max(matches, key=len) if matches else None


def parse(text: str) -> Iterator[Reference]:
    """Yield every reference in `text`, with its line number."""
    for match in REFERENCE.finditer(text):
        yield Reference(
            namespace=match["namespace"],
            path=match["path"],
            line=text.count("\n", 0, match.start()) + 1,
        )

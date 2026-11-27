import logging
from collections import defaultdict
from collections.abc import Generator, Iterable, Iterator, Mapping

from beet import Context

from mcbookshelf.manifest import FeatureEntry, ModuleEntry
from mcbookshelf.references import (
    Index,
    Owner,
    Reason,
    Reference,
    closure,
    scan,
    without_weak,
)
from mcbookshelf.releases import Releases, ResolutionError

logger = logging.getLogger(__name__)

type Imports = dict[str, set[str]]


def beet_default(ctx: Context) -> Generator[None]:
    """Merge the features referenced by the project once it is built."""
    yield
    releases = ctx.inject(Releases)
    index = Index.from_modules(releases.modules)
    included = ctx.meta.get("bookshelf", {}).get("include", ())
    wanted = {Owner.parse(entry) for entry in included}
    known = {Owner(name) for name in releases.modules} | set(_features_by_owner(releases.modules))
    if unknown := sorted(owner.id for owner in wanted - known):
        raise ResolutionError(f"'include' names nothing Bookshelf has: {', '.join(unknown)}")
    reported = set()
    for path, reference in references_in(ctx):
        match index.resolve(reference):
            case Owner() as owner:
                wanted.add(owner)
            case Reason.UNKNOWN_MODULE:
                pass
            case reason:
                if reference.namespace not in reported:
                    reported.add(reference.namespace)
                    warn(path, reference, reason)
    for module_id, paths in plan(releases.modules, wanted).items():
        ctx.data.merge(releases.module(module_id, paths))


def plan(modules: Mapping[str, ModuleEntry], wanted: Iterable[Owner]) -> Imports:
    """Plan which files to import from each module: what is wanted, and what that needs."""
    features = _features_by_owner(modules)
    start = set(wanted)
    for owner in tuple(start):
        if owner.feature is None and owner.module in modules:
            start.update(Owner.parse(f["id"]) for f in modules[owner.module]["features"])

    def requires(owner: Owner) -> set[Owner]:
        module = modules.get(owner.module)
        if module is None:
            return set()
        weak = module["weak_dependencies"]
        if owner.feature is None:
            return without_weak(map(Owner.parse, module["dependencies"]), weak)
        if not (found := features.get(owner)):
            return set()
        ids = [i for f in found for i in f["dependencies"]]
        return {Owner(owner.module), *without_weak(map(Owner.parse, ids), weak)}

    imports: Imports = defaultdict(set)
    for owner in closure(start, requires):
        if owner.module in modules and owner.feature is None:
            imports[owner.module].update(modules[owner.module]["files"])
        for feature in features.get(owner, ()):
            imports[owner.module].update(feature["files"])
    return dict(imports)


def references_in(ctx: Context) -> Iterator[tuple[str, Reference]]:
    """Yield every reference in the project's own files, with its path."""
    for path, file in ctx.data.list_files():
        text = getattr(file, "text", None)
        if isinstance(text, str):
            for reference in scan(text):
                yield path, reference


def warn(path: str, reference: Reference, reason: Reason) -> None:
    """Warn when auto import cannot resolve a reference."""
    module = reference.namespace
    logger.warning(
        "'%s' in %s cannot be attributed to a feature (%s): auto import may miss "
        "files of %s. Require 'mcbookshelf.module.%s' to import the whole module.",
        reference.id,
        path,
        reason,
        module,
        module.removeprefix("bs."),
    )


def _features_by_owner(
    modules: Mapping[str, ModuleEntry],
) -> dict[Owner, list[FeatureEntry]]:
    """Features by owner: several when a tag and a file share one name."""
    features = defaultdict(list)
    for module in modules.values():
        for feature in module["features"]:
            features[Owner.parse(feature["id"])].append(feature)
    return features

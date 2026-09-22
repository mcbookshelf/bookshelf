import logging
from collections import defaultdict
from collections.abc import Generator, Iterable, Iterator, Mapping

from beet import Context

from mcbookshelf.assets import Assets, FeatureEntry, ModuleEntry
from mcbookshelf.references import Index, Owner, Reason, Reference, parse

logger = logging.getLogger(__name__)

type Imports = dict[str, set[str]]


def beet_default(ctx: Context) -> Generator[None]:
    """Merge the features referenced by the project once it is built."""
    yield
    assets = ctx.inject(Assets)
    index = Index.from_modules(assets.modules)
    wanted = set(ctx.meta.get("bookshelf", {}).get("include", ()))
    reported = set()
    for path, reference in references_in(ctx):
        match index.resolve(reference):
            case Owner() as owner:
                wanted.add(owner.id)
            case Reason.UNKNOWN_MODULE:
                pass
            case reason:
                if reference.namespace not in reported:
                    reported.add(reference.namespace)
                    warn(path, reference, reason)
    for module_id, paths in plan(assets.modules, wanted).items():
        ctx.data.merge(assets.module(module_id, paths))


def plan(modules: Mapping[str, ModuleEntry], wanted: Iterable[str]) -> Imports:
    """Plan which files to import from each module: what is wanted, and what that needs."""
    wanted = {item.lstrip("#") for item in wanted}
    features = _features_by_id(modules)
    imports: Imports = defaultdict(set)
    pending = list(wanted)
    seen: set[str] = set()
    while pending:
        owner_id = pending.pop()
        if owner_id in seen:
            continue
        seen.add(owner_id)
        if owner_id in modules:
            pending += _import_module(modules, owner_id, imports, whole=owner_id in wanted)
        for module_id, feature in features.get(owner_id, ()):
            pending += _import_feature(modules, module_id, feature, imports)
    return dict(imports)


def references_in(ctx: Context) -> Iterator[tuple[str, Reference]]:
    """Yield every reference in the project's own files, with its path."""
    for path, file in ctx.data.list_files():
        text = getattr(file, "text", None)
        if isinstance(text, str):
            for reference in parse(text):
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
        module[3:],
    )


def _features_by_id(
    modules: Mapping[str, ModuleEntry],
) -> dict[str, list[tuple[str, FeatureEntry]]]:
    features = defaultdict(list)
    for module_id, module in modules.items():
        for feature in module["features"]:
            features[feature["id"].lstrip("#")].append((module_id, feature))
    return features


def _import_feature(
    modules: Mapping[str, ModuleEntry],
    module_id: str,
    feature: FeatureEntry,
    imports: Imports,
) -> list[str]:
    imports[module_id].update(feature["files"])
    return [module_id, *_strong_dependencies(modules, module_id, feature["dependencies"])]


def _import_module(
    modules: Mapping[str, ModuleEntry],
    module_id: str,
    imports: Imports,
    *,
    whole: bool,
) -> list[str]:
    module = modules[module_id]
    imports[module_id].update(module["files"])
    following = _strong_dependencies(modules, module_id, module["dependencies"])
    if whole:
        following += [f["id"].lstrip("#") for f in module["features"]]
    return following


def _strong_dependencies(
    modules: Mapping[str, ModuleEntry],
    source: str,
    targets: Iterable[str],
) -> list[str]:
    weak = {Owner.parse(entry) for entry in modules[source]["weak_dependencies"]}
    kept = []
    for target in targets:
        owner = Owner.parse(target)
        if owner not in weak and Owner(owner.module) not in weak:
            kept.append(target)
    return kept

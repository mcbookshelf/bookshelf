import zipfile
from collections.abc import Mapping
from pathlib import Path

import orjson
from beet import Context

from mcbookshelf import constants, workspace
from mcbookshelf.assets import BundleEntry, FeatureEntry, Manifest, ModuleEntry, VersionStamp
from mcbookshelf.meta import Feature, Module, Stamp
from mcbookshelf.meta.mcdoc import render_module
from mcbookshelf.package.config import Build
from mcbookshelf.references import Owner
from mcbookshelf.workspace import history
from mcbookshelf.workspace.ownership import Ownership, OwnershipError, analyze, pack_files

MANIFEST_VERSION = 3
STUB_DESCRIPTION = "Bookshelf API, for editor completion only."


def write_manifest(
    modules: Mapping[str, Context],
    bundles: Mapping[str, Context],
    output: Path,
) -> Path:
    analyses = {
        name: ctx.meta.get("ownership") or analyze(name, pack_files(ctx, name))
        for name, ctx in modules.items()
    }
    problems = [p for a in analyses.values() for p in a.problems]
    if problems:
        raise OwnershipError(problems)

    file = output / "manifest.json"
    file.write_bytes(orjson.dumps(Manifest(
        version=MANIFEST_VERSION,
        release=history.release_version(),
        minecraft=constants.GAME_VERSION,
        bundles={name: _bundle(name, ctx) for name, ctx in bundles.items()},
        modules={name: _module(a, modules[name]) for name, a in analyses.items()},
    )))
    return file


def write_stub(name: str, ctx: Context, output: Path) -> Path:
    data = dict(ctx.data.mcmeta.data)
    data.setdefault("pack", {})["description"] = STUB_DESCRIPTION
    data.pop("id")
    files = {"pack.mcmeta": orjson.dumps(data)}

    members = [name] if name in workspace.modules() else workspace.members(name)
    for member in members:
        module = workspace.load_module(member)
        files[f"mcdoc/{module.short}.mcdoc"] = render_module(module).encode()
        for feature in _shipped(module, ctx):
            content = b'{"values":[]}' if feature.tag else b"{}"
            entry = f"data/{member}/{feature.kind}/{feature.name}"
            files[f"{entry}.json"] = content
            if feature.macro_struct:
                files[f"{entry}{constants.MACRO_SUFFIX}.json"] = content

    file = output / _stub(ctx)
    file.parent.mkdir(parents=True, exist_ok=True)
    with zipfile.ZipFile(file, "w", zipfile.ZIP_DEFLATED) as archive:
        for path in sorted(files):
            archive.writestr(path, files[path])
    return file


def _ids(owners: set[Owner]) -> list[str]:
    return sorted(owner.id for owner in owners)


def _kind(ctx: Context) -> str:
    return "datapack" if ctx.data else "resourcepack"


def _stub(ctx: Context) -> str:
    return f"{ctx.data.name}.stub.zip"


def _stamp(stamp: Stamp) -> VersionStamp:
    return VersionStamp(date=stamp.date, minecraft_version=stamp.minecraft_version)


def _shipped(module: Module, ctx: Context) -> tuple[Feature, ...]:
    build: Build = ctx.meta["build"]
    return tuple(f for f in module.features if build.experimental or not f.experimental)


def _bundle(name: str, ctx: Context) -> BundleEntry:
    bundle = workspace.load_bundle(name)
    return BundleEntry(
        id=bundle.id,
        name=bundle.name,
        slug=bundle.slug,
        kind=_kind(ctx),
        version=bundle.version,
        description=bundle.description,
        documentation=bundle.documentation,
        icon=history.raw_file(name, "pack.png"),
        readme=history.raw_file(name, "README.md"),
        file=f"{ctx.data.name}.zip",
        stub=_stub(ctx),
        tags=list(bundle.tags),
        modules=list(workspace.members(name)),
    )


def _module(analysis: Ownership, ctx: Context) -> ModuleEntry:
    module = analysis.module
    return ModuleEntry(
        id=module.id,
        name=module.name,
        slug=module.slug,
        kind=_kind(ctx),
        version=module.version,
        description=module.description,
        documentation=module.documentation,
        icon=history.raw_file(module.id, "pack.png"),
        readme=history.raw_file(module.id, "README.md"),
        file=f"{ctx.data.name}.zip",
        stub=_stub(ctx),
        tags=list(module.tags),
        dependencies=_ids(analysis.dependencies(analysis.shared)),
        weak_dependencies=list(module.weak_dependencies),
        files=analysis.files.get(analysis.shared, []),
        features=[_feature(analysis, f) for f in _shipped(module, ctx)],
    )


def _feature(analysis: Ownership, feature: Feature) -> FeatureEntry:
    owner = Owner(analysis.module.id, feature.name)
    return FeatureEntry(
        id=feature.id,
        kind=feature.kind,
        documentation=feature.documentation,
        aliases=[feature.macro_id] if feature.macro_struct else [],
        authors=list(feature.authors),
        created=_stamp(feature.created),
        updated=_stamp(feature.updated),
        dependencies=_ids(analysis.dependencies(owner)),
        files=analysis.files.get(owner, []),
    )

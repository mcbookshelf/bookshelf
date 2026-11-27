import copy
import gzip
import zipfile
from collections.abc import Mapping
from pathlib import Path

import orjson
from beet import Context

from mcbookshelf import constants, workspace
from mcbookshelf.manifest import (
    BundleEntry,
    FeatureEntry,
    Manifest,
    ModuleEntry,
    PackEntry,
    VersionStamp,
)
from mcbookshelf.meta import Bundle, Feature, Module
from mcbookshelf.meta.mcdoc import render_module
from mcbookshelf.pipeline.config import build_of
from mcbookshelf.references import Owner
from mcbookshelf.workspace import Workspace, history, release
from mcbookshelf.workspace.ownership import Ownership, OwnershipError, analyze, pack_files, sources

MANIFEST_VERSION = 3
STUB_DESCRIPTION = "Bookshelf API, for editor completion only."
EMPTY_STRUCTURE = gzip.compress(b"\x0a\x00\x00\x00", mtime=0)


def write_manifest(
    modules: Mapping[str, Context],
    bundles: Mapping[str, Context],
    output: Path,
) -> Path:
    ws = workspace.current()
    analyses = {name: analyze(ws, name, pack_files(ctx, name)) for name, ctx in modules.items()}
    problems = [p for a in analyses.values() for p in a.problems]
    if problems:
        raise OwnershipError(problems)

    file = output / "manifest.json"
    file.write_bytes(orjson.dumps(Manifest(
        version=MANIFEST_VERSION,
        release=release.version(ws),
        minecraft=constants.GAME_VERSION,
        bundles={name: _bundle(ws, name, ctx) for name, ctx in bundles.items()},
        modules={name: _module(ws, a, modules[name]) for name, a in analyses.items()},
    )))
    return file


def write_stub(name: str, ctx: Context, output: Path) -> Path:
    data = copy.deepcopy(ctx.data.mcmeta.data)
    data.setdefault("pack", {})["description"] = STUB_DESCRIPTION
    data.pop("id", None)
    files = {
        "pack.mcmeta": orjson.dumps(data),
        "LICENSE": (constants.ROOT_DIR / "LICENSE").read_bytes(),
    }

    ws = workspace.current()
    members = [name] if name in ws.modules() else ws.members(name)
    for member in members:
        module = ws.load_module(member)
        files[f"mcdoc/{module.short}.mcdoc"] = render_module(module).encode()
        for feature in _shipped(module, ctx):
            entry = f"data/{member}/{feature.resource}/{feature.name}"
            if feature.resource == "structure":
                files[f"{entry}.nbt"] = EMPTY_STRUCTURE
                continue
            content = b'{"values":[]}' if feature.tag else b"{}"
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


def _stub(ctx: Context) -> str:
    return f"{ctx.data.name}.stub.zip"


def _updated(ws: Workspace, feature: Feature, owner: Owner) -> VersionStamp:
    """When a feature last changed: the last commit on its sources, or on the module's scripts."""
    created = feature.created
    scripts = (file.name for file in ws.directory(feature.module).glob("*.py"))
    paths = sources(ws, feature.module).shipped(owner) or scripts
    change = history.last_change(ws, feature.module, paths)
    if change is None or change[0] <= created.date:
        return VersionStamp(date=created.date, minecraft_version=created.minecraft_version)
    return VersionStamp(date=change[0], minecraft_version=change[1] or created.minecraft_version)


def _shipped(module: Module, ctx: Context) -> tuple[Feature, ...]:
    build = build_of(ctx)
    return tuple(f for f in module.features if build.experimental or not f.experimental)


def _pack(ws: Workspace, pack: Bundle | Module, ctx: Context) -> PackEntry:
    """What the entry of a bundle and of a module share."""
    return PackEntry(
        id=pack.id,
        name=pack.name,
        slug=pack.slug,
        kind="datapack" if ctx.data else "resourcepack",
        version=pack.version,
        description=pack.description,
        documentation=pack.documentation,
        icon=release.raw_file(ws, pack.id, "pack.png"),
        readme=release.raw_file(ws, pack.id, "README.md"),
        file=f"{ctx.data.name}.zip",
        stub=_stub(ctx),
        tags=list(pack.tags),
    )


def _bundle(ws: Workspace, name: str, ctx: Context) -> BundleEntry:
    return BundleEntry(**_pack(ws, ws.load_bundle(name), ctx), modules=list(ws.members(name)))


def _module(ws: Workspace, analysis: Ownership, ctx: Context) -> ModuleEntry:
    module = analysis.module
    return ModuleEntry(
        **_pack(ws, module, ctx),
        dependencies=_ids(analysis.dependencies(analysis.shared)),
        weak_dependencies=list(module.weak_dependencies),
        files=analysis.files.get(analysis.shared, []),
        features=[_feature(ws, analysis, f) for f in _shipped(module, ctx)],
    )


def _feature(ws: Workspace, analysis: Ownership, feature: Feature) -> FeatureEntry:
    owner = Owner(analysis.module.id, feature.name)
    created = feature.created
    return FeatureEntry(
        id=feature.id,
        kind=feature.resource,
        documentation=feature.documentation,
        aliases=list(feature.aliases),
        authors=list(feature.authors),
        contributors=list(feature.contributors),
        created=VersionStamp(date=created.date, minecraft_version=created.minecraft_version),
        updated=_updated(ws, feature, owner),
        dependencies=_ids(analysis.needs(owner)),
        files=analysis.shipped(owner),
    )

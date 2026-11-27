import hashlib
from dataclasses import replace
from pathlib import Path

import orjson

from mcbookshelf import constants, workspace
from mcbookshelf.pipeline.config import Build
from mcbookshelf.workspace import Workspace, cached, dependencies

TOOLS = (constants.ROOT_DIR / "tools" / "mcbookshelf", constants.ROOT_DIR / "uv.lock")


def fingerprint(ws: Workspace, name: str, options: Build) -> str:
    """The hash of a build of the module, then the modules it includes, one per line."""
    modules = tuple(sorted({name, *dependencies.required(ws, name)}))
    return "\n".join((_stamp(ws, modules, options), *modules))


def is_stub_stale(name: str) -> bool:
    """Whether the stub of a module is missing or outdated."""
    ws = workspace.current()
    file = constants.STUB_DIR / "data" / name / constants.FINGERPRINT_FILE
    return name not in ws.modules() or _outdated(ws, file, Build(stub=True))


def is_stale(name: str, options: Build) -> bool:
    """Whether the pack of a module or its linked copy are missing or outdated."""
    ws = workspace.current()
    if name not in ws.modules():
        return True
    folders = [constants.BUILD_DIR]
    if options.link and (world := _linked()):
        folders.append(world)
    files = (folder / name / constants.FINGERPRINT_FILE for folder in folders)
    return any(_outdated(ws, file, options) for file in files)


def _outdated(ws: Workspace, file: Path, options: Build) -> bool:
    """Whether a fingerprint is missing or no longer matches the modules it lists."""
    if not file.is_file():
        return True
    stamp, *modules = file.read_text("utf-8").split()
    try:
        return stamp != _stamp(ws, tuple(modules), options)
    except KeyError:
        return True


def _stamp(ws: Workspace, modules: tuple[str, ...], options: Build) -> str:
    """Hash of the build options, the sources of the modules, and the tools."""
    paths = (*(ws.directory(module) for module in modules), *TOOLS)
    digest = hashlib.sha1(repr(replace(options, link=False)).encode())  # noqa: S324
    for path in paths:
        digest.update(_digest(ws, path))
    return digest.hexdigest()


@cached
def _digest(ws: Workspace, path: Path) -> bytes:  # noqa: ARG001
    """Hash of a file, or of every file in a folder with their paths: read once per workspace."""
    digest = hashlib.sha1()  # noqa: S324
    for file in [path] if path.is_file() else sorted(path.rglob("*")):
        if file.is_file() and "__pycache__" not in file.parts:
            digest.update(file.relative_to(constants.ROOT_DIR).as_posix().encode())
            digest.update(file.read_bytes())
    return digest.digest()


def _linked() -> Path | None:
    """The data packs folder the builds are linked to, as beet keeps it."""
    index = constants.BEET_CACHE_DIR / "link" / "index.json"
    linked = orjson.loads(index.read_bytes())["json"].get("data_pack") if index.is_file() else None
    return Path(linked) if linked else None

import re
import subprocess
from collections.abc import Callable

from mcbookshelf import constants, meta
from mcbookshelf.meta import Bundle, Module
from mcbookshelf.workspace import Workspace, cached, select

RELEASE_TAG = re.compile(r"^v\d+\.\d+\.\d+\+\S+$")
DOCS_OR_RELEASE_TAG = re.compile(r"^v\d+\.\d+\.\d+(\+\S+)?$")


@cached
def changed_files(_ws: Workspace, tag: str, name: str) -> tuple[str, ...]:
    """The files of a module changed or added since the tag, relative to its directory."""
    directory = f"modules/{name}"
    paths = _paths("diff", "--name-only", "-z", tag, "--", directory)
    paths += _paths("ls-files", "-z", "--others", "--exclude-standard", directory)
    return tuple(p.removeprefix(f"{directory}/") for p in sorted(paths))


@cached
def bundle_at(_ws: Workspace, tag: str, name: str) -> Bundle | None:
    """A bundle as it was at the tag, or None if it did not exist."""
    path = f"modules/{name}/{constants.BUNDLE_FILE}"
    text = file_at(tag, path)
    return None if text is None else _load(tag, path, text, meta.build_bundle, name)


def module_at(ws: Workspace, tag: str, name: str) -> Module | None:
    """A module as it was at the tag, or None if it did not exist."""
    return modules_at(ws, tag).get(name)


@cached
def modules_at(_ws: Workspace, tag: str) -> dict[str, Module]:
    """Every module as it was at the tag, by directory name, read in one git call."""
    listing = _run("ls-tree", "--name-only", f"{tag}:modules", check=False)
    directories = listing.stdout.split() if listing.returncode == 0 else []
    files = {name: f"modules/{name}/{constants.MODULE_FILE}" for name in directories}
    texts = _files_at(tag, list(files.values()))
    return {
        name: _load(tag, path, texts[path], meta.build_module, name)
        for name, path in files.items()
        if path in texts
    }


@cached
def members_at(ws: Workspace, tag: str, name: str) -> dict[str, str]:
    """The members a bundle had at the tag, with their versions then."""
    bundle = bundle_at(ws, tag, name)
    if bundle is None:
        return {}
    members = select(bundle, modules_at(ws, tag).values())
    return {m.id: m.version for m in members}


def file_at(tag: str, path: str) -> str | None:
    """The text of a file at the tag, or None if it did not exist."""
    result = _run("show", f"{tag}:{path}", check=False)
    return result.stdout if result.returncode == 0 else None


@cached
def previous_tag(_ws: Workspace) -> str | None:
    """The newest release tag, if any: docs and nightly tags do not count."""
    tags = _git("tag", "-l", "v*", "--sort=-creatordate").split()
    return next((t for t in tags if RELEASE_TAG.match(t)), None)


def remote_tags() -> list[str]:
    """List the version tags known to origin, with or without a game version."""
    refs = _git("ls-remote", "--tags", "--refs", "origin").split()
    tags = [ref.removeprefix("refs/tags/") for ref in refs]
    return [tag for tag in tags if DOCS_OR_RELEASE_TAG.match(tag)]


def _git(*args: str) -> str:
    return _run(*args).stdout


def _paths(*args: str) -> list[str]:
    """Run a git command that lists paths with `-z`, so any path survives."""
    return [path for path in _git(*args).split("\0") if path]


def _load[T](
    tag: str,
    path: str,
    text: str,
    build: Callable[[meta.syntax.Module, str], T],
    name: str,
) -> T:
    try:
        return build(meta.parse(text), name)
    except meta.MetadataError as error:
        raise ValueError(f"{path} at {tag} no longer loads:\n{error}") from None


def _run(*args: str, check: bool = True) -> subprocess.CompletedProcess[str]:
    return subprocess.run(
        ["git", *args],  # noqa: S607
        cwd=constants.ROOT_DIR,
        capture_output=True,
        text=True,
        encoding="utf-8",
        check=check,
    )


def _files_at(tag: str, paths: list[str]) -> dict[str, str]:
    answer = subprocess.run(
        ["git", "cat-file", "--batch"],  # noqa: S607
        cwd=constants.ROOT_DIR,
        input="".join(f"{tag}:{path}\n" for path in paths).encode(),
        capture_output=True,
        check=True,
    ).stdout

    texts = {}
    position = 0
    for path in paths:
        end = answer.index(b"\n", position)
        header = answer[position:end].split()
        position = end + 1
        if header[-1] == b"missing":
            continue
        size = int(header[2])
        texts[path] = answer[position : position + size].decode("utf-8")
        position += size + 1
    return texts

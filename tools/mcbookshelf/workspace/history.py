import re
import subprocess
from functools import cache

from mcbookshelf import constants, meta, workspace
from mcbookshelf.meta import Bundle, Module

RELEASE_TAG = re.compile(r"^v\d+\.\d+\.\d+\+\S+$")
DOCS_OR_RELEASE_TAG = re.compile(r"^v\d+\.\d+\.\d+(\+\S+)?$")


@cache
def changed_files(tag: str, name: str) -> tuple[str, ...]:
    """The files of a module changed or added since the tag, relative to its directory."""
    paths = _git("diff", "--name-only", tag, "--", f"modules/{name}").split()
    paths += _git("ls-files", "--others", "--exclude-standard", f"modules/{name}").split()
    return tuple(p.removeprefix(f"modules/{name}/") for p in sorted(paths))


@cache
def bundle_at(tag: str, name: str) -> Bundle | None:
    """A bundle as it was at the tag, or None if it did not exist."""
    path = f"modules/{name}/{constants.BUNDLE_FILE}"
    text = file_at(tag, path)
    return None if text is None else meta.build_bundle(_parse(tag, path, text), name)


def module_at(tag: str, name: str) -> Module | None:
    """A module as it was at the tag, or None if it did not exist."""
    return modules_at(tag).get(name)


@cache
def modules_at(tag: str) -> dict[str, Module]:
    """Every module as it was at the tag, by directory name, read in one git call."""
    listing = _run("ls-tree", "--name-only", f"{tag}:modules", check=False)
    directories = listing.stdout.split() if listing.returncode == 0 else []
    files = {d: f"modules/{d}/{constants.MODULE_FILE}" for d in directories}
    texts = _files_at(tag, list(files.values()))
    return {
        directory: meta.build_module(_parse(tag, path, texts[path]), directory)
        for directory, path in files.items()
        if path in texts
    }


@cache
def members_at(tag: str, name: str) -> dict[str, str]:
    """The members a bundle had at the tag, with their versions then."""
    bundle = bundle_at(tag, name)
    if bundle is None:
        return {}
    members = workspace.select(bundle, modules_at(tag).values())
    return {m.id: m.version for m in members}


def file_at(tag: str, path: str) -> str | None:
    """The text of a file at the tag, or None if it did not exist."""
    result = _run("show", f"{tag}:{path}", check=False)
    return result.stdout if result.returncode == 0 else None


def release_version() -> str:
    """Read the version of the release, the one of the suite bundle."""
    return workspace.suite().version


def release_tag() -> str:
    """Name the release tag: the suite version and the game version it targets."""
    return f"v{release_version()}+{constants.GAME_VERSION}"


def raw_file(name: str, file: str) -> str:
    """Link a file of a module or bundle directory at the release tag."""
    return f"{constants.RAW_URL.format(release_tag())}/modules/{name}/{file}"


def download_url() -> str:
    """Link the assets of the release on GitHub."""
    return constants.DOWNLOAD_URL.format(release_tag())


def previous_tag() -> str | None:
    """The newest release tag, if any: docs and nightly tags do not count."""
    tags = _git("tag", "-l", "v*", "--sort=-creatordate").split()
    return next((t for t in tags if RELEASE_TAG.match(t)), None)


def remote_tags() -> list[str]:
    """List the version tags known to origin, with or without a game version."""
    refs = _git("ls-remote", "--tags", "--refs", "origin").split()
    tags = [ref.removeprefix("refs/tags/") for ref in refs]
    return [tag for tag in tags if DOCS_OR_RELEASE_TAG.match(tag)]


def tag_exists(tag: str) -> bool:
    return bool(_git("tag", "-l", tag).strip())


def _git(*args: str) -> str:
    return _run(*args).stdout


def _parse(tag: str, path: str, text: str) -> meta.syntax.Module:
    try:
        return meta.parse(text)
    except meta.MetadataError as error:
        raise ValueError(f"{path} at {tag} no longer parses: {error.message}") from None


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

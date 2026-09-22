import re
from collections.abc import Iterator
from pathlib import Path

from mcbookshelf import constants, workspace
from mcbookshelf.version import parse_version
from mcbookshelf.workspace import history

UNRELEASED = "Unreleased"
HEADING = re.compile(r"^##[ \t]+(?P<title>.*?)[ \t]*$", re.MULTILINE)
VERSION = re.compile(r"^`v(?P<version>\d+\.\d+\.\d+)`$")


def unreleased(name: str) -> str:
    """Read the notes written since the previous release."""
    return section(name, UNRELEASED)


def promote(name: str, version: str) -> None:
    """Rename `Unreleased` to a version and open a fresh one above."""
    lines = _lines(name)
    lines[_unreleased_heading(lines)] = f"## `v{version}`"
    top = 1 if lines[0].startswith("# ") else 0
    lines[top:top] = ["", f"## {UNRELEASED}"]
    write_text(_file(name), "\n".join(lines))


def note(name: str, line: str) -> None:
    """Add a line under `Unreleased`."""
    lines = _lines(name)
    at = _unreleased_heading(lines) + 1
    while at < len(lines) and lines[at] == "":
        del lines[at]
    joins_list = at < len(lines) and lines[at].startswith("- ")
    lines[at:at] = ["", f"- {line}"] if joins_list else ["", f"- {line}", ""]
    write_text(_file(name), "\n".join(lines))


def notes(*, unreleased: bool = False) -> str:
    """Gather release notes from module changelogs."""
    tag = history.previous_tag()
    blocks = list(_unreleased() if unreleased else _released(tag))
    if not unreleased and tag and tag.partition("+")[2] != constants.GAME_VERSION:
        blocks.insert(0, f"Supports Minecraft {constants.GAME_VERSION}")
    if not blocks:
        return "Nothing to report yet." if unreleased else "No module changed."
    return "\n\n".join(blocks)


def section(name: str, version: str) -> str:
    """Read the notes of one changelog section."""
    return sections(name).get(version, "")


def sections(name: str) -> dict[str, str]:
    """Map each changelog section to its notes."""
    path = _file(name)
    if not path.is_file():
        return {}
    text = path.read_text("utf-8")
    headings = list(HEADING.finditer(text))
    sections: dict[str, str] = {}
    for index, match in enumerate(headings):
        key = _key(match["title"])
        if key is None:
            continue
        end = headings[index + 1].start() if index + 1 < len(headings) else len(text)
        sections.setdefault(key, text[match.end() : end].strip())
    return sections


def strays(name: str) -> Iterator[tuple[int, str]]:
    """Yield the line and title of `##` headings that are not a section."""
    for index, line in enumerate(_lines(name), 1):
        match = HEADING.match(line)
        if match and _key(match["title"]) is None:
            yield index, match["title"]


def write_text(path: Path, text: str) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(text.rstrip("\n") + "\n", "utf-8", newline="\n")


def _file(name: str) -> Path:
    return workspace.directory(name) / "CHANGELOG.md"


def _lines(name: str) -> list[str]:
    path = _file(name)
    return path.read_text("utf-8").splitlines() if path.is_file() else []


def _unreleased_heading(lines: list[str]) -> int:
    try:
        return _heading(lines, UNRELEASED)
    except LookupError:
        top = 1 if lines and lines[0].startswith("# ") else 0
        lines[top:top] = ["", f"## {UNRELEASED}"] if top else [f"## {UNRELEASED}"]
        return top + 1 if top else 0


def _title(name: str) -> str:
    lines = _lines(name)
    return lines[0].removeprefix("# ") if lines and lines[0].startswith("# ") else name


def _key(title: str) -> str | None:
    if title == UNRELEASED:
        return UNRELEASED
    match = VERSION.match(title)
    return match["version"] if match else None


def _heading(lines: list[str], title: str) -> int:
    for index, line in enumerate(lines):
        match = HEADING.match(line)
        if match and _key(match["title"]) == title:
            return index
    raise LookupError(f"no '{title}' section")


def _unreleased() -> Iterator[str]:
    for name in workspace.modules():
        body = unreleased(name)
        if body:
            yield f"## {_title(name)}\n\n{body}"


def _released(tag: str | None) -> Iterator[str]:
    for name in workspace.released():
        module = workspace.load_module(name)
        before = history.module_at(tag, name) if tag else None
        floor = parse_version(before.version) if before else None
        ceiling = parse_version(module.version)
        for version, body in sections(name).items():
            if version == UNRELEASED:
                continue
            current = parse_version(version)
            new = floor is None and current == ceiling
            if new or (floor is not None and floor < current <= ceiling):
                yield f"## {_title(name)} - `v{version}`\n\n{body}".rstrip()

import re
from collections.abc import Iterator
from dataclasses import dataclass
from pathlib import Path

from mcbookshelf import constants
from mcbookshelf.version import Version
from mcbookshelf.workspace import Workspace, cached, history

UNRELEASED = "Unreleased"
HEADING = re.compile(r"^##[ \t]+(?P<title>.*?)[ \t]*$")
VERSION = re.compile(r"^`v(?P<version>\d+\.\d+\.\d+)`$")


@dataclass
class Changelog:
    """The changelog of a module, read once: its lines, and the `##` sections they hold."""

    path: Path
    lines: list[str]

    @property
    def title(self) -> str | None:
        first = self.lines[0] if self.lines else ""
        return first.removeprefix("# ") if first.startswith("# ") else None

    def headings(self) -> Iterator[tuple[int, str, str | None]]:
        """Yield each `##` heading: its index, its title, and its section key if it has one."""
        for index, line in enumerate(self.lines):
            if match := HEADING.match(line):
                yield index, match["title"], _key(match["title"])

    def sections(self) -> dict[str, str]:
        """Map each section to its notes, the first one winning."""
        headings = list(self.headings())
        bounds = [*(index for index, _, _ in headings), len(self.lines)]
        sections: dict[str, str] = {}
        for (index, _, key), end in zip(headings, bounds[1:], strict=True):
            if key is not None:
                sections.setdefault(key, "\n".join(self.lines[index + 1 : end]).strip())
        return sections

    def unreleased(self) -> int:
        """The index of the `Unreleased` heading, which is opened at the top when missing."""
        for index, _, key in self.headings():
            if key == UNRELEASED:
                return index
        top = 1 if self.title is not None else 0
        self.lines[top:top] = ["", f"## {UNRELEASED}"] if top else [f"## {UNRELEASED}"]
        return top + 1 if top else 0

    def save(self) -> None:
        self.path.write_text("\n".join(self.lines).rstrip("\n") + "\n", "utf-8", newline="\n")


@cached
def read(ws: Workspace, name: str) -> Changelog:
    """The changelog of a module; edits go through this same object, so it stays current."""
    path = ws.directory(name) / "CHANGELOG.md"
    return Changelog(path, path.read_text("utf-8").splitlines() if path.is_file() else [])


def unreleased(ws: Workspace, name: str) -> str:
    """Read the notes written since the previous release."""
    return section(ws, name, UNRELEASED)


def section(ws: Workspace, name: str, version: str) -> str:
    """Read the notes of one changelog section."""
    return sections(ws, name).get(version, "")


def sections(ws: Workspace, name: str) -> dict[str, str]:
    """Map each changelog section to its notes."""
    return read(ws, name).sections()


def strays(ws: Workspace, name: str) -> Iterator[tuple[int, str]]:
    """Yield the line and title of `##` headings that are not a section."""
    for index, title, key in read(ws, name).headings():
        if key is None:
            yield index + 1, title


def promote(ws: Workspace, name: str, version: str) -> None:
    """Rename `Unreleased` to a version and open a fresh one above."""
    changelog = read(ws, name)
    lines = changelog.lines
    lines[changelog.unreleased()] = f"## `v{version}`"
    top = 1 if changelog.title is not None else 0
    lines[top:top] = ["", f"## {UNRELEASED}"]
    changelog.save()


def note(ws: Workspace, name: str, line: str) -> None:
    """Add a line under `Unreleased`."""
    changelog = read(ws, name)
    lines = changelog.lines
    at = changelog.unreleased() + 1
    while at < len(lines) and lines[at] == "":
        del lines[at]
    joins_list = at < len(lines) and lines[at].startswith("- ")
    lines[at:at] = ["", f"- {line}"] if joins_list else ["", f"- {line}", ""]
    changelog.save()


def notes(ws: Workspace, *, unreleased: bool = False) -> str:
    """Gather release notes from module changelogs."""
    tag = history.previous_tag(ws)
    blocks = list(_unreleased(ws) if unreleased else _released(ws, tag))
    if not unreleased and tag and tag.partition("+")[2] != constants.GAME_VERSION:
        blocks.insert(0, f"Supports Minecraft {constants.GAME_VERSION}")
    if not blocks:
        return "Nothing to report yet." if unreleased else "No module changed."
    return "\n\n".join(blocks)


def _key(title: str) -> str | None:
    if title == UNRELEASED:
        return UNRELEASED
    match = VERSION.match(title)
    return match["version"] if match else None


def _title(ws: Workspace, name: str) -> str:
    return read(ws, name).title or name


def _unreleased(ws: Workspace) -> Iterator[str]:
    for name in ws.modules():
        body = unreleased(ws, name)
        if body:
            yield f"## {_title(ws, name)}\n\n{body}"


def _released(ws: Workspace, tag: str | None) -> Iterator[str]:
    for name in ws.released():
        module = ws.load_module(name)
        before = history.module_at(ws, tag, name) if tag else None
        floor = Version.parse(before.version) if before else None
        ceiling = Version.parse(module.version)
        for version, body in sections(ws, name).items():
            if version == UNRELEASED:
                continue
            current = Version.parse(version)
            new = floor is None and current == ceiling
            if new or (floor is not None and floor < current <= ceiling):
                yield f"## {_title(ws, name)} - `v{version}`\n\n{body}".rstrip()

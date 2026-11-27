from collections.abc import Iterator

from mcbookshelf.meta import Module
from mcbookshelf.validation.issue import Issue
from mcbookshelf.workspace import Workspace, changelog, history, ownership


def check_changelog(ws: Workspace, name: str) -> Iterator[Issue]:
    """The changelog keeps `Unreleased` open, and notes the changes made since the release."""
    if not (ws.directory(name) / "CHANGELOG.md").is_file():
        return
    if changelog.UNRELEASED not in changelog.sections(ws, name):
        yield Issue("no '## Unreleased' section: open one at the top", "CHANGELOG.md")
        return
    for line, title in changelog.strays(ws, name):
        message = f"'{title}' is not a section: use 'Unreleased' or a version as `v1.0.0`"
        yield Issue(message, "CHANGELOG.md", line)
    if (released := _released(ws, name)) is None:
        return
    tag, _ = released
    if ownership.shipped_changes(ws, tag, name) and not changelog.unreleased(ws, name):
        message = f"sources changed since {tag}: add a line under '## Unreleased'"
        yield Issue(message, "CHANGELOG.md")


def _released(ws: Workspace, name: str) -> tuple[str, Module] | None:
    """The previous release tag and the module at it, if the module was released then."""
    tag = history.previous_tag(ws)
    if tag is None or not ws.load_module(name).released:
        return None
    before = history.module_at(ws, tag, name)
    return None if before is None else (tag, before)

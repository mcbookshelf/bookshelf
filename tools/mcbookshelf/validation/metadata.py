from collections.abc import Iterator

from mcbookshelf import constants
from mcbookshelf.meta import Module
from mcbookshelf.references import Owner
from mcbookshelf.validation.issue import Issue
from mcbookshelf.workspace import Workspace, changelog, history, ownership


def check_stamps(ws: Workspace, name: str) -> Iterator[Issue]:
    """A feature changed since the release carries a new `updated` stamp."""
    if (released := _released(ws, name)) is None:
        return
    tag, before = released
    stamps = {f.name: f.updated for f in before.features}
    changed = ownership.changed_owners(ws, tag, name)
    for feature in ws.load_module(name).features:
        if Owner(name, feature.name) in changed and stamps.get(feature.name) == feature.updated:
            message = f"'{feature.name}' changed since {tag}: update its 'updated' stamp"
            yield Issue(message, constants.MODULE_FILE, feature.line)


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

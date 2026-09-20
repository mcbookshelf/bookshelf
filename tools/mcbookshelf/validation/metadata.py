from collections.abc import Iterator

from mcbookshelf import constants, validation, workspace
from mcbookshelf.meta import Module
from mcbookshelf.references import Owner
from mcbookshelf.workspace import changelog, history, ownership


def check_stamps(name: str) -> Iterator[validation.Issue]:
    """A feature changed since the release carries a new `updated` stamp."""
    if (released := _released(name)) is None:
        return
    tag, before = released
    stamps = {f.name: f.updated for f in before.features}
    changed = ownership.changed_owners(tag, name)
    for feature in workspace.load_module(name).features:
        if Owner(name, feature.name) in changed and stamps.get(feature.name) == feature.updated:
            message = f"'{feature.name}' changed since {tag}: update its 'updated' stamp"
            yield validation.Issue(message, constants.MODULE_FILE, feature.line)


def check_changelog(name: str) -> Iterator[validation.Issue]:
    """The changelog keeps `Unreleased` open, and notes the changes made since the release."""
    if not (workspace.directory(name) / "CHANGELOG.md").is_file():
        return
    if changelog.UNRELEASED not in changelog.sections(name):
        yield validation.Issue("no '## Unreleased' section: open one at the top", "CHANGELOG.md")
        return
    for line, title in changelog.strays(name):
        message = f"'{title}' is not a section: use 'Unreleased' or a version as `v1.0.0`"
        yield validation.Issue(message, "CHANGELOG.md", line)
    if (released := _released(name)) is None:
        return
    tag, _ = released
    if ownership.shipped_changes(tag, name) and not changelog.unreleased(name):
        message = f"sources changed since {tag}: add a line under '## Unreleased'"
        yield validation.Issue(message, "CHANGELOG.md")


def _released(name: str) -> tuple[str, Module] | None:
    """The previous release tag and the module at it, if the module was released then."""
    tag = history.previous_tag()
    if tag is None or not workspace.load_module(name).released:
        return None
    before = history.module_at(tag, name)
    return None if before is None else (tag, before)

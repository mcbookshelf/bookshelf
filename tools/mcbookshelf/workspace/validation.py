import re
from collections.abc import Iterator
from dataclasses import dataclass

from mcbookshelf import constants, templates, workspace
from mcbookshelf.meta import MetadataError, Module
from mcbookshelf.meta.errors import locate
from mcbookshelf.references import Owner
from mcbookshelf.workspace import changelog, history, ownership

DIRECTIVE = re.compile(r"^`{3,}\{feature\}[ \t]+(?:(\S+)[ \t]+)?#?(\S+)[ \t]*$", re.MULTILINE)

UNDECLARED = (
    "public file with no feature declared in module.bs: "
    "declare it, or make it private with a '_'"
)


@dataclass(frozen=True, slots=True)
class Issue:

    message: str
    path: str
    line: int | None = None

    def __str__(self) -> str:
        return f"{locate(self.path, self.line)}: {self.message}"


def check_module(name: str) -> list[Issue]:
    """Run every check on a module; one that does not load has that single issue."""
    try:
        workspace.load_module(name)
    except MetadataError as error:
        return [Issue(error.message, constants.MODULE_FILE, error.line)]
    checks = (
        check_requirements,
        check_layout,
        check_headers,
        check_stamps,
        check_references,
        check_changelog,
        check_documentation,
    )
    return [issue for check in checks for issue in check(name)]


def check_requirements(name: str) -> Iterator[Issue]:
    """A module ships a changelog, a readme and an icon."""
    directory = workspace.directory(name)
    for file in ("CHANGELOG.md", "README.md", "pack.png"):
        if not (directory / file).is_file():
            yield Issue("required file is missing", file)


def check_layout(name: str) -> Iterator[Issue]:
    """A public file belongs to a declared feature."""
    for path, _ in ownership.source_files(name):
        location = ownership.locate_in(name, path)
        if location and location.public and not location.feature:
            yield Issue(UNDECLARED, path)


def check_references(name: str) -> Iterator[Issue]:
    """Every reference can be attributed to a feature or a module."""
    for problem in ownership.sources(name).problems:
        yield Issue(
            f"'{problem.reference.id}' cannot be attributed: {problem.resolution}",
            problem.path,
            problem.reference.line,
        )


def check_headers(name: str) -> Iterator[Issue]:
    """Every function starts with the license header of the current year."""
    expected = templates.header().splitlines()
    for path, text in ownership.source_files(name):
        if text is None or not path.endswith(".mcfunction"):
            continue
        lines = text.splitlines()
        if lines[: len(expected)] == expected:
            continue
        line = len(lines) + 1
        for index, (found, wanted) in enumerate(zip(lines, expected, strict=False), 1):
            if found != wanted:
                line = index
                break
        yield Issue(f"license header differs from the {templates.year()} template", path, line)


def check_stamps(name: str) -> Iterator[Issue]:
    """A feature changed since the release carries a new `updated` stamp."""
    if (released := _released(name)) is None:
        return
    tag, before = released
    stamps = {f.name: f.updated for f in before.features}
    changed = ownership.changed_owners(tag, name)
    for feature in workspace.load_module(name).features:
        if Owner(name, feature.name) in changed and stamps.get(feature.name) == feature.updated:
            message = f"'{feature.name}' changed since {tag}: update its 'updated' stamp"
            yield Issue(message, constants.MODULE_FILE, feature.line)


def check_changelog(name: str) -> Iterator[Issue]:
    """The changelog keeps `Unreleased` open, and notes the changes made since the release."""
    module = workspace.load_module(name)
    if changelog.UNRELEASED not in changelog.sections(name):
        yield Issue("no '## Unreleased' section: open one at the top", "CHANGELOG.md")
        return
    for line, title in changelog.strays(name):
        message = f"'{title}' is not a section: use 'Unreleased' or a version as `v1.0.0`"
        yield Issue(message, "CHANGELOG.md", line)
    if (released := _released(name)) is None:
        return
    tag, _ = released
    changed = ownership.changed_owners(tag, name)
    shipped = any(owner.feature not in module.experimental for owner in changed)
    if shipped and not changelog.unreleased(name):
        message = f"sources changed since {tag}: add a line under '## Unreleased'"
        yield Issue(message, "CHANGELOG.md")


def _released(name: str) -> tuple[str, Module] | None:
    """The previous release tag and the module at it, if the module was released then."""
    tag = history.previous_tag()
    if tag is None or not workspace.load_module(name).released:
        return None
    before = history.module_at(tag, name)
    return None if before is None else (tag, before)


def check_documentation(name: str) -> Iterator[Issue]:
    """The docs page exists, and every feature has a directive that names it."""
    module = workspace.load_module(name)
    if not module.documentation.startswith(f"{constants.DOCS_PAGES_URL}/"):
        return
    page = constants.DOCS_DIR / module.documentation.removeprefix(f"{constants.DOCS_PAGES_URL}/")
    page = page.with_suffix(".md")
    shown = page.relative_to(constants.ROOT_DIR).as_posix()
    if not page.is_file():
        yield Issue("documentation page is missing", shown)
        return

    documented = set()
    text = page.read_text("utf-8")
    for match in DIRECTIVE.finditer(text):
        kind, reference = match.groups()
        namespace, _, feature_name = reference.partition(":")
        if namespace != name:
            continue
        line = text.count("\n", 0, match.start()) + 1
        try:
            feature = module.find(feature_name, kind)
        except LookupError as error:
            yield Issue(str(error), shown, line)
            continue
        documented.add(feature)

    for feature in module.features:
        if feature not in documented:
            anchor = f"#{feature.anchor} resolves to nothing"
            yield Issue(f"'{feature.name}' has no {{feature}} directive: {anchor}", shown)

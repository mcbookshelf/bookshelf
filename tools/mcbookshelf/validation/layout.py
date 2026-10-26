from collections.abc import Iterator

from mcbookshelf import templates
from mcbookshelf.references import Owner
from mcbookshelf.validation.issue import Issue
from mcbookshelf.workspace import Workspace, ownership

UNDECLARED = (
    "public file with no feature declared in module.bs: "
    "declare it, or make it private with a '_'"
)


def check_requirements(ws: Workspace, name: str) -> Iterator[Issue]:
    """A module ships a changelog, a readme and an icon."""
    directory = ws.directory(name)
    for file in ("CHANGELOG.md", "README.md", "pack.png"):
        if not (directory / file).is_file():
            yield Issue("required file is missing", file)


def check_files(ws: Workspace, name: str) -> Iterator[Issue]:
    """A public file belongs to a declared feature."""
    for path, _ in ownership.source_files(ws, name):
        location = ownership.locate_in(ws, name, path)
        if location and location.requires_feature and not location.feature:
            yield Issue(UNDECLARED, path)


def check_headers(ws: Workspace, name: str) -> Iterator[Issue]:
    """Every function starts with the license header of the current year."""
    expected = templates.header().splitlines()
    for path, text in ownership.source_files(ws, name):
        if not path.endswith(".mcfunction"):
            continue
        lines = text.splitlines()
        if lines[: len(expected)] == expected:
            continue
        line = len(lines) + 1
        for index, (found, wanted) in enumerate(zip(lines, expected, strict=False), 1):
            if found != wanted:
                line = index
                break
        yield Issue("license header differs from the template", path, line)


def check_entries(ws: Workspace, name: str) -> Iterator[Issue]:
    """An entry function belongs to a declared feature; `__macro__` to one that takes a macro."""
    module = ws.load_module(name)
    for path, _ in ownership.source_files(ws, name):
        location = ownership.locate_in(ws, name, path)
        if location is None or location.resource != "function":
            continue
        entry = location.parts[-1].removesuffix(".mcfunction")
        if entry not in ("__main__", "__macro__"):
            continue
        feature = "/".join(location.parts[:-1])
        try:
            declared = module.find(feature, "function") if location.feature == feature else None
        except LookupError:
            declared = None
        if declared is None:
            message = f"'{entry}' of a feature not declared as a function in module.bs"
            yield Issue(message, path)
        elif entry == "__macro__" and declared.macro_struct is None:
            message = "'__macro__' of a feature with no 'input arguments' or 'input macro'"
            yield Issue(message, path)


def check_references(ws: Workspace, name: str) -> Iterator[Issue]:
    """Every reference can be attributed to a feature or a module."""
    for problem in ownership.sources(ws, name).problems:
        yield Issue(problem.reason, problem.path, problem.reference.line)


def check_private(ws: Workspace, name: str) -> Iterator[Issue]:
    """A private file is only used by its owner, inside its group, or anywhere in its module."""
    for leak in ownership.sources(ws, name).leaks:
        owner = leak.resolution.id if isinstance(leak.resolution, Owner) else leak.resolution
        message = (
            f"'{leak.reference.id}' is private to {owner}: "
            "call its public feature or its entry, or move the file to a group both share"
        )
        yield Issue(message, leak.path, leak.reference.line)

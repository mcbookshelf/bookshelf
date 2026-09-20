from collections.abc import Iterator

from mcbookshelf import templates, validation, workspace
from mcbookshelf.workspace import ownership

UNDECLARED = (
    "public file with no feature declared in module.bs: "
    "declare it, or make it private with a '_'"
)


def check_requirements(name: str) -> Iterator[validation.Issue]:
    """A module ships a changelog, a readme and an icon."""
    directory = workspace.directory(name)
    for file in ("CHANGELOG.md", "README.md", "pack.png"):
        if not (directory / file).is_file():
            yield validation.Issue("required file is missing", file)


def check_files(name: str) -> Iterator[validation.Issue]:
    """A public file belongs to a declared feature."""
    for path, _ in ownership.source_files(name):
        location = ownership.locate_in(name, path)
        if location and location.public and not location.feature:
            yield validation.Issue(UNDECLARED, path)


def check_headers(name: str) -> Iterator[validation.Issue]:
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
        yield validation.Issue("license header differs from the template", path, line)


def check_entries(name: str) -> Iterator[validation.Issue]:
    """An entry function belongs to a declared feature; `__macro__` to one that takes a macro."""
    module = workspace.load_module(name)
    for path, _ in ownership.source_files(name):
        location = ownership.locate_in(name, path)
        if location is None or location.registry != "function":
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
            yield validation.Issue(message, path)
        elif entry == "__macro__" and declared.macro_struct is None:
            message = "'__macro__' of a feature with no 'input arguments' or 'input macro'"
            yield validation.Issue(message, path)


def check_references(name: str) -> Iterator[validation.Issue]:
    """Every reference can be attributed to a feature or a module."""
    for problem in ownership.sources(name).problems:
        yield validation.Issue(problem.reason, problem.path, problem.reference.line)

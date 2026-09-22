import re
from collections.abc import Iterator

from mcbookshelf import constants, validation, workspace

DIRECTIVE = re.compile(r"^`{3,}\{feature\}[ \t]+(?:(\S+)[ \t]+)?#?(\S+)[ \t]*$", re.MULTILINE)
HEADING = re.compile(r"^#{1,6}[ \t]+\S")


def check_documentation(name: str) -> Iterator[validation.Issue]:
    """The docs page exists, and every feature has a directive right under a heading."""
    module = workspace.load_module(name)
    if not module.documentation.startswith(f"{constants.DOCS_PAGES_URL}/"):
        return
    page = constants.DOCS_DIR / module.documentation.removeprefix(f"{constants.DOCS_PAGES_URL}/")
    page = page.with_suffix(".md")
    shown = page.relative_to(constants.ROOT_DIR).as_posix()
    if not page.is_file():
        yield validation.Issue("documentation page is missing", shown)
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
            yield validation.Issue(str(error), shown, line)
            continue
        documented.add(feature)
        if not _under_heading(text, match.start()):
            where = f"#{feature.anchor} lands below the title"
            message = f"'{feature.name}' directive is not right under a heading: {where}"
            yield validation.Issue(message, shown, line)

    for feature in module.features:
        if feature not in documented:
            anchor = f"#{feature.anchor} resolves to nothing"
            message = f"'{feature.name}' has no {{feature}} directive: {anchor}"
            yield validation.Issue(message, shown)


def _under_heading(text: str, position: int) -> bool:
    """Whether the nearest line above a position, blank lines skipped, is a heading."""
    for line in reversed(text[:position].splitlines()):
        if line.strip():
            return HEADING.match(line) is not None
    return False

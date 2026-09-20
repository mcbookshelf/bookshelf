import re
from collections.abc import Iterator

from mcbookshelf import constants, validation, workspace

DIRECTIVE = re.compile(r"^`{3,}\{feature\}[ \t]+(?:(\S+)[ \t]+)?#?(\S+)[ \t]*$", re.MULTILINE)


def check_documentation(name: str) -> Iterator[validation.Issue]:
    """The docs page exists, and every feature has a directive that names it."""
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

    for feature in module.features:
        if feature not in documented:
            anchor = f"#{feature.anchor} resolves to nothing"
            message = f"'{feature.name}' has no {{feature}} directive: {anchor}"
            yield validation.Issue(message, shown)

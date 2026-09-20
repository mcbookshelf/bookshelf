from dataclasses import dataclass

from mcbookshelf import constants, workspace
from mcbookshelf.meta import MetadataError
from mcbookshelf.meta.diagnostics import locate
from mcbookshelf.validation import docs, layout, metadata


@dataclass(frozen=True, slots=True)
class Issue:

    message: str
    path: str
    line: int | None = None

    def __str__(self) -> str:
        return f"{locate(self.path, self.line)}: {self.message}"


def check_module(name: str) -> list[Issue]:
    """Run every check on a module; one that does not load has only what keeps it from loading."""
    try:
        workspace.load_module(name)
    except MetadataError as error:
        return [Issue(d.message, constants.MODULE_FILE, d.line) for d in error.diagnostics]
    checks = (
        layout.check_files,
        layout.check_headers,
        layout.check_entries,
        layout.check_references,
        layout.check_requirements,
        metadata.check_stamps,
        metadata.check_changelog,
        docs.check_documentation,
    )
    return [issue for check in checks for issue in check(name)]

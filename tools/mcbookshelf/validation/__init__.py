from mcbookshelf import constants, workspace
from mcbookshelf.meta import MetadataError
from mcbookshelf.validation import docs, layout, metadata
from mcbookshelf.validation.issue import Issue

__all__ = ["Issue", "check_module"]


def check_module(name: str) -> list[Issue]:
    """Run every check on a module; one that does not load has only what keeps it from loading."""
    ws = workspace.current()
    try:
        ws.load_module(name)
    except MetadataError as error:
        return [Issue(d.message, constants.MODULE_FILE, d.line) for d in error.diagnostics]
    checks = (
        layout.check_files,
        layout.check_headers,
        layout.check_entries,
        layout.check_references,
        layout.check_private,
        layout.check_requirements,
        metadata.check_stamps,
        metadata.check_changelog,
        docs.check_documentation,
    )
    return [issue for check in checks for issue in check(ws, name)]

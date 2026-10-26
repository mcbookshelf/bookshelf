"""A Sphinx kept alive between builds: a line of changed paths in, a line with the result out."""

import json
import logging
import sys
from io import StringIO
from pathlib import Path
from typing import TextIO

from mcbookshelf import constants, workspace
from sphinx.application import Sphinx
from sphinx.errors import SphinxError
from sphinx.util.console import nocolor

METADATA = (constants.MODULE_FILE, constants.BUNDLE_FILE)


def main(source: str, output: str, builder: str, language: str, fresh: str) -> None:
    results, sys.stdout = sys.stdout, sys.stderr
    # Set up first, so that no extension does it to log what its libraries have to say
    logging.basicConfig(level=logging.ERROR)
    nocolor()
    warnings = StringIO()
    app = Sphinx(
        source, source, output, str(Path(output) / ".doctrees"), builder,
        confoverrides={"language": language}, status=None, warning=warnings,
        freshenv=fresh == "fresh",
    )
    written: set[str] = set()
    app.connect("html-page-context", lambda _app, page, *_: written.add(page))

    send(results, build(app, written, warnings))
    for line in sys.stdin:
        if any(Path(path).name in METADATA for path in json.loads(line)):
            workspace.current.cache_clear()
        send(results, build(app, written, warnings))


def build(app: Sphinx, written: set[str], warnings: StringIO) -> dict[str, object]:
    """Build what changed, and tell the pages written, with the warnings or the error met."""
    written.clear()
    result: dict[str, object] = {}
    try:
        app.build()
    except SphinxError as error:
        result["error"] = f"{type(error).__name__}: {error}"
    result |= {"pages": sorted(written), "warnings": warnings.getvalue().strip()}
    warnings.seek(0)
    warnings.truncate()
    return result


def send(results: TextIO, result: dict[str, object]) -> None:
    results.write(json.dumps(result) + "\n")
    results.flush()


if __name__ == "__main__":
    main(*sys.argv[1:])

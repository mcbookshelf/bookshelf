import json
from pathlib import Path

from mcbookshelf import constants
from mcbookshelf.meta import parse_version
from mcbookshelf.workspace import history

DOCS = f"{constants.DOCS_URL}/en"


def write(target: Path) -> None:
    """Write the version switcher: dev, latest, then the last patch of each minor."""
    entries = [
        {"name": "dev", "version": "master", "url": f"{DOCS}/master/"},
        {"name": "latest", "version": "latest", "url": f"{DOCS}/latest/", "preferred": True},
    ]
    seen = set()
    for tag in sorted(history.remote_tags(), key=_key, reverse=True):
        version = tag[1:].partition("+")[0]
        minor = parse_version(version)[:2]
        if minor in seen:
            continue
        seen.add(minor)
        url = f"{DOCS}/v{version}/"
        entries.append({"name": version, "version": f"v{version}", "url": url})
    target.write_text(json.dumps(entries, indent=2) + "\n", "utf-8", newline="\n")


def _key(tag: str) -> tuple[tuple[int, int, int], str]:
    version, _, game = tag[1:].partition("+")
    return parse_version(version), game

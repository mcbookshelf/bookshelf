import json
import subprocess
from pathlib import Path

from mcbookshelf import constants
from mcbookshelf.version import parse_version
from mcbookshelf.workspace import history

DOCS = f"{constants.DOCS_URL}/en"


def write(target: Path) -> None:
    """Write the version switcher: dev, latest, then the last patch of each minor."""
    try:
        tags = history.remote_tags()
    except (OSError, subprocess.CalledProcessError):
        return  # offline or no origin: the last written switcher stays
    entries = [
        {"name": "dev", "version": "master", "url": f"{DOCS}/master/"},
        {"name": "latest", "version": "latest", "url": f"{DOCS}/latest/", "preferred": True},
    ]
    seen = set()
    for tag in sorted(tags, key=_key, reverse=True):
        version = tag[1:].partition("+")[0]
        minor = parse_version(version)[:2]
        if minor in seen:
            continue
        seen.add(minor)
        url = f"{DOCS}/v{version}/"
        entries.append({"name": version, "version": f"v{version}", "url": url})
    content = json.dumps(entries, indent=2) + "\n"
    # written only when it changes: a rewrite would retrigger a watching sphinx-autobuild
    if target.is_file() and target.read_text("utf-8") == content:
        return
    target.write_text(content, "utf-8", newline="\n")


def _key(tag: str) -> tuple[tuple[int, int, int], str]:
    version, _, game = tag[1:].partition("+")
    return parse_version(version), game

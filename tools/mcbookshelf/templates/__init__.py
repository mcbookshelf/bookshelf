from datetime import UTC, datetime
from functools import cache
from pathlib import Path

from jinja2 import Template

TEMPLATES_DIR = Path(__file__).parent


def year() -> int:
    return datetime.now(UTC).year


@cache
def header() -> str:
    template = Template((TEMPLATES_DIR / "header.jinja").read_text("utf-8"))
    return template.render(year=year()).strip()

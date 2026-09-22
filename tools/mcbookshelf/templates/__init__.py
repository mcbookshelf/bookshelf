from datetime import UTC, datetime
from functools import cache
from pathlib import Path

from jinja2 import Template

TEMPLATES_DIR = Path(__file__).parent


@cache
def header() -> str:
    template = Template((TEMPLATES_DIR / "header.jinja").read_text("utf-8"))
    return template.render(year=datetime.now(UTC).year).strip()

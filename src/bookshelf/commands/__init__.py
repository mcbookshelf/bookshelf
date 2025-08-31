"""CLI commands for the Bookshelf Library."""

from __future__ import annotations

from bookshelf.common import logging
from bookshelf.definitions import GITHUB_WORKSPACE

if GITHUB_WORKSPACE:
    logging.setup_github()
else:
    logging.setup_rich()

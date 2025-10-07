from __future__ import annotations

from os import getenv
from pathlib import Path

# ─── Project Info ────────────────────────────────────────────────────────────

VERSION = "3.2.0"
MC_VERSIONS = ["1.21.9", "1.21.10"]
GITHUB_REPO = "mcbookshelf/bookshelf"

# ─── Environment Flags ───────────────────────────────────────────────────────

GITHUB_WORKSPACE = bool(getenv("GITHUB_WORKSPACE"))

# ─── API & Documentation URLs ────────────────────────────────────────────────

DOC_URL = "https://docs.mcbookshelf.dev"
FABRIC_API = "https://meta.fabricmc.net/v2"
MODRINTH_API = "https://api.modrinth.com/v3"
SMITHED_API = "https://api.smithed.dev/v2"

# ─── Paths ───────────────────────────────────────────────────────────────────

SRC_DIR = Path(__file__).resolve().parents[1]
ROOT_DIR = SRC_DIR.parent
DOC_DIR = ROOT_DIR / "docs"
BUILD_DIR = ROOT_DIR / "build"
RELEASE_DIR = ROOT_DIR / "release"
SRC_MODULES_DIR = SRC_DIR / "bookshelf/data/modules"
SRC_EXAMPLES_DIR = SRC_DIR / "bookshelf/data/examples"
MODULES_DIR = SRC_MODULES_DIR if SRC_MODULES_DIR.exists() else ROOT_DIR / "modules"
EXAMPLES_DIR = SRC_EXAMPLES_DIR if SRC_EXAMPLES_DIR.exists() else ROOT_DIR / "examples"

SWITCHER_FILE = DOC_DIR / "_static" / "switcher.json"
MANIFEST_FILE = ROOT_DIR / "data" / "manifest.json"
VERSIONS_FILE = ROOT_DIR / "data" / "versions.json"

# ─── Dynamic Collections ─────────────────────────────────────────────────────

BUNDLES = sorted([
    e.name for e in MODULES_DIR.iterdir()
    if e.is_dir() and e.name.startswith("@")
])
MODULES = sorted([
    e.name for e in MODULES_DIR.iterdir()
    if e.is_dir() and e.name.startswith("bs.")
])
EXAMPLES = sorted([
    e.name.removesuffix(".md") for e in EXAMPLES_DIR.iterdir()
    if e.is_file() and e.name.endswith(".md")
])

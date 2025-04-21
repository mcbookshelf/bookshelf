from pathlib import Path

VERSION = "3.0.1"
MC_VERSIONS = ["1.21.5"]

DOC_URL = "https://docs.mcbookshelf.dev"
FABRIC_API = "https://meta.fabricmc.net/v2"
MODRINTH_API = "https://api.modrinth.com/v3"
SMITHED_API = "https://api.smithed.dev/v2"

GITHUB_REPO = "mcbookshelf/bookshelf"
RAW_PROJECT_URL = f"https://raw.githubusercontent.com/{GITHUB_REPO}/refs/tags/v{VERSION}/{{}}"

ROOT_DIR = Path(__file__).resolve().parents[1]
DOC_DIR = ROOT_DIR / "docs"
BUILD_DIR = ROOT_DIR / "build"
RELEASE_DIR = ROOT_DIR / "release"
EXAMPLES_DIR = ROOT_DIR / "examples"
MODULES_DIR = ROOT_DIR / "bookshelf/modules" \
    if (ROOT_DIR / "bookshelf/modules").exists() \
    else ROOT_DIR / "modules"

MODULES = sorted([
    mod.name
    for mod in MODULES_DIR.iterdir()
    if mod.is_dir() and mod.name.startswith("bs.")
])

from pathlib import Path

GAME_VERSION = "26.3-rc-2"
LOADER_VERSION = "5.0.0"

MACRO_SUFFIX = ".in"
PRIVATE_PREFIX = "_"
MODULE_FILE = "module.bs"
BUNDLE_FILE = "bundle.bs"

ROOT_DIR = Path(__file__).resolve().parents[2]
MODULES_DIR = ROOT_DIR / "modules"
EXAMPLES_DIR = ROOT_DIR / "examples"
DOCS_DIR = ROOT_DIR / "docs"
BUILD_DIR = ROOT_DIR / "build"
RELEASE_DIR = ROOT_DIR / "release"
BEET_CACHE_DIR = ROOT_DIR / ".beet_cache"

GITHUB_REPO = "mcbookshelf/bookshelf"
GITHUB_URL = f"https://github.com/{GITHUB_REPO}"
ISSUES_URL = f"{GITHUB_URL}/issues"
LICENSE_URL = f"{GITHUB_URL}/blob/master/LICENSE"
DOWNLOAD_URL = f"{GITHUB_URL}/releases/download/{{}}"
RAW_URL = f"https://raw.githubusercontent.com/{GITHUB_REPO}/refs/tags/{{}}"
DISCORD_URL = "https://discord.gg/aV5SF3JsAZ"
DOCS_URL = "https://docs.mcbookshelf.dev"
DOCS_PAGES_URL = f"{DOCS_URL}/en/latest"
DONATION_URL = "https://www.helloasso.com/associations/altearn/formulaires/3/en"

import os
import re
from pathlib import Path

from sphinx.application import Sphinx

# -- Project information -----------------------------------------------------

project = "Bookshelf"
copyright = "2025, Gunivers"  # noqa: A001
author = "Gunivers"


# -- General configuration ---------------------------------------------------

extensions = [
    "myst_parser",
    "sphinx_copybutton",
    "sphinx_design",
    "sphinx_minecraft",
    "sphinx_togglebutton",
    "sphinx_treeview",
]

exclude_patterns = ["_build", "Thumbs.db", ".DS_Store"]
suppress_warnings = ["misc.highlighting_failure"]
templates_path = ["_templates"]


# -- MyST options ------------------------------------------------------------

myst_heading_anchors = 6
myst_enable_extensions = [
    "amsmath",
    "colon_fence",
    "deflist",
    "dollarmath",
    "fieldlist",
    "html_admonition",
    "html_image",
    "linkify",
    "replacements",
    "smartquotes",
    "strikethrough",
    "substitution",
    "tasklist",
]

# -- Options for HTML output -------------------------------------------------

html_baseurl = os.environ.get("READTHEDOCS_CANONICAL_URL", "")
html_theme = "pydata_sphinx_theme"
html_logo = "_static/logo-bookshelf.png"
html_favicon = "_static/logo-bookshelf.png"

html_static_path = ["_static"]
html_css_files = ["bookshelf.css"]
html_js_files = ["bookshelf.js"]

html_context = {
    "github_user": "mcbookshelf",
    "github_repo": "Bookshelf",
    "github_version": "master",
    "doc_path": "docs",
    "READTHEDOCS": os.environ.get("READTHEDOCS", "") == "True",
}

json_url = "https://docs.mcbookshelf.dev/en/master/_static/switcher.json"
version_match = os.environ.get("READTHEDOCS_VERSION")

if not version_match or version_match.isdigit():
    version_match = "latest"

html_sidebars = {
    "CHANGELOG": [],
    "faq": [],
    "index": [],
    "quickstart": [],
    "special-thanks": [],
}

html_theme_options = {
    "navbar_start": ["navbar-logo", "version-switcher"],
    "navbar_persistent": ["search-button"],
    "navigation_with_keys": True,
    "use_edit_page_button": True,
    "footer_start": ["copyright"],
    "footer_center": ["mentions-legales.html"],
    "header_links_before_dropdown": 4,
    "logo": {
        "text": "Bookshelf",
        "image_dark": "_static/logo-bookshelf.png",
    },
    "switcher": {
        "json_url": json_url,
        "version_match": version_match,
    },
    "icon_links": [
        {
            "name": "GitHub",
            "url": "https://github.com/mcbookshelf/bookshelf",
            "icon": "fa-brands fa-github",
        },
        {
            "name": "Support us",
            "url": "https://www.helloasso.com/associations/altearn/formulaires/6/en",
            "icon": "fa-solid fa-heart",
        },
        {
            "name": "Discord server",
            "url": "https://discord.gg/MkXytNjmBt",
            "icon": "fa-brands fa-discord",
        },
        {
            "name": "Gunivers",
            "url": "https://gunivers.net",
            "icon": "_static/logo-gunivers.png",
            "type": "local",
        },
    ],
}

if version_match == "master":
    html_theme_options["announcement"] = (
        "⚠️ You are reading a doc of an undergoing development version. "
        "Information can be out of date and/or change at any time. ⚠️"
    )

BODY_PATTERN = re.compile(r"<body.*?>(.*?)</body>", re.DOTALL)
EMOJI_PATTERN = re.compile(
    r"[\U0001F600-\U0001F64F"
    r"\U0001F300-\U0001F5FF"
    r"\U0001F680-\U0001F6FF"
    r"\U0001F700-\U0001F77F"
    r"\U0001F780-\U0001F7FF"
    r"\U0001F800-\U0001F8FF"
    r"\U0001F900-\U0001F9FF"
    r"\U0001FA00-\U0001FA6F"
    r"\U0001FA70-\U0001FAFF"
    r"\u2600-\u26FF"
    r"\u2700-\u27BF"
    r"\U0001F000-\U0001F02F"
    r"\U0001F004\U0001F0CF"
    r"\U0001F46A-\U0001F46F"
    r"\U0001F170-\U0001F251"
    r"\U0001F1E6-\U0001F1FF"
    r"\U00002B50"
    r"]+",
)


def setup(app: Sphinx) -> None:
    """Set up the extension to replace emojis in the doctree."""
    app.connect("build-finished", replace_emojis_in_html_files)


def replace_emojis_in_html_files(app: Sphinx, _: object) -> None:
    """Replace emojis in the rendered HTML files after the build is finished."""
    output_dir = app.outdir
    for root, _, files in os.walk(output_dir):
        for file in files:
            if file.endswith(".html"):
                filepath = Path(root) / str(file)
                content = filepath.read_text("utf-8")
                if body_match := BODY_PATTERN.search(content):
                    body_content = body_match.group(1)
                    modified_body_content = EMOJI_PATTERN.sub(
                        lambda match: f'<span class="emoji">{match.group(0)}</span>',
                        body_content,
                    )
                    new_content = content.replace(body_content, modified_body_content)
                    if new_content != content:
                        filepath.write_text(new_content, "utf-8")

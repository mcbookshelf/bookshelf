import os

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
    "sphinx_treeview",
]

exclude_patterns = ["_build", "Thumbs.db", ".DS_Store"]
gettext_compact = False
gettext_uuid = True
locale_dirs = ["_locales"]
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
html_theme = "breeze"
html_title = "Bookshelf"
html_logo = "_static/logo-bookshelf.png"
html_favicon = "_static/logo-bookshelf.png"

html_static_path = ["_static"]
html_css_files = ["bookshelf.css"]
html_js_files = ["bookshelf.js"]

version_id = os.environ.get("READTHEDOCS_VERSION", "latest")

html_context = {
    "READTHEDOCS": os.environ.get("READTHEDOCS", "") == "True",
    "github_user": "mcbookshelf",
    "github_repo": "Bookshelf",
    "github_version": "master",
    "doc_path": "docs",
    "version_id": version_id,
    "version_switcher_url": "https://docs.mcbookshelf.dev/en/master/_static/switcher.json",
    "languages": [
        ("English", f"/en/{version_id}/%s/", "en"),
        ("中文", f"/zh-cn/{version_id}/%s/", "zh-cn"),
    ],
}


html_theme_options = {
    "emojis_sidebar_nav": True,
    "footer": [
        "footer-copyright.html",
        "footer-links.html",
        "external-links.html",
    ],
    "external_links": [
        "https://discord.gg/MkXytNjmBt",
        {
            "name": "Support us",
            "url": "https://www.helloasso.com/associations/altearn/formulaires/6/en",
            "icon": "heart-fill",
        },
        "https://github.com/mcbookshelf/bookshelf",
    ],
}

if os.environ.get("READTHEDOCS_VERSION") == "master":
    html_theme_options["announcement"] = (
        "⚠️ You are reading a doc of an undergoing development version. "
        "Information can be out of date and/or change at any time. ⚠️"
    )

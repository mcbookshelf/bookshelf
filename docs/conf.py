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
    "sphinx_togglebutton",
    "sphinx_treeview",
]

exclude_patterns = ["_build", "Thumbs.db", ".DS_Store"]
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
    "footer_center": ["mention-legales-footer.html"],
    "header_links_before_dropdown": 3,
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

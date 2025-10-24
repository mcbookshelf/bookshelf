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

version = os.environ.get("READTHEDOCS_VERSION", "latest")

html_context = {
    "READTHEDOCS": os.environ.get("READTHEDOCS", "") == "True",
    "github_user": "mcbookshelf",
    "github_repo": "Bookshelf",
    "github_version": "master",
    "doc_path": "docs",
    "current_version": version,
    "version_switcher": "https://docs.mcbookshelf.dev/en/master/_static/switcher.json",
    "languages": [
        ("English", f"/en/{version}/%s/", "en"),
        ("Français", f"/fr/{version}/%s/", "fr"),
        ("中文", f"/zh-cn/{version}/%s/", "zh-cn"),
    ],
}

discord = """
<svg xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 16 16">
    <path d="M13.545 2.907a13.2 13.2 0 0 0-3.257-1.011.05.05 0 0 0-.052.025c-.141.25-.297.577-.406.833a12.2 12.2 0 0 0-3.658 0 8 8 0 0 0-.412-.833.05.05 0 0 0-.052-.025c-1.125.194-2.22.534-3.257 1.011a.04.04 0 0 0-.021.018C.356 6.024-.213 9.047.066 12.032q.003.022.021.037a13.3 13.3 0 0 0 3.995 2.02.05.05 0 0 0 .056-.019q.463-.63.818-1.329a.05.05 0 0 0-.01-.059l-.018-.011a9 9 0 0 1-1.248-.595.05.05 0 0 1-.02-.066l.015-.019q.127-.095.248-.195a.05.05 0 0 1 .051-.007c2.619 1.196 5.454 1.196 8.041 0a.05.05 0 0 1 .053.007q.121.1.248.195a.05.05 0 0 1-.004.085 8 8 0 0 1-1.249.594.05.05 0 0 0-.03.03.05.05 0 0 0 .003.041c.24.465.515.909.817 1.329a.05.05 0 0 0 .056.019 13.2 13.2 0 0 0 4.001-2.02.05.05 0 0 0 .021-.037c.334-3.451-.559-6.449-2.366-9.106a.03.03 0 0 0-.02-.019m-8.198 7.307c-.789 0-1.438-.724-1.438-1.612s.637-1.613 1.438-1.613c.807 0 1.45.73 1.438 1.613 0 .888-.637 1.612-1.438 1.612m5.316 0c-.788 0-1.438-.724-1.438-1.612s.637-1.613 1.438-1.613c.807 0 1.451.73 1.438 1.613 0 .888-.631 1.612-1.438 1.612"></path>
</svg>
""" # noqa: E501

support = """
<svg xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 512 512">
    <path d="M47.6 300.4L228.3 469.1c7.5 7 17.4 10.9 27.7 10.9s20.2-3.9 27.7-10.9L464.4 300.4c30.4-28.3 47.6-68 47.6-109.5v-5.8c0-69.9-50.5-129.5-119.4-141C347 36.5 300.6 51.4 268 84L256 96 244 84c-32.6-32.6-79-47.5-124.6-39.9C50.5 55.6 0 115.2 0 185.1v5.8c0 41.5 17.2 81.2 47.6 109.5z"></path>
</svg>
""" # noqa: E501

html_theme_options = {
    "footer": [
        "footer-copyright.html",
        "mentions-legales.html",
        "external-links.html",
    ],
    "external_links": [
        {
            "name": "Discord",
            "url": "https://discord.gg/MkXytNjmBt",
            "html": discord,
        },
        {
            "name": "Support us",
            "url": "https://www.helloasso.com/associations/altearn/formulaires/6/en",
            "html": support,
        },
    ],
}

if os.environ.get("READTHEDOCS_VERSION") == "master":
    html_theme_options["announcement"] = (
        "⚠️ You are reading a doc of an undergoing development version. "
        "Information can be out of date and/or change at any time. ⚠️"
    )

import os

from docutils import nodes
from docutils.parsers.rst import directives
from docutils.statemachine import StringList

from mcbookshelf import workspace
from mcbookshelf.meta import Feature, Module, feature_id
from sphinx import addnodes
from sphinx.util.docutils import SphinxDirective

from . import markdown


def released_build() -> bool:
    kind = os.environ.get("READTHEDOCS_VERSION_TYPE", "")
    return kind == "tag" or os.environ.get("READTHEDOCS_VERSION") == "latest"


class FeatureDirective(SphinxDirective):

    required_arguments = 1
    optional_arguments = 1
    has_content = True
    option_spec = {  # noqa: RUF012
        "title": directives.unchanged,
        "form": directives.unchanged,
    }

    def run(self) -> list[nodes.Node]:
        *kind, reference = self.arguments
        namespace, _, name = reference.lstrip("#").partition(":")
        module = workspace.load_module(namespace)
        try:
            feature = module.find(name, kind[0] if kind else None)
        except LookupError as error:
            raise self.error(str(error)) from error
        if feature.experimental and released_build():
            return []
        form = self.options.get("form")
        if form is not None:
            return [self.describe(module, feature, macro=form == markdown.MACRO)]

        title = self.options.get("title") or markdown.title(name)
        section = nodes.section(
            ids=[feature.anchor],
            names=[nodes.fully_normalize_name(title)],
        )
        section += nodes.title(title, title)
        self.state.document.note_implicit_target(section, section)
        if feature.macro_struct is not None:
            inner = " ".join(self.arguments)
            section += self.parse(markdown.tabs(inner, list(self.content)))
        else:
            section += self.describe(module, feature, macro=False)
        return [section]

    def describe(self, module: Module, feature: Feature, *, macro: bool) -> nodes.Node:
        desc = addnodes.desc()
        desc["domain"], desc["objtype"] = "bs", "feature"
        desc["classes"] = ["bs", "feature"]
        signature = addnodes.desc_signature(classes=["sig", "sig-object", "bs"])
        signature += addnodes.desc_name(text=feature_id(module, feature, macro=macro))
        content = addnodes.desc_content()
        content += self.parse(markdown.feature(feature, macro=macro))
        content += self.extra()
        desc += signature
        desc += content
        return desc

    def parse(self, text: str) -> list[nodes.Node]:
        source = self.get_source_info()[0] or ""
        lines = text.split("\n")
        body = StringList(lines, items=[(source, i) for i in range(len(lines))])
        container = nodes.container()
        self.state.nested_parse(body, self.content_offset, container)
        return list(container.children)

    def extra(self) -> list[nodes.Node]:
        if not self.content:
            return []
        container = nodes.container()
        self.state.nested_parse(self.content, self.content_offset, container)
        return list(container.children)

import os

from docutils import nodes
from docutils.statemachine import StringList

from mcbookshelf import workspace
from mcbookshelf.meta import Feature
from sphinx import addnodes
from sphinx.util.docutils import SphinxDirective

from . import markdown

FORMS = ("storage", "macro")


def released_build() -> bool:
    kind = os.environ.get("READTHEDOCS_VERSION_TYPE", "")
    return kind == "tag" or os.environ.get("READTHEDOCS_VERSION") == "latest"


class FeatureDirective(SphinxDirective):

    required_arguments = 1
    optional_arguments = 1
    has_content = True

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
        # the page writes the heading: the anchor still lands on the feature, through
        # the heading when it carries the id, through a target of its own otherwise
        targets: list[nodes.Node] = []
        if feature.anchor not in self.state.document.ids:
            target = nodes.target(ids=[feature.anchor], names=[feature.anchor])
            self.state.document.note_explicit_target(target)
            targets.append(target)
        return [*targets, self.forms(feature)]

    def forms(self, feature: Feature) -> nodes.Node:
        """The description of a feature: one, or a storage and a macro form with a switch."""
        if feature.macro_struct is None:
            return self.describe(feature, macro=False)
        wrapper = nodes.container(classes=["bs-forms", f"bs-show-{FORMS[0]}"])
        for form in FORMS:
            wrapper += self.describe(feature, macro=form == "macro", switch=True)
        return wrapper

    def describe(self, feature: Feature, *, macro: bool, switch: bool = False) -> nodes.Node:
        form = "macro" if macro else "storage"
        desc = addnodes.desc()
        desc["domain"], desc["objtype"] = "bs", "feature"
        desc["classes"] = ["bs", "feature", f"bs-form-{form}"]
        signature = addnodes.desc_signature(classes=["sig", "sig-object", "bs"])
        signature += addnodes.desc_name(text=feature.macro_id if macro else feature.id)
        if switch:
            signature += nodes.raw("", self.switch(form), format="html")
        content = addnodes.desc_content()
        content += self.parse(markdown.feature(feature, macro=macro))
        content += self.extra()
        desc += signature
        desc += content
        return desc

    @staticmethod
    def switch(selected: str) -> str:
        """The segmented control on a signature, picking the form shown."""
        buttons = "".join(
            f'<button type="button" data-form="{form}"'
            f'{" aria-pressed=true" if form == selected else ""}>{form}</button>'
            for form in FORMS
        )
        return f'<span class="bs-switch" role="group">{buttons}</span>'

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

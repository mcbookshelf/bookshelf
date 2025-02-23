from docutils import nodes
from sphinx.application import Sphinx
from sphinx.util.docutils import SphinxRole

class DirectoryRole(SphinxRole):

    def run(self):
        svg = f'<span class="bs-dir-{self.text}" title="{self.text}"></span>'
        node = nodes.raw("", nodes.Text(svg), format="html")
        self.set_source_info(node)
        return [node], []


def setup(app: Sphinx):
    app.add_role('dir', DirectoryRole())

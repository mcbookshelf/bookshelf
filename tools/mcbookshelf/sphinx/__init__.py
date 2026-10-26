from sphinx.application import Sphinx

from .directive import FeatureDirective


def setup(app: Sphinx) -> dict[str, object]:
    app.add_directive("feature", FeatureDirective)
    return {"parallel_read_safe": True, "parallel_write_safe": True}

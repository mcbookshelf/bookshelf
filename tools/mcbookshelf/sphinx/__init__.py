import shutil
from pathlib import Path

from mcbookshelf import workspace
from mcbookshelf.meta import MetadataError
from sphinx.application import Sphinx

from .directive import FeatureDirective


def copy_structures(app: Sphinx, error: Exception | None) -> None:
    """Copy the structure files of every module, for the 3D views to read."""
    if error or app.builder.format != "html":
        return
    ws = workspace.current()
    target = Path(app.outdir) / "_static" / "structures"
    for name in ws.modules():
        try:
            features = ws.load_module(name).features
        except MetadataError:
            continue
        for feature in features:
            if feature.resource != "structure":
                continue
            source = ws.directory(name) / "data" / name / "structure" / f"{feature.name}.nbt"
            file = target / name / f"{feature.name}.nbt"
            file.parent.mkdir(parents=True, exist_ok=True)
            shutil.copyfile(source, file)


def setup(app: Sphinx) -> dict[str, object]:
    app.add_directive("feature", FeatureDirective)
    app.connect("build-finished", copy_structures)
    return {"parallel_read_safe": True, "parallel_write_safe": True}

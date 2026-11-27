import shutil

import orjson
from beet import Context
from beet.contrib.autosave import Autosave

from mcbookshelf import constants, workspace
from mcbookshelf.meta.mcdoc import render_module
from mcbookshelf.pipeline.config import module_of


def beet_default(ctx: Context) -> None:
    ctx.inject(Autosave).add_output(save)


def save(ctx: Context) -> None:
    """Write what the module generated outside its sources, its mcdoc, and its fingerprint."""
    module = module_of(ctx)
    base = workspace.current().directory(module.id)
    sources = {file.relative_to(base).as_posix() for file in base.rglob("*") if file.is_file()}
    stub = constants.STUB_DIR
    shutil.rmtree(stub / "data" / module.id, ignore_errors=True)
    files = {
        path: file.ensure_serialized()
        for path, file in ctx.data.list_files()
        if path.startswith(f"data/{module.id}/") and path not in sources
    }
    files[f"mcdoc/{module.short}.mcdoc"] = render_module(module)
    pack = {**ctx.data.mcmeta.data["pack"], "description": "Files the Bookshelf modules generate."}
    files["pack.mcmeta"] = orjson.dumps({"pack": pack})
    files[f"data/{module.id}/{constants.FINGERPRINT_FILE}"] = ctx.meta["fingerprint"]
    for path, content in files.items():
        target = stub / path
        target.parent.mkdir(parents=True, exist_ok=True)
        target.write_bytes(content.encode() if isinstance(content, str) else content)

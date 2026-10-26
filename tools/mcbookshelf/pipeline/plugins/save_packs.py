import shutil
import stat
import tempfile
from collections.abc import Callable
from concurrent.futures import ThreadPoolExecutor
from contextlib import suppress
from pathlib import Path
from uuid import uuid4

from beet import Context, DataPack, ResourcePack
from beet.contrib.autosave import Autosave
from beet.contrib.link import LinkManager

from mcbookshelf.pipeline.config import build_of

WORKERS = 8
DELETION_POOL = ThreadPoolExecutor(max_workers=1)


def beet_default(ctx: Context) -> None:
    ctx.inject(Autosave).add_output(save)


def save(ctx: Context) -> None:
    """Write the packs to the output folder and the linked world, faster than beet on Windows."""
    if not (directory := ctx.meta.get("output")):
        return
    link = ctx.inject(LinkManager) if build_of(ctx).link else None
    linked = (link.resource_pack, link.data_pack) if link else (None, None)
    for pack, world in zip(ctx.packs, linked, strict=True):
        if not pack:
            continue
        if pack.zipped:
            target = pack.save(directory, overwrite=True)
        else:
            target = Path(directory).resolve() / (pack.name or pack.default_name)
            write(pack, target, target.parent)
            pack.path = target.parent
        if link and world:
            copy = Path(world) / target.name
            if pack.zipped:
                shutil.copyfile(target, copy)
            else:
                write(pack, copy, Path(world).parent / ".trash")


def write(pack: DataPack | ResourcePack, target: Path, trash: Path) -> None:
    """Replace the folder instantly by moving it and purging in a thread."""
    if target.exists():
        try:
            staged_trash = staging(target, trash) / f".bookshelf-trash-{uuid4().hex}"
            target.rename(staged_trash)
            DELETION_POOL.submit(_silent_purge, staged_trash)
        except OSError:
            _silent_purge(target)

    files = list(pack.list_files())
    for folder in {target / path.rpartition("/")[0] for path, _ in files}:
        folder.mkdir(parents=True, exist_ok=True)

    with ThreadPoolExecutor(WORKERS) as pool:
        list(pool.map(lambda entry: entry[1].dump(target, entry[0]), files))


def staging(target: Path, trash: Path) -> Path:
    """Where to move a folder before purging it: the temp folder, or `trash` if on another drive."""
    temp = Path(tempfile.gettempdir())
    if temp.stat().st_dev == target.stat().st_dev:
        return temp
    trash.mkdir(exist_ok=True)
    return trash


def _silent_purge(folder: Path) -> None:
    """Core deletion sequence targeting filesystem permission roadblocks under Windows."""
    if not folder.exists():
        return

    def handle_readonly(func: Callable[[str], object], path: str, _error: BaseException) -> None:
        """Clears Windows Read-Only file flags dynamically if shutil hits permission obstacles."""
        with suppress(OSError):
            Path(path).chmod(stat.S_IWRITE)
            func(path)

    shutil.rmtree(folder, onexc=handle_readonly)

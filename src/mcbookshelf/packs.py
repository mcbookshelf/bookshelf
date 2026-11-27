from collections.abc import Callable, Iterable
from pathlib import Path

from beet import DataPack


def load_pack(file: Path, paths: Iterable[str] | None = None) -> DataPack:
    """Load a module zip, optionally keeping only the given data paths."""
    pack = DataPack(path=file)
    pack.extra.clear()
    if paths is not None:
        wanted = set(paths)
        prune(pack, lambda path: path in wanted)
    return pack


def prune(pack: DataPack, keep: Callable[[str], bool]) -> None:
    """Remove every file from the pack whose path the predicate rejects."""
    kept = {id(file) for path, file in pack.list_files() if keep(path)}
    for namespace in pack.values():
        for container in namespace.values():
            for key in [k for k, file in container.items() if id(file) not in kept]:
                del container[key]

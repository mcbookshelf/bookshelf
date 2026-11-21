import shutil
from collections.abc import Callable, Generator
from contextlib import contextmanager
from pathlib import Path
from time import time_ns

from beet import DataPack, Function, FunctionTag, ProjectCache
from beet.contrib.link import LinkManager

from mcbookshelf import constants
from mcbookshelf.minecraft import snbt

from .plugins.update_mcmeta import formats

POLLER = "bs.livereload"
TRIGGER = "bs.livereload-"


@contextmanager
def livereload() -> Generator[Callable[[], None]]:
    """Reload the linked world after each rebuild, when its poller notices a new trigger pack."""
    with ProjectCache(constants.BEET_CACHE_DIR, constants.BEET_CACHE_DIR / "generated") as cache:
        world = LinkManager(cache).data_pack
        version = formats(cache["version"])["data_pack_version"]
    if not world:
        yield lambda: None
        return

    poller(version).save(world, overwrite=True)

    def reload() -> None:
        clear(world, f"{TRIGGER}*")
        pack(f"{TRIGGER}{time_ns()}", version).save(world)

    try:
        yield reload
    finally:
        clear(world, f"{POLLER}*")


def clear(world: str, pattern: str) -> None:
    for old in Path(world).glob(pattern):
        shutil.rmtree(old, ignore_errors=True)


def pack(name: str, version: int) -> DataPack:
    data = DataPack(name, description="Bookshelf livereload, for development only.")
    data.min_format = data.max_format = version
    return data


def poller(version: int) -> DataPack:
    """Run `/reload` when more packs are available than at the last load."""
    data = pack(POLLER, version)
    data["minecraft:load"] = FunctionTag({"values": ["bs.livereload:load"]})
    data["bs.livereload:enable"] = FunctionTag({"values": ["bs.livereload:enable"]})
    data["bs.livereload:disable"] = FunctionTag({"values": ["bs.livereload:disable"]})

    data["bs.livereload:load"] = Function([
        "scoreboard objectives add bs.livereload dummy",
        "execute store result score #packs bs.livereload run datapack list available",
        "execute if score #disabled bs.livereload matches 1 run return fail",
        (
            "execute if score #done bs.livereload matches 1 run "
            f"tellraw @a {message('⚡', "#ECB643", 'Reloaded')}"
        ),
        (
            "execute unless score #done bs.livereload matches 1 run "
            f"tellraw @a {message('✔', '#4CCB5E', 'Livereload enabled')}"
        ),
        "scoreboard players reset #done bs.livereload",
        "schedule function bs.livereload:poll 10t replace",
    ])
    data["bs.livereload:poll"] = Function([
        "schedule function bs.livereload:poll 10t replace",
        "execute store result score #new bs.livereload run datapack list available",
        "execute if score #new bs.livereload <= #packs bs.livereload run return fail",
        "reload",
        "scoreboard players set #done bs.livereload 1",
    ])
    data["bs.livereload:enable"] = Function([
        "scoreboard players reset #disabled bs.livereload",
        f"tellraw @a {message('✔', '#4CCB5E', 'Livereload enabled')}",
        "function bs.livereload:poll",
    ])
    data["bs.livereload:disable"] = Function([
        "scoreboard players set #disabled bs.livereload 1",
        "schedule clear bs.livereload:poll",
        f"tellraw @a {message('✘', '#E84635', 'Livereload disabled')}",
    ])
    return data


def message(icon: str, color: str, text: str) -> str:
    """A chat line with a colored icon."""
    return snbt.dumps([
        {"text": f"{icon} ", "color": color},
        {"text": text, "color": "gray"},
    ])

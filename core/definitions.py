import os
import sys
from pathlib import Path

VERSION = "2.2.2"
MINECRAFT_VERSIONS = ["1.21.2", "1.21.3", "1.21.4"]

DOC_URL = "https://docs.mcbookshelf.dev"
DOC_SWITCHER = "docs/_static/switcher.json"
GITHUB_REPO = "mcbookshelf/Bookshelf"
META_MANIFEST = "meta/manifest.json"
META_VERSIONS = "meta/versions.json"
MODRINTH_API = "https://api.modrinth.com/v3"
SMITHED_API = "https://api.smithed.dev/v2"

ROOT_DIR = Path(__file__).resolve().parents[1]
BUILD_DIR = ROOT_DIR / "build"
DOC_DIR = ROOT_DIR / "docs"
MODULES_DIR = ROOT_DIR / "modules"
RELEASE_DIR = ROOT_DIR / "release"

MODULES = sorted([
    mod
    for mod in os.listdir(MODULES_DIR)
    if (MODULES_DIR / mod).is_dir() and mod.startswith("bs.")
])

MASTER_URL = f"https://raw.githubusercontent.com/{GITHUB_REPO}/refs/heads/master/{{}}"
BIOMES_URL = "https://raw.githubusercontent.com/misode/mcmeta/{}-summary/data/worldgen/biome/data.min.json"
BLOCKS_URL = "https://raw.githubusercontent.com/misode/mcmeta/{}-summary/blocks/data.min.json"
ITEMS_URL = "https://raw.githubusercontent.com/misode/mcmeta/{}-registries/item/data.min.json"
SOUNDS_URL = "https://raw.githubusercontent.com/mcbookshelf/Bookshelf-McData/refs/tags/{}/blocks/sounds.min.json"
SHAPES_URL = "https://raw.githubusercontent.com/mcbookshelf/Bookshelf-McData/refs/tags/{}/blocks/shapes.min.json"
VERSION_URL = "https://raw.githubusercontent.com/misode/mcmeta/refs/tags/{}-summary/version.json"

SPECIAL_ITEMS = {
  "minecraft:acacia_wall_hanging_sign": "minecraft:acacia_hanging_sign",
  "minecraft:acacia_wall_sign": "minecraft:acacia_sign",
  "minecraft:attached_melon_stem": "minecraft:melon_seeds",
  "minecraft:attached_pumpkin_stem": "minecraft:melon_seeds",
  "minecraft:bamboo_wall_hanging_sign": "minecraft:bamboo_hanging_sign",
  "minecraft:bamboo_wall_sign": "minecraft:bamboo_sign",
  "minecraft:beetroots": "minecraft:beetroot_seeds",
  "minecraft:big_dripleaf_stem": "minecraft:big_dripleaf",
  "minecraft:birch_wall_hanging_sign": "minecraft:birch_hanging_sign",
  "minecraft:birch_wall_sign": "minecraft:birch_sign",
  "minecraft:black_wall_banner": "minecraft:black_banner",
  "minecraft:blue_wall_banner": "minecraft:blue_banner",
  "minecraft:brain_coral_wall_fan": "minecraft:brain_coral_fan",
  "minecraft:brown_wall_banner": "minecraft:brown_banner",
  "minecraft:bubble_coral_wall_fan": "minecraft:bubble_coral_fan",
  "minecraft:carrots": "minecraft:carrot",
  "minecraft:cave_vines_plant": "minecraft:glow_berries",
  "minecraft:cave_vines": "minecraft:glow_berries",
  "minecraft:cherry_wall_hanging_sign": "minecraft:cherry_hanging_sign",
  "minecraft:cherry_wall_sign": "minecraft:cherry_sign",
  "minecraft:cocoa": "minecraft:cocoa_beans",
  "minecraft:creeper_wall_head": "minecraft:creeper_head",
  "minecraft:crimson_wall_hanging_sign": "minecraft:crimson_hanging_sign",
  "minecraft:crimson_wall_sign": "minecraft:crimson_sign",
  "minecraft:cyan_wall_banner": "minecraft:cyan_banner",
  "minecraft:dark_oak_wall_hanging_sign": "minecraft:dark_oak_hanging_sign",
  "minecraft:dark_oak_wall_sign": "minecraft:dark_oak_sign",
  "minecraft:dead_brain_coral_wall_fan": "minecraft:dead_brain_coral_fan",
  "minecraft:dead_bubble_coral_wall_fan": "minecraft:dead_bubble_coral_fan",
  "minecraft:dead_fire_coral_wall_fan": "minecraft:dead_fire_coral_fan",
  "minecraft:dead_horn_coral_wall_fan": "minecraft:dead_horn_coral_fan",
  "minecraft:dead_tube_coral_wall_fan": "minecraft:dead_tube_coral_fan",
  "minecraft:dragon_wall_head": "minecraft:dragon_head",
  "minecraft:fire_coral_wall_fan": "minecraft:fire_coral_fan",
  "minecraft:gray_wall_banner": "minecraft:gray_banner",
  "minecraft:green_wall_banner": "minecraft:green_banner",
  "minecraft:horn_coral_wall_fan": "minecraft:horn_coral_fan",
  "minecraft:jungle_wall_hanging_sign": "minecraft:jungle_hanging_sign",
  "minecraft:jungle_wall_sign": "minecraft:jungle_sign",
  "minecraft:lava_cauldron": "minecraft:cauldron",
  "minecraft:lava": "minecraft:lava_bucket",
  "minecraft:light_blue_wall_banner": "minecraft:light_blue_banner",
  "minecraft:light_gray_wall_banner": "minecraft:light_gray_banner",
  "minecraft:lime_wall_banner": "minecraft:lime_banner",
  "minecraft:magenta_wall_banner": "minecraft:magenta_banner",
  "minecraft:mangrove_wall_hanging_sign": "minecraft:mangrove_hanging_sign",
  "minecraft:mangrove_wall_sign": "minecraft:mangrove_sign",
  "minecraft:melon_stem": "minecraft:pumpkin_seeds",
  "minecraft:oak_wall_hanging_sign": "minecraft:oak_hanging_sign",
  "minecraft:oak_wall_sign": "minecraft:oak_sign",
  "minecraft:orange_wall_banner": "minecraft:orange_banner",
  "minecraft:piglin_wall_head": "minecraft:piglin_head",
  "minecraft:pink_wall_banner": "minecraft:pink_banner",
  "minecraft:pitcher_crop": "minecraft:pitcher_pod",
  "minecraft:player_wall_head": "minecraft:player_head",
  "minecraft:potatoes": "minecraft:potato",
  "minecraft:powder_snow_cauldron": "minecraft:cauldron",
  "minecraft:powder_snow": "minecraft:powder_snow_bucket",
  "minecraft:pumpkin_stem": "minecraft:pumpkin_seeds",
  "minecraft:purple_wall_banner": "minecraft:purple_banner",
  "minecraft:red_wall_banner": "minecraft:red_banner",
  "minecraft:redstone_wall_torch": "minecraft:redstone_torch",
  "minecraft:redstone_wire": "minecraft:redstone",
  "minecraft:skeleton_wall_skull": "minecraft:skeleton_skull",
  "minecraft:soul_wall_torch": "minecraft:soul_torch",
  "minecraft:spruce_wall_hanging_sign": "minecraft:spruce_hanging_sign",
  "minecraft:spruce_wall_sign": "minecraft:spruce_sign",
  "minecraft:sweet_berry_bush": "minecraft:sweet_berries",
  "minecraft:torchflower_crop": "minecraft:torchflower_seeds",
  "minecraft:tripwire": "minecraft:string",
  "minecraft:tube_coral_wall_fan": "minecraft:tube_coral_fan",
  "minecraft:wall_torch": "minecraft:torch",
  "minecraft:warped_wall_hanging_sign": "minecraft:warped_hanging_sign",
  "minecraft:warped_wall_sign": "minecraft:warped_sign",
  "minecraft:water_cauldron": "minecraft:cauldron",
  "minecraft:water": "minecraft:water_bucket",
  "minecraft:wheat": "minecraft:wheat_seeds",
  "minecraft:white_wall_banner": "minecraft:white_banner",
  "minecraft:wither_skeleton_wall_skull": "minecraft:wither_skeleton_skull",
  "minecraft:yellow_wall_banner": "minecraft:yellow_banner",
  "minecraft:zombie_wall_head": "minecraft:zombie_head",
}

if __name__ == "__main__":
    if len(sys.argv) > 1:
        value = globals().get(sys.argv[1], None)
        print(str(value)) # noqa: T201

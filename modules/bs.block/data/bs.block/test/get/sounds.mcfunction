# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2026 Gunivers
#
# This file is part of the Bookshelf project (https://github.com/mcbookshelf/bookshelf).
#
# This source code is subject to the terms of the Mozilla Public License, v. 2.0.
# If a copy of the MPL was not distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# Conditions:
# - You may use this file in compliance with the MPL v2.0
# - Any modifications must be documented and disclosed under the same license
#
# For more details, refer to the MPL v2.0.
# ------------------------------------------------------------------------------------------------------------

data modify storage bs:out block set value {}

setblock ~ ~ ~ minecraft:obsidian
function #bs.block:get_sounds
assert data storage bs:out block{ sounds: { break: "minecraft:block.stone.break", fall: "minecraft:block.stone.fall", hit: "minecraft:block.stone.hit", place: "minecraft:block.stone.place", step: "minecraft:block.stone.step" } }

setblock ~ ~ ~ minecraft:bookshelf
function #bs.block:get_sounds
assert data storage bs:out block{ sounds: { break: "minecraft:block.wood.break", fall: "minecraft:block.wood.fall", hit: "minecraft:block.wood.hit", place: "minecraft:block.wood.place", step: "minecraft:block.wood.step" } }

setblock ~ ~ ~ minecraft:glowstone
function #bs.block:get_sounds
assert data storage bs:out block{ sounds: { break: "minecraft:block.glass.break", fall: "minecraft:block.glass.fall", hit: "minecraft:block.glass.hit", place: "minecraft:block.glass.place", step: "minecraft:block.glass.step" } }

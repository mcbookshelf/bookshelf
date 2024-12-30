# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2024 Gunivers
#
# This file is part of the Bookshelf project (https://github.com/mcbookshelf/Bookshelf).
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

setblock ~ ~ ~ minecraft:stone_stairs[facing=west,half=top,shape=straight,waterlogged=false]
function #bs.block:get_block
setblock ~ ~ ~ minecraft:furnace[facing=north]
function #bs.block:merge_properties {properties:[{name:"facing"}]}

assert data storage bs:out block{ block: "minecraft:stone_stairs[shape=straight,half=top,facing=north,waterlogged=false,]", type: "minecraft:stone_stairs", state: "[shape=straight,half=top,facing=north,waterlogged=false,]", properties: { facing: "north", half: "top", shape: "straight", waterlogged: "false" } }

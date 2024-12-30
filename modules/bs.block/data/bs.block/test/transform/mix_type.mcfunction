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

setblock ~ ~ ~ minecraft:mossy_stone_bricks
function #bs.block:get_block

function #bs.block:mix_type {type:"minecraft:cobblestone",mapping_registry:"bs.shapes"}
assert data storage bs:out block{ block: "minecraft:mossy_cobblestone" }

setblock ~ ~ ~ minecraft:mossy_cobblestone
function #bs.block:get_block

function #bs.block:mix_type {type:"minecraft:stone_bricks",mapping_registry:"bs.shapes"}
assert data storage bs:out block{ block: "minecraft:mossy_stone_bricks" }

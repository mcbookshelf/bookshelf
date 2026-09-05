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

data modify storage bs:in block.spawn_block_display.type set value "minecraft:oak_stairs"
data modify storage bs:in block.spawn_block_display.properties set value {waterlogged:"true"}
data modify storage bs:in block.spawn_block_display.extra_nbt set value {Tags:["bs.ward"]}
function #bs.block:spawn_block_display

assert entity @n[type=minecraft:block_display,tag=bs.ward] inside
assert data entity @n[type=minecraft:block_display,tag=bs.ward] {block_state:{id:"minecraft:oak_stairs",properties:{waterlogged:"true"}}}

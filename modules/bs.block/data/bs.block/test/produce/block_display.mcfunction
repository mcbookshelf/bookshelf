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

data modify storage bs:in block.spawn_block_display.type set value "minecraft:bookshelf"
data modify storage bs:in block.spawn_block_display.extra_nbt set value {Tags:["bs.packtest"]}
function #bs.block:spawn_block_display

assert entity @e[type=minecraft:block_display,tag=bs.packtest] inside

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

execute if block ~ ~ ~ #bs.hitbox:has_no_outline run return 0
execute if block ~ ~ ~ #bs.hitbox:is_full_cube_outline store result storage bs.hitbox:get_block out int 1 run return 1
execute if block ~ ~ ~ #bs.hitbox:has_shape_offset align xyz summon minecraft:marker run function bs.hitbox:get_block/offset
data modify storage bs.hitbox: i set compute block ~ ~ ~ integer bs.hitbox:_get_block/outline/index
function bs.hitbox:get_block/lookup with storage bs.hitbox:
execute unless data storage bs.hitbox:get_block out[0] run return 0
data modify storage bs.hitbox:get_block out[] append value 1.
return 1

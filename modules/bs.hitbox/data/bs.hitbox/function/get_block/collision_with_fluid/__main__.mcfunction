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

execute unless block ~ ~ ~ #bs.hitbox:has_fluid unless block ~ ~ ~ #bs.hitbox:is_waterloggable[waterlogged=true] run return run function bs.hitbox:get_block/collision/__main__
execute if block ~ ~ ~ #bs.hitbox:has_no_collision run return run function bs.hitbox:get_block/fluid_no_shape
execute if block ~ ~ ~ #bs.hitbox:is_full_cube_collision run return run function bs.hitbox:get_block/fluid_full_cube
execute if block ~ ~ ~ #bs.hitbox:has_shape_offset align xyz summon minecraft:marker run function bs.hitbox:get_block/offset
data modify storage bs.hitbox: i set compute block ~ ~ ~ integer bs.hitbox:_get_block/collision/index
function bs.hitbox:get_block/lookup with storage bs.hitbox:
execute if data storage bs.hitbox:get_block out[0] run data modify storage bs.hitbox:get_block out[] append value 1.
execute if predicate bs.hitbox:_get_block/same_fluid_above run return run data modify storage bs.hitbox:get_block out append value [0.,0.,0.,1.,1.,1.,2.]
return run data modify storage bs.hitbox:get_block out append value [0.,0.,0.,1.,.8888888955116272,1.,2.]

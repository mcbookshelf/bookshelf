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

execute store result score #n bs.ctx run data get storage bs:data raycast.record[-1].norm
execute if score #n bs.ctx matches 1 if score #raycast.ux bs.data matches ..-1 run scoreboard players set $raycast.hit_face bs.lambda 5
execute if score #n bs.ctx matches 1 if score #raycast.ux bs.data matches 0.. run scoreboard players set $raycast.hit_face bs.lambda 4
execute if score #n bs.ctx matches 2 if score #raycast.uz bs.data matches ..-1 run scoreboard players set $raycast.hit_face bs.lambda 3
execute if score #n bs.ctx matches 2 if score #raycast.uz bs.data matches 0.. run scoreboard players set $raycast.hit_face bs.lambda 2
execute if score #n bs.ctx matches 3 if score #raycast.uy bs.data matches ..-1 run scoreboard players set $raycast.hit_face bs.lambda 1
execute if score #n bs.ctx matches 3 if score #raycast.uy bs.data matches 0.. run scoreboard players set $raycast.hit_face bs.lambda 0

execute if data storage bs:data raycast.data{hit_normal:1b} run function bs.raycast:utils/get_hit_normal
execute if data storage bs:data raycast.data{hit_point:1b} positioned as @s run function bs.raycast:utils/get_hit_point
execute if data storage bs:data raycast.data{targeted_block:1b} run function bs.raycast:utils/get_targeted_block

execute if data storage bs:lambda hitbox run function bs.raycast:collide/block/target
execute store result score $raycast.hit_flag bs.lambda run data get storage bs:data raycast.record[-1].flag

execute if data storage bs:data raycast.on_hit_point positioned as @s run function bs.raycast:collide/block/point

scoreboard players operation #raycast.bpiercing bs.data = $raycast.piercing bs.lambda
execute unless data storage bs:data raycast.piercing{} run scoreboard players operation #raycast.epiercing bs.data = #raycast.bpiercing bs.data

data remove storage bs:data raycast.record[-1]
execute unless data storage bs:data raycast.record[-1] run return run scoreboard players set #raycast.btoi bs.data 2147483647
execute store result score #raycast.btoi bs.data run data get storage bs:data raycast.record[-1].tmin

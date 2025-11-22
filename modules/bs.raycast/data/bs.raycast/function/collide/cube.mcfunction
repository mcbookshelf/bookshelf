# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Gunivers
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

execute if score #raycast.bpiercing bs.data matches 0.. run scoreboard players remove #raycast.bpiercing bs.data 1
scoreboard players operation $raycast.piercing bs.lambda = #raycast.bpiercing bs.data

execute store result score $raycast.distance bs.lambda run scoreboard players operation #raycast.lx bs.data -= #raycast.dx bs.data
scoreboard players operation #raycast.ly bs.data -= #raycast.dy bs.data
scoreboard players operation #raycast.lz bs.data -= #raycast.dz bs.data
scoreboard players operation $raycast.distance bs.lambda > #raycast.ly bs.data
scoreboard players operation $raycast.distance bs.lambda > #raycast.lz bs.data

scoreboard players operation $raycast.pierce_distance bs.lambda -= $raycast.distance bs.lambda
scoreboard players operation $raycast.pierce_distance bs.lambda *= -1 bs.const

execute if score #raycast.ux bs.data matches ..-1 run scoreboard players set $raycast.hit_face bs.lambda 5
execute if score #raycast.ux bs.data matches 0.. run scoreboard players set $raycast.hit_face bs.lambda 4
execute if score $raycast.distance bs.lambda = #raycast.lz bs.data if score #raycast.uz bs.data matches ..-1 run scoreboard players set $raycast.hit_face bs.lambda 3
execute if score $raycast.distance bs.lambda = #raycast.lz bs.data if score #raycast.uz bs.data matches 0.. run scoreboard players set $raycast.hit_face bs.lambda 2
execute if score $raycast.distance bs.lambda = #raycast.ly bs.data if score #raycast.uy bs.data matches ..-1 run scoreboard players set $raycast.hit_face bs.lambda 1
execute if score $raycast.distance bs.lambda = #raycast.ly bs.data if score #raycast.uy bs.data matches 0.. run scoreboard players set $raycast.hit_face bs.lambda 0

data remove storage bs:lambda raycast
execute store result storage bs:lambda raycast.distance double .001 run scoreboard players get $raycast.distance bs.lambda
execute if data storage bs:data raycast.data{hit_normal:1b} run function bs.raycast:utils/get_hit_normal
execute if data storage bs:data raycast.data{hit_point:1b} positioned as @s run function bs.raycast:utils/get_hit_point
execute if data storage bs:data raycast.data{targeted_block:1b} run function bs.raycast:utils/get_targeted_block

execute if data storage bs:data raycast.on_targeted_block run function bs.raycast:utils/on_targeted_block with storage bs:data raycast
execute if data storage bs:data raycast.on_hit_point positioned as @s run function bs.raycast:collide/block/point

execute if score $raycast.piercing bs.lambda matches 0 run return run scoreboard players set #raycast.max_distance bs.data -2147483648

scoreboard players operation $raycast.distance bs.lambda = #raycast.etoi bs.data
scoreboard players operation #raycast.bpiercing bs.data = $raycast.piercing bs.lambda
execute unless data storage bs:data raycast.piercing{} run scoreboard players operation #raycast.epiercing bs.data = #raycast.bpiercing bs.data

scoreboard players operation #raycast.lx bs.data += #raycast.dx bs.data
scoreboard players operation #raycast.ly bs.data += #raycast.dy bs.data
scoreboard players operation #raycast.lz bs.data += #raycast.dz bs.data

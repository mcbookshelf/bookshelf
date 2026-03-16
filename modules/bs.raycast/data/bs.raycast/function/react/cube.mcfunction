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

execute if score #raycast.pb bs.data matches 0.. run scoreboard players remove #raycast.pb bs.data 1
scoreboard players operation $raycast.piercing bs.lambda = #raycast.pb bs.data

execute store result score $raycast.exit_distance bs.lambda run scoreboard players get #raycast.lx bs.data
scoreboard players operation $raycast.exit_distance bs.lambda < #raycast.ly bs.data
execute store result storage bs:data raycast.tmax double .001 \
  store result score $raycast.exit_point.x bs.lambda \
  store result score $raycast.exit_point.y bs.lambda \
  store result score $raycast.exit_point.z bs.lambda \
 run scoreboard players operation $raycast.exit_distance bs.lambda < #raycast.lz bs.data

execute store result score $raycast.targeted_block.x bs.lambda store result score #raycast.tm bs.data run scoreboard players operation #raycast.lx bs.data -= #raycast.dx bs.data
execute store result score $raycast.targeted_block.y bs.lambda run scoreboard players operation #raycast.ly bs.data -= #raycast.dy bs.data
execute store result score $raycast.targeted_block.z bs.lambda run scoreboard players operation #raycast.lz bs.data -= #raycast.dz bs.data
scoreboard players operation #raycast.tm bs.data > #raycast.ly bs.data
execute store result storage bs:data raycast.tmin double .001 \
  store result score $raycast.entry_point.x bs.lambda \
  store result score $raycast.entry_point.y bs.lambda \
  store result score $raycast.entry_point.z bs.lambda \
  store result score $raycast.entry_distance bs.lambda run scoreboard players operation #raycast.tm bs.data > #raycast.lz bs.data

scoreboard players operation $raycast.targeted_block.x bs.lambda /= #raycast.dx bs.data
scoreboard players operation $raycast.targeted_block.y bs.lambda /= #raycast.dy bs.data
scoreboard players operation $raycast.targeted_block.z bs.lambda /= #raycast.dz bs.data
scoreboard players add $raycast.targeted_block.x bs.lambda 1
scoreboard players add $raycast.targeted_block.y bs.lambda 1
scoreboard players add $raycast.targeted_block.z bs.lambda 1
execute if score #raycast.ux bs.data matches ..-1 run scoreboard players operation $raycast.targeted_block.x bs.lambda *= -1 bs.const
execute if score #raycast.uy bs.data matches ..-1 run scoreboard players operation $raycast.targeted_block.y bs.lambda *= -1 bs.const
execute if score #raycast.uz bs.data matches ..-1 run scoreboard players operation $raycast.targeted_block.z bs.lambda *= -1 bs.const
execute store result score #raycast.bx bs.data store result score #raycast.by bs.data run scoreboard players set #raycast.bz bs.data 10000000
scoreboard players operation #raycast.bx bs.data *= $raycast.targeted_block.x bs.lambda
scoreboard players operation #raycast.by bs.data *= $raycast.targeted_block.y bs.lambda
scoreboard players operation #raycast.bz bs.data *= $raycast.targeted_block.z bs.lambda
scoreboard players operation #raycast.bx bs.data += #raycast.rx bs.data
scoreboard players operation #raycast.by bs.data += #raycast.ry bs.data
scoreboard players operation #raycast.bz bs.data += #raycast.rz bs.data
scoreboard players operation $raycast.targeted_block.x bs.lambda += #raycast.x bs.data
scoreboard players operation $raycast.targeted_block.y bs.lambda += #raycast.y bs.data
scoreboard players operation $raycast.targeted_block.z bs.lambda += #raycast.z bs.data

scoreboard players operation $raycast.entry_point.x bs.lambda *= #raycast.ux bs.data
scoreboard players operation $raycast.entry_point.y bs.lambda *= #raycast.uy bs.data
scoreboard players operation $raycast.entry_point.z bs.lambda *= #raycast.uz bs.data
scoreboard players operation $raycast.exit_point.x bs.lambda *= #raycast.ux bs.data
scoreboard players operation $raycast.exit_point.y bs.lambda *= #raycast.uy bs.data
scoreboard players operation $raycast.exit_point.z bs.lambda *= #raycast.uz bs.data
scoreboard players operation $raycast.entry_point.x bs.lambda -= #raycast.bx bs.data
scoreboard players operation $raycast.entry_point.y bs.lambda -= #raycast.by bs.data
scoreboard players operation $raycast.entry_point.z bs.lambda -= #raycast.bz bs.data
scoreboard players operation $raycast.exit_point.x bs.lambda -= #raycast.bx bs.data
scoreboard players operation $raycast.exit_point.y bs.lambda -= #raycast.by bs.data
scoreboard players operation $raycast.exit_point.z bs.lambda -= #raycast.bz bs.data
scoreboard players operation $raycast.entry_point.x bs.lambda /= 10000 bs.const
scoreboard players operation $raycast.entry_point.y bs.lambda /= 10000 bs.const
scoreboard players operation $raycast.entry_point.z bs.lambda /= 10000 bs.const
scoreboard players operation $raycast.exit_point.x bs.lambda /= 10000 bs.const
scoreboard players operation $raycast.exit_point.y bs.lambda /= 10000 bs.const
scoreboard players operation $raycast.exit_point.z bs.lambda /= 10000 bs.const

execute if score #raycast.ux bs.data matches ..-1 run scoreboard players set $raycast.hit_face bs.lambda 5
execute if score #raycast.ux bs.data matches 0.. run scoreboard players set $raycast.hit_face bs.lambda 4
execute if score #raycast.tm bs.data = #raycast.lz bs.data if score #raycast.uz bs.data matches ..-1 run scoreboard players set $raycast.hit_face bs.lambda 3
execute if score #raycast.tm bs.data = #raycast.lz bs.data if score #raycast.uz bs.data matches 0.. run scoreboard players set $raycast.hit_face bs.lambda 2
execute if score #raycast.tm bs.data = #raycast.ly bs.data if score #raycast.uy bs.data matches ..-1 run scoreboard players set $raycast.hit_face bs.lambda 1
execute if score #raycast.tm bs.data = #raycast.ly bs.data if score #raycast.uy bs.data matches 0.. run scoreboard players set $raycast.hit_face bs.lambda 0

execute if data storage bs:data raycast.on_targeted_block run function bs.raycast:utils/on_targeted_block with storage bs:data raycast
execute if data storage bs:data raycast.on_entry_point positioned as @s run function bs.raycast:utils/at_entry_point with storage bs:data raycast
execute if data storage bs:data raycast.on_exit_point positioned as @s run function bs.raycast:utils/at_exit_point with storage bs:data raycast

execute if score $raycast.piercing bs.lambda matches 0 run return run scoreboard players set #raycast.dm bs.data -2147483648

execute store result score $raycast.prev_entry_distance bs.lambda run data get storage bs:data raycast.tmin
execute store result score $raycast.prev_exit_distance bs.lambda run data get storage bs:data raycast.tmax

scoreboard players operation #raycast.tm bs.data = #raycast.te bs.data
scoreboard players operation #raycast.pb bs.data = $raycast.piercing bs.lambda
execute unless data storage bs:data raycast.piercing{} run scoreboard players operation #raycast.pe bs.data = #raycast.pb bs.data

scoreboard players operation #raycast.lx bs.data += #raycast.dx bs.data
scoreboard players operation #raycast.ly bs.data += #raycast.dy bs.data
scoreboard players operation #raycast.lz bs.data += #raycast.dz bs.data

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

execute store result score #n bs.ctx run data get storage bs:data raycast.rb[-1].norm
execute if score #n bs.ctx matches 1 if score #raycast.ux bs.data matches ..-1 run scoreboard players set $raycast.hit_face bs.lambda 5
execute if score #n bs.ctx matches 1 if score #raycast.ux bs.data matches 0.. run scoreboard players set $raycast.hit_face bs.lambda 4
execute if score #n bs.ctx matches 2 if score #raycast.uz bs.data matches ..-1 run scoreboard players set $raycast.hit_face bs.lambda 3
execute if score #n bs.ctx matches 2 if score #raycast.uz bs.data matches 0.. run scoreboard players set $raycast.hit_face bs.lambda 2
execute if score #n bs.ctx matches 3 if score #raycast.uy bs.data matches ..-1 run scoreboard players set $raycast.hit_face bs.lambda 1
execute if score #n bs.ctx matches 3 if score #raycast.uy bs.data matches 0.. run scoreboard players set $raycast.hit_face bs.lambda 0

execute store result storage bs:data raycast.tmin double .001 \
  store result score $raycast.entry_point.x bs.lambda \
  store result score $raycast.entry_point.y bs.lambda \
  store result score $raycast.entry_point.z bs.lambda \
  run scoreboard players operation $raycast.entry_distance bs.lambda = #raycast.tm bs.data

execute store result storage bs:data raycast.tmax double .001 \
  store result score $raycast.exit_point.x bs.lambda \
  store result score $raycast.exit_point.y bs.lambda \
  store result score $raycast.exit_point.z bs.lambda \
  store result score $raycast.exit_distance bs.lambda run data get storage bs:data raycast.rb[-1].tmax

execute if data storage bs:lambda hitbox run return run function bs.raycast:react/cell

scoreboard players operation $raycast.piercing bs.lambda = #raycast.pb bs.data

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

execute store result score $raycast.hit_flag bs.lambda run data get storage bs:data raycast.rb[-1].flag
execute if data storage bs:data raycast.on_entry_point positioned as @s run function bs.raycast:utils/at_entry_point with storage bs:data raycast
execute if data storage bs:data raycast.on_exit_point positioned as @s run function bs.raycast:utils/at_exit_point with storage bs:data raycast

scoreboard players operation #raycast.pb bs.data = $raycast.piercing bs.lambda
execute unless data storage bs:data raycast.piercing{} run scoreboard players operation #raycast.pe bs.data = #raycast.pb bs.data

data remove storage bs:data raycast.rb[-1]
execute unless data storage bs:data raycast.rb[-1] run return run scoreboard players set #raycast.tb bs.data 2147483647
execute store result score #raycast.tb bs.data run data get storage bs:data raycast.rb[-1].tmin

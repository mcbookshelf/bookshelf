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

data remove storage bs:lambda hitbox
execute if score #raycast.pb bs.data matches 0.. run scoreboard players remove #raycast.pb bs.data 1
scoreboard players operation $raycast.piercing bs.lambda = #raycast.pb bs.data

scoreboard players set $raycast.hit_flag bs.lambda 0
execute if data storage bs:data raycast.rb[{flag:1}] run scoreboard players add $raycast.hit_flag bs.lambda 1
execute if data storage bs:data raycast.rb[{flag:2}] run scoreboard players add $raycast.hit_flag bs.lambda 2
execute if data storage bs:data raycast.rb[{flag:4}] run scoreboard players add $raycast.hit_flag bs.lambda 4
execute if data storage bs:data raycast.rb[{flag:8}] run scoreboard players add $raycast.hit_flag bs.lambda 8
execute unless data storage bs:data raycast.on_entry_point unless data storage bs:data raycast.on_exit_point run data remove storage bs:data raycast.rb

scoreboard players operation $raycast.targeted_block.x bs.lambda = #raycast.lx bs.data
scoreboard players operation $raycast.targeted_block.x bs.lambda /= #raycast.dx bs.data
scoreboard players operation $raycast.targeted_block.y bs.lambda = #raycast.ly bs.data
scoreboard players operation $raycast.targeted_block.y bs.lambda /= #raycast.dy bs.data
scoreboard players operation $raycast.targeted_block.z bs.lambda = #raycast.lz bs.data
scoreboard players operation $raycast.targeted_block.z bs.lambda /= #raycast.dz bs.data
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

execute if data storage bs:data raycast.on_targeted_block run function bs.raycast:utils/on_targeted_block with storage bs:data raycast
execute store result score $raycast.hit_flag bs.lambda run data get storage bs:data raycast.rb[-1].flag
execute if data storage bs:data raycast.on_entry_point positioned as @s run function bs.raycast:utils/at_entry_point with storage bs:data raycast
execute if data storage bs:data raycast.on_exit_point positioned as @s run function bs.raycast:utils/at_exit_point with storage bs:data raycast

scoreboard players operation #raycast.pb bs.data = $raycast.piercing bs.lambda
execute unless data storage bs:data raycast.piercing{} run scoreboard players operation #raycast.pe bs.data = #raycast.pb bs.data

data remove storage bs:data raycast.rb[-1]
execute unless data storage bs:data raycast.rb[-1] run return run scoreboard players set #raycast.tb bs.data 2147483647
execute store result score #raycast.tb bs.data run data get storage bs:data raycast.rb[-1].tmin

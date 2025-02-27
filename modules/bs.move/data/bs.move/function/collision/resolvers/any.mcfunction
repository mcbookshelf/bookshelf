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

data merge storage bs:ctx {x:0d,y:0d,z:0d}
scoreboard players remove #move.ctime bs.data 10000
scoreboard players operation #move.ctime bs.data *= -1 bs.const
execute store result score $move.vel.x bs.lambda run scoreboard players operation #move.vx bs.data *= #move.ctime bs.data
execute store result score $move.vel.y bs.lambda run scoreboard players operation #move.vy bs.data *= #move.ctime bs.data
execute store result score $move.vel.z bs.lambda run scoreboard players operation #move.vz bs.data *= #move.ctime bs.data
execute if score #move.vx bs.data matches 1.. store result storage bs:ctx x double -.0000001 run scoreboard players add #move.vx bs.data 20000
execute if score #move.vy bs.data matches 1.. store result storage bs:ctx y double -.0000001 run scoreboard players add #move.vy bs.data 20000
execute if score #move.vz bs.data matches 1.. store result storage bs:ctx z double -.0000001 run scoreboard players add #move.vz bs.data 20000
execute if score #move.vx bs.data matches ..-1 store result storage bs:ctx x double -.0000001 run scoreboard players remove #move.vx bs.data 10000
execute if score #move.vy bs.data matches ..-1 store result storage bs:ctx y double -.0000001 run scoreboard players remove #move.vy bs.data 10000
execute if score #move.vz bs.data matches ..-1 store result storage bs:ctx z double -.0000001 run scoreboard players remove #move.vz bs.data 10000
execute at @s run function bs.move:collision/utils/tp_relative with storage bs:ctx
$function bs.move:collision/resolvers/$(resolver) with storage bs:data move

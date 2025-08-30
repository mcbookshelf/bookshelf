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

data modify storage bs:ctx _ set from entity @s Pos
execute store result score #raycast.x bs.data store result storage bs:data raycast.x int -1 run data get storage bs:ctx _[0]
execute store result score #raycast.y bs.data store result storage bs:data raycast.y int -1 run data get storage bs:ctx _[1]
execute store result score #raycast.z bs.data store result storage bs:data raycast.z int -1 run data get storage bs:ctx _[2]

# get the unit vector [ux,uy,uz]
execute positioned 0.0 0.0 0.0 run tp @s ^ ^ ^10
data modify storage bs:ctx _ set from entity @s Pos
execute store result score #raycast.ux bs.data run data get storage bs:ctx _[0] 1000
execute store result score #raycast.uy bs.data run data get storage bs:ctx _[1] 1000
execute store result score #raycast.uz bs.data run data get storage bs:ctx _[2] 1000

# compute the delta [dx,dy,dz] (distance to advance to the next grid intersection)
execute store result score #raycast.dx bs.data store result score #raycast.dy bs.data run scoreboard players set #raycast.dz bs.data 10000000
execute if score #raycast.ux bs.data matches ..-1 store result storage bs:data raycast.sx int .0000001 run scoreboard players set #raycast.dx bs.data -10000000
execute if score #raycast.uy bs.data matches ..-1 store result storage bs:data raycast.sy int .0000001 run scoreboard players set #raycast.dy bs.data -10000000
execute if score #raycast.uz bs.data matches ..-1 store result storage bs:data raycast.sz int .0000001 run scoreboard players set #raycast.dz bs.data -10000000
scoreboard players operation #raycast.dx bs.data /= #raycast.ux bs.data
scoreboard players operation #raycast.dy bs.data /= #raycast.uy bs.data
scoreboard players operation #raycast.dz bs.data /= #raycast.uz bs.data

# compute the length [lx,ly,lz] (distance from the origin to the next grid intersection)
function bs.raycast:utils/get_relative_pos with storage bs:data raycast
execute store result score #raycast.rx bs.data store result score #raycast.lx bs.data run data get storage bs:ctx _[0] -10000000
execute store result score #raycast.ry bs.data store result score #raycast.ly bs.data run data get storage bs:ctx _[1] -10000000
execute store result score #raycast.rz bs.data store result score #raycast.lz bs.data run data get storage bs:ctx _[2] -10000000
execute if score #raycast.ux bs.data matches 0.. run scoreboard players add #raycast.lx bs.data 10000000
execute if score #raycast.uy bs.data matches 0.. run scoreboard players add #raycast.ly bs.data 10000000
execute if score #raycast.uz bs.data matches 0.. run scoreboard players add #raycast.lz bs.data 10000000
scoreboard players operation #raycast.lx bs.data /= #raycast.ux bs.data
scoreboard players operation #raycast.ly bs.data /= #raycast.uy bs.data
scoreboard players operation #raycast.lz bs.data /= #raycast.uz bs.data

# run the recursion loop
scoreboard players set @s bs.tmin 2147483647
# @deprecated hitbox_shape (update following lines in in 4.0.0)
execute if data storage bs:data raycast{blocks:1b} run data modify storage bs:data raycast.blocks set from storage bs:data raycast.hitbox_shape
execute if data storage bs:data raycast{blocks:1b} run data modify storage bs:data raycast.blocks set value "interaction"
execute if data storage bs:data raycast{blocks:"collision"} run data modify storage bs:data raycast.blocks set value "function #bs.hitbox:get_block_collision"
execute if data storage bs:data raycast{blocks:"interaction"} run data modify storage bs:data raycast.blocks set value "function #bs.hitbox:get_block_shape"
execute if data storage bs:data raycast{entities:1b} run data modify storage bs:data raycast.entities set value "!bs.raycast.omit"
execute unless data storage bs:data raycast{entities:0b} run function bs.raycast:check/entities with storage bs:data raycast
execute align xyz run function bs.raycast:recurse/next with storage bs:data raycast
tp @s ~ -100000 ~
kill @s

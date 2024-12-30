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

# get starting position and velocity vector
data modify storage bs:ctx _ set from entity @s Pos
execute store result score #move.y bs.data run data get storage bs:ctx _[1] 10000
execute store result storage bs:data move.x int -1 run data get storage bs:ctx _[0]
execute store result storage bs:data move.y int -1 run data get storage bs:ctx _[1]
execute store result storage bs:data move.z int -1 run data get storage bs:ctx _[2]
execute summon minecraft:marker run function bs.move:collision/utils/get_relative_pos with storage bs:data move
execute store result score #move.vx bs.data store result score #move.rx bs.data store result score #move.sx bs.data run data get storage bs:ctx _[0] -10000000
execute store result score #move.vy bs.data store result score #move.ry bs.data store result score #move.sy bs.data run data get storage bs:ctx _[1] -10000000
execute store result score #move.vz bs.data store result score #move.rz bs.data store result score #move.sz bs.data run data get storage bs:ctx _[2] -10000000
execute in minecraft:overworld positioned as @s as B5-0-0-0-1 run function bs.move:collision/utils/get_relative_entity_pos with storage bs:data move
execute store result score #move.nx bs.data run data get storage bs:ctx _[0] -10000000
execute store result score #move.ny bs.data run data get storage bs:ctx _[1] -10000000
execute store result score #move.nz bs.data run data get storage bs:ctx _[2] -10000000
execute store result score #move.nx bs.data run scoreboard players operation #move.vx bs.data -= #move.nx bs.data
execute store result score #move.ny bs.data run scoreboard players operation #move.vy bs.data -= #move.ny bs.data
execute store result score #move.nz bs.data run scoreboard players operation #move.vz bs.data -= #move.nz bs.data
scoreboard players operation #move.rx bs.data %= -10000000 bs.const
scoreboard players operation #move.ry bs.data %= -10000000 bs.const
scoreboard players operation #move.rz bs.data %= -10000000 bs.const
scoreboard players operation #move.vx bs.data /= 10000 bs.const
scoreboard players operation #move.vy bs.data /= 10000 bs.const
scoreboard players operation #move.vz bs.data /= 10000 bs.const

# compute a bounding box that encompasses all passengers
tag @e[tag=bs.move.omit] remove bs.move.omit
scoreboard players set #move.h bs.data 0
scoreboard players set #move.w bs.data 0
function bs.move:collision/utils/get_bounding_box

# check for collisions and resolve them
scoreboard players set #move.ctime bs.data 10000
data modify storage bs:data move merge value {sx:"xp",sy:"yp",sz:"zp"}
execute if score #move.vx bs.data matches ..-1 run data modify storage bs:data move.sx set value "xn"
execute if score #move.vy bs.data matches ..-1 run data modify storage bs:data move.sy set value "yn"
execute if score #move.vz bs.data matches ..-1 run data modify storage bs:data move.sz set value "zn"
execute store result score #move.b bs.data unless data storage bs:data move{blocks:0b}
execute store result score #move.e bs.data unless data storage bs:data move{entities:0b}
execute if score #move.e bs.data matches 1 if data storage bs:data move{entities:1b} run data modify storage bs:data move.entities set value "!bs.move.omit"
execute run function bs.move:collision/recurse/setup/init with storage bs:data move
execute if score #move.ctime bs.data matches ..-1 run scoreboard players set #move.ctime bs.data 0
$execute if score #move.ctime bs.data matches 0..9999 run function bs.move:collision/resolvers/any {resolver:$(resolver)}

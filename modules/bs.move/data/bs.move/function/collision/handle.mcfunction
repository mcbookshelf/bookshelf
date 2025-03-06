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

# get starting position and velocity vector
data modify storage bs:ctx _ set from entity @s Pos
execute store result score #move.y bs.data run data get storage bs:ctx _[1] 10000
execute store result storage bs:data move.x int -1 run data get storage bs:ctx _[0]
execute store result storage bs:data move.y int -1 run data get storage bs:ctx _[1]
execute store result storage bs:data move.z int -1 run data get storage bs:ctx _[2]
execute summon minecraft:marker run function bs.move:collision/utils/get_relative_pos with storage bs:data move
execute store result score #move.sx bs.data store result score #move.rx bs.data run data get storage bs:ctx _[0] 10000000
execute store result score #move.sy bs.data store result score #move.ry bs.data run data get storage bs:ctx _[1] 10000000
execute store result score #move.sz bs.data store result score #move.rz bs.data run data get storage bs:ctx _[2] 10000000
execute in minecraft:overworld positioned as @s as B5-0-0-0-1 run function bs.move:collision/utils/get_relative_entity_pos with storage bs:data move
execute store result score #move.mx bs.data store result score #move.vx bs.data run data get storage bs:ctx _[0] -10000000
execute store result score #move.my bs.data store result score #move.vy bs.data run data get storage bs:ctx _[1] -10000000
execute store result score #move.mz bs.data store result score #move.vz bs.data run data get storage bs:ctx _[2] -10000000
scoreboard players operation #move.vx bs.data += #move.rx bs.data
scoreboard players operation #move.vy bs.data += #move.ry bs.data
scoreboard players operation #move.vz bs.data += #move.rz bs.data
scoreboard players operation #move.vx bs.data /= -10000 bs.const
scoreboard players operation #move.vy bs.data /= -10000 bs.const
scoreboard players operation #move.vz bs.data /= -10000 bs.const

# compute a bounding box that encompasses all passengers
tag @e[tag=bs.move.omit] remove bs.move.omit
scoreboard players set #move.h bs.data 0
scoreboard players set #move.w bs.data 0
function bs.move:collision/utils/get_bounding_box

# check for collisions and resolve them
scoreboard players set #move.ctime bs.data 10000
data modify storage bs:data move merge value {dx:"xp",dy:"yp",dz:"zp",rx:0d,ry:0d,rz:0d}
execute if score #move.vx bs.data matches ..-1 run data modify storage bs:data move.dx set value "xn"
execute if score #move.vy bs.data matches ..-1 run data modify storage bs:data move.dy set value "yn"
execute if score #move.vz bs.data matches ..-1 run data modify storage bs:data move.dz set value "zn"
execute store result score #move.b bs.data unless data storage bs:data move{blocks:0b}
execute store result score #move.e bs.data unless data storage bs:data move{entities:0b}
execute if data storage bs:data move{entities:1b} run data modify storage bs:data move.entities set value "!bs.move.omit"
execute align xyz run function bs.move:collision/recurse/setup/init with storage bs:data move
$execute if score #move.ctime bs.data matches 0..9999 run function bs.move:collision/resolvers/any {resolver:$(resolver)}

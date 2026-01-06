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

# get starting position and velocity vector
scoreboard players add #move.it bs.data 1
execute summon minecraft:marker run function bs.move:collision/utils/get_starting_pos
execute store result score #move.rx bs.data run data get storage bs:ctx _[0] 10000000
execute store result score #move.ry bs.data run data get storage bs:ctx _[1] 10000000
execute store result score #move.rz bs.data run data get storage bs:ctx _[2] 10000000
execute in minecraft:overworld positioned as @s as B5-0-0-0-1 run function bs.move:collision/utils/get_entity_pos with storage bs:data move
execute store result score #move.nx bs.data store result score #move.vx bs.data run data get storage bs:ctx _[0] 10000000
execute store result score #move.ny bs.data store result score #move.vy bs.data run data get storage bs:ctx _[1] 10000000
execute store result score #move.nz bs.data store result score #move.vz bs.data run data get storage bs:ctx _[2] 10000000
scoreboard players operation #move.vx bs.data -= #move.rx bs.data
scoreboard players operation #move.vy bs.data -= #move.ry bs.data
scoreboard players operation #move.vz bs.data -= #move.rz bs.data

# compute entity bounding box and volume to check for collisions
function bs.move:collision/utils/get_bounding_box
execute if score #move.vx bs.data matches 0.. run function bs.move:collision/utils/setup_xp
execute if score #move.vy bs.data matches 0.. run function bs.move:collision/utils/setup_yp
execute if score #move.vz bs.data matches 0.. run function bs.move:collision/utils/setup_zp
execute if score #move.vx bs.data matches ..-1 run function bs.move:collision/utils/setup_xn
execute if score #move.vy bs.data matches ..-1 run function bs.move:collision/utils/setup_yn
execute if score #move.vz bs.data matches ..-1 run function bs.move:collision/utils/setup_zn

# run collision detection and run resolver function if needed
scoreboard players set #move.toi bs.data 10000
execute store success score #move.flag.1 bs.data if entity @s[tag=bs.move.flag.1]
execute store success score #move.flag.2 bs.data if entity @s[tag=bs.move.flag.2]
execute store success score #move.flag.4 bs.data if entity @s[tag=bs.move.flag.4]
execute store success score #move.flag.8 bs.data if entity @s[tag=bs.move.flag.8]
tag @s remove bs.move.flag.1
tag @s remove bs.move.flag.2
tag @s remove bs.move.flag.4
tag @s remove bs.move.flag.8
# @deprecated hitbox_shape (update following lines in in 4.0.0)
function bs.move:collision/utils/setup_tags
execute if data storage bs:data move{blocks:1b} run data modify storage bs:data move.blocks set from storage bs:data move.hitbox_shape
execute if data storage bs:data move{blocks:1b} run data modify storage bs:data move.blocks set value "collision"
execute if data storage bs:data move{blocks:"collision"} run data modify storage bs:data move.blocks set value "function #bs.hitbox:callback/get_block_collision"
execute if data storage bs:data move{blocks:"interaction"} run data modify storage bs:data move.blocks set value "function #bs.hitbox:callback/get_block_shape"
execute if data storage bs:data move{entities:1b} run data modify storage bs:data move.entities set value "!bs.move.omit"
function bs.move:collision/check/init with storage bs:data move
function bs.move:collision/utils/reset_tags
$execute if score #move.toi bs.data matches 0..9999 run function bs.move:collision/resolve/$(resolver) with storage bs:data move

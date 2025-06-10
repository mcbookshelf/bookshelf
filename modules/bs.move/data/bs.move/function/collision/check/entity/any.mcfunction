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

execute if entity @s[scores={bs.width=0..,bs.height=0..,bs.depth=0..}] run return run function bs.move:collision/check/entity/custom

# get the entity's base hitbox dimensions
function #bs.hitbox:get_entity
execute store result score #w bs.ctx run data get storage bs:out hitbox.width 5000
execute store result score #d bs.ctx run data get storage bs:out hitbox.depth 5000
execute store result score #h bs.ctx run data get storage bs:out hitbox.height 5000
execute unless score #w bs.ctx matches 1.. unless score #h bs.ctx matches 1.. unless score #d bs.ctx matches 1.. run return 0
execute store result score #s bs.ctx run data get storage bs:out hitbox.scale 1000
scoreboard players operation #w bs.ctx *= #s bs.ctx
scoreboard players operation #h bs.ctx *= #s bs.ctx
scoreboard players operation #d bs.ctx *= #s bs.ctx

# get the entity’s relative position to the moving object
execute in minecraft:overworld positioned as @s as B5-0-0-0-1 run function bs.move:collision/utils/get_entity_pos with storage bs:data move
execute store result score #x bs.ctx run data get storage bs:ctx _[0] 10000000
execute store result score #y bs.ctx run data get storage bs:ctx _[1] 10000000
execute store result score #z bs.ctx run data get storage bs:ctx _[2] 10000000
execute store result score #i bs.ctx run scoreboard players operation #x bs.ctx -= #move.sx bs.data
execute store result score #j bs.ctx run scoreboard players operation #y bs.ctx -= #move.sy bs.data
execute store result score #k bs.ctx run scoreboard players operation #z bs.ctx -= #move.sz bs.data

# compute the bounding box min and max corners
scoreboard players operation #x bs.ctx -= #w bs.ctx
execute if entity @s[type=#bs.hitbox:is_shaped] run scoreboard players operation #y bs.ctx -= #h bs.ctx
scoreboard players operation #z bs.ctx -= #d bs.ctx
scoreboard players operation #i bs.ctx += #w bs.ctx
execute if score #y bs.ctx = #j bs.ctx run scoreboard players operation #j bs.ctx += #h bs.ctx
scoreboard players operation #j bs.ctx += #h bs.ctx
scoreboard players operation #k bs.ctx += #d bs.ctx

# perform AABB collision check
function bs.move:collision/check/aabb

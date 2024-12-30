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

tag @s add bs.move.omit

# get the entity relative coordinates
execute in minecraft:overworld positioned as @s as B5-0-0-0-1 run function bs.move:collision/utils/get_relative_entity_pos with storage bs:data move
execute store result score #x bs.ctx run data get storage bs:ctx _[0] 10000000
execute store result score #y bs.ctx run data get storage bs:ctx _[1] 10000000
execute store result score #z bs.ctx run data get storage bs:ctx _[2] 10000000
execute store result score #i bs.ctx run scoreboard players operation #x bs.ctx += #move.sx bs.data
execute store result score #j bs.ctx run scoreboard players operation #y bs.ctx += #move.sy bs.data
execute store result score #k bs.ctx run scoreboard players operation #z bs.ctx += #move.sz bs.data

# compute the hitbox using the sizes of the collided entity and the moving entity
execute store result score #h bs.ctx run data get storage bs:out hitbox.height 10000
execute store result score #w bs.ctx run data get storage bs:out hitbox.width 5000
execute store result score #s bs.ctx run data get storage bs:out hitbox.scale 1000
scoreboard players operation #h bs.ctx *= #s bs.ctx
scoreboard players operation #w bs.ctx *= #s bs.ctx
scoreboard players operation #w bs.ctx += #move.w bs.data
scoreboard players operation #x bs.ctx -= #w bs.ctx
scoreboard players operation #y bs.ctx -= #move.h bs.data
scoreboard players operation #z bs.ctx -= #w bs.ctx
scoreboard players operation #i bs.ctx += #w bs.ctx
scoreboard players operation #j bs.ctx += #h bs.ctx
scoreboard players operation #k bs.ctx += #w bs.ctx

# when step is negative, points are negative so we get the absolute value
scoreboard players operation #x bs.ctx /= #move.vx bs.data
scoreboard players operation #i bs.ctx /= #move.vx bs.data
scoreboard players operation #y bs.ctx /= #move.vy bs.data
scoreboard players operation #j bs.ctx /= #move.vy bs.data
scoreboard players operation #z bs.ctx /= #move.vz bs.data
scoreboard players operation #k bs.ctx /= #move.vz bs.data

# when step is negative we need to reverse near and far points
execute if score #move.vx bs.data matches ..-1 run scoreboard players operation #x bs.ctx >< #i bs.ctx
execute if score #move.vy bs.data matches ..-1 run scoreboard players operation #y bs.ctx >< #j bs.ctx
execute if score #move.vz bs.data matches ..-1 run scoreboard players operation #z bs.ctx >< #k bs.ctx

# compute near and far points for AABB collision
scoreboard players operation #x bs.ctx > #y bs.ctx
scoreboard players operation #x bs.ctx > #z bs.ctx
scoreboard players operation #i bs.ctx < #j bs.ctx
scoreboard players operation #i bs.ctx < #k bs.ctx

# if min_x <= max_x, ray is intersecting with AABB, if max_x < 0, ray is intersecting AABB, but the whole AABB is behind
execute if score #i bs.ctx matches 0.. \
  if score #x bs.ctx <= #i bs.ctx \
  if score #move.ctime bs.data > #x bs.ctx \
  run function bs.move:collision/collide

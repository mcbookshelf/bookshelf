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

# get cube hitbox coordinates
execute store result score #i bs.ctx run scoreboard players operation #x bs.ctx = #move.x bs.data
execute store result score #j bs.ctx run scoreboard players operation #y bs.ctx = #move.y bs.data
execute store result score #k bs.ctx run scoreboard players operation #z bs.ctx = #move.z bs.data
scoreboard players add #i bs.ctx 10000000
scoreboard players add #j bs.ctx 10000000
scoreboard players add #k bs.ctx 10000000

# add the moving entity size to the hitbox
scoreboard players operation #x bs.ctx -= #move.w bs.data
scoreboard players operation #y bs.ctx -= #move.h bs.data
scoreboard players operation #z bs.ctx -= #move.w bs.data
scoreboard players operation #i bs.ctx += #move.w bs.data
scoreboard players operation #k bs.ctx += #move.w bs.data

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

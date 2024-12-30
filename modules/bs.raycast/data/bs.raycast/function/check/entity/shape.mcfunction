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

# get hitbox coordinates
execute store result score #x bs.ctx run data get storage bs:out hitbox.shape[-1][0] 625000
execute store result score #y bs.ctx run data get storage bs:out hitbox.shape[-1][1] 625000
execute store result score #z bs.ctx run data get storage bs:out hitbox.shape[-1][2] 625000
execute store result score #i bs.ctx run data get storage bs:out hitbox.shape[-1][3] 625000
execute store result score #j bs.ctx run data get storage bs:out hitbox.shape[-1][4] 625000
execute store result score #k bs.ctx run data get storage bs:out hitbox.shape[-1][5] 625000
data remove storage bs:out hitbox.shape[-1]

# when step is negative, ray is one step further and hitbox coordinates should be negative
scoreboard players operation #x bs.ctx /= #raycast.ux bs.data
scoreboard players operation #i bs.ctx /= #raycast.ux bs.data
scoreboard players operation #y bs.ctx /= #raycast.uy bs.data
scoreboard players operation #j bs.ctx /= #raycast.uy bs.data
scoreboard players operation #z bs.ctx /= #raycast.uz bs.data
scoreboard players operation #k bs.ctx /= #raycast.uz bs.data

# when step is negative we need to reverse near and far points
execute if score #raycast.ux bs.data matches ..-1 run scoreboard players operation #x bs.ctx >< #i bs.ctx
execute if score #raycast.uy bs.data matches ..-1 run scoreboard players operation #y bs.ctx >< #j bs.ctx
execute if score #raycast.uz bs.data matches ..-1 run scoreboard players operation #z bs.ctx >< #k bs.ctx

# compute near and far points for AABB collision
execute store result score #raycast.tmin bs.data run scoreboard players operation #x bs.ctx += #raycast.lx bs.data
execute store result score #raycast.tmax bs.data run scoreboard players operation #i bs.ctx += #raycast.lx bs.data
scoreboard players operation #y bs.ctx += #raycast.ly bs.data
scoreboard players operation #j bs.ctx += #raycast.ly bs.data
scoreboard players operation #z bs.ctx += #raycast.lz bs.data
scoreboard players operation #k bs.ctx += #raycast.lz bs.data
scoreboard players operation #raycast.tmin bs.data > #y bs.ctx
scoreboard players operation #raycast.tmin bs.data > #z bs.ctx
scoreboard players operation #raycast.tmax bs.data < #j bs.ctx
scoreboard players operation #raycast.tmax bs.data < #k bs.ctx

# if tmin <= tmax, ray is intersecting with AABB, if tmax < 0, ray is intersecting AABB, but the whole AABB is behind
execute if score #raycast.tmax bs.data matches 0.. \
  if score #raycast.tmin bs.data <= #raycast.tmax bs.data \
  if score #raycast.tmin bs.data < #raycast.distance bs.data \
  if score #raycast.tmin bs.data <= #raycast.max_distance bs.data \
  run function bs.raycast:collide/shape

execute if data storage bs:out hitbox.shape[-1] run function bs.raycast:check/entity/shape

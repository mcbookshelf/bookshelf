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

# get position relative to ray origin
execute in minecraft:overworld positioned as @s as B5-0-0-0-1 run function bs.raycast:utils/get_entity_pos with storage bs:data raycast
execute store result score #x bs.ctx run data get storage bs:ctx _[0] 10000000
execute store result score #y bs.ctx run data get storage bs:ctx _[1] 10000000
execute store result score #z bs.ctx run data get storage bs:ctx _[2] 10000000
execute store result score #i bs.ctx run scoreboard players operation #x bs.ctx += #raycast.rx bs.data
execute store result score #j bs.ctx run scoreboard players operation #y bs.ctx += #raycast.ry bs.data
execute store result score #k bs.ctx run scoreboard players operation #z bs.ctx += #raycast.rz bs.data

# apply hitbox dimensions to get AABB corners
scoreboard players operation #x bs.ctx -= #w bs.ctx
scoreboard players operation #y bs.ctx -= #h bs.ctx
scoreboard players operation #z bs.ctx -= #d bs.ctx
scoreboard players operation #i bs.ctx += #w bs.ctx
scoreboard players operation #j bs.ctx += #h bs.ctx
scoreboard players operation #k bs.ctx += #d bs.ctx

# normalize coordinates (always absolute)
scoreboard players operation #x bs.ctx /= #raycast.ux bs.data
scoreboard players operation #i bs.ctx /= #raycast.ux bs.data
scoreboard players operation #y bs.ctx /= #raycast.uy bs.data
scoreboard players operation #j bs.ctx /= #raycast.uy bs.data
scoreboard players operation #z bs.ctx /= #raycast.uz bs.data
scoreboard players operation #k bs.ctx /= #raycast.uz bs.data

# swap near/far values if ray step is negative
execute if score #raycast.ux bs.data matches ..-1 run scoreboard players operation #x bs.ctx >< #i bs.ctx
execute if score #raycast.uy bs.data matches ..-1 run scoreboard players operation #y bs.ctx >< #j bs.ctx
execute if score #raycast.uz bs.data matches ..-1 run scoreboard players operation #z bs.ctx >< #k bs.ctx

# compute near and far intersection points
scoreboard players operation #x bs.ctx > #y bs.ctx
scoreboard players operation #x bs.ctx > #z bs.ctx
scoreboard players operation #i bs.ctx < #j bs.ctx
scoreboard players operation #i bs.ctx < #k bs.ctx

# check for valid intersection: near ≤ far and within ray bounds
execute if score #i bs.ctx matches 0.. \
  if score #x bs.ctx <= #i bs.ctx \
  if score #x bs.ctx <= #raycast.max_distance bs.data \
  run return run function bs.raycast:collide/record/size

scoreboard players set @s bs.tmin 2147483647

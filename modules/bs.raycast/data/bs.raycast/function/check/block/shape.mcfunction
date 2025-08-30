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

# get hitbox coordinates
execute store result score #x bs.ctx run data get storage bs:ctx _[-1][0] 625000
execute store result score #y bs.ctx run data get storage bs:ctx _[-1][1] 625000
execute store result score #z bs.ctx run data get storage bs:ctx _[-1][2] 625000
execute store result score #i bs.ctx run data get storage bs:ctx _[-1][3] 625000
execute store result score #j bs.ctx run data get storage bs:ctx _[-1][4] 625000
execute store result score #k bs.ctx run data get storage bs:ctx _[-1][5] 625000
data remove storage bs:ctx _[-1]

# offset coordinates if needed
scoreboard players operation #x bs.ctx += #p bs.ctx
scoreboard players operation #z bs.ctx += #q bs.ctx
scoreboard players operation #i bs.ctx += #p bs.ctx
scoreboard players operation #k bs.ctx += #q bs.ctx

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
scoreboard players operation #x bs.ctx += #raycast.lx bs.data
scoreboard players operation #i bs.ctx += #raycast.lx bs.data
scoreboard players operation #y bs.ctx += #raycast.ly bs.data
scoreboard players operation #j bs.ctx += #raycast.ly bs.data
scoreboard players operation #z bs.ctx += #raycast.lz bs.data
scoreboard players operation #k bs.ctx += #raycast.lz bs.data
scoreboard players operation #x bs.ctx > #y bs.ctx
scoreboard players operation #x bs.ctx > #z bs.ctx
scoreboard players operation #i bs.ctx < #j bs.ctx
scoreboard players operation #i bs.ctx < #k bs.ctx

# check for valid intersection: near ≤ far and within ray bounds
execute if score #i bs.ctx matches 0.. \
  if score #x bs.ctx <= #i bs.ctx \
  if score #x bs.ctx < #raycast.btmin bs.data \
  if score #x bs.ctx <= #raycast.max_distance bs.data \
  run function bs.raycast:collide/record/shape

execute if data storage bs:ctx _[-1] run function bs.raycast:check/block/shape

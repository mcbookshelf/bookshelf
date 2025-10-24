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

# add the moving entity size to the hitbox
scoreboard players operation #x bs.ctx -= #move.w bs.data
scoreboard players operation #y bs.ctx -= #move.h bs.data
scoreboard players operation #z bs.ctx -= #move.d bs.data

execute if score #move.vx bs.data matches 0 if score #x bs.ctx matches 0.. run return 0
execute if score #move.vx bs.data matches 0 if score #i bs.ctx matches ..0 run return 0
execute if score #move.vy bs.data matches 0 if score #y bs.ctx matches 0.. run return 0
execute if score #move.vy bs.data matches 0 if score #j bs.ctx matches ..0 run return 0
execute if score #move.vz bs.data matches 0 if score #z bs.ctx matches 0.. run return 0
execute if score #move.vz bs.data matches 0 if score #k bs.ctx matches ..0 run return 0

# compute near and far values
scoreboard players operation #x bs.ctx /= #move.vx bs.data
scoreboard players operation #i bs.ctx /= #move.vx bs.data
scoreboard players operation #y bs.ctx /= #move.vy bs.data
scoreboard players operation #j bs.ctx /= #move.vy bs.data
scoreboard players operation #z bs.ctx /= #move.vz bs.data
scoreboard players operation #k bs.ctx /= #move.vz bs.data

# swap near/far values if ray step is negative
execute if score #move.vx bs.data matches ..-1 run scoreboard players operation #x bs.ctx >< #i bs.ctx
execute if score #move.vy bs.data matches ..-1 run scoreboard players operation #y bs.ctx >< #j bs.ctx
execute if score #move.vz bs.data matches ..-1 run scoreboard players operation #z bs.ctx >< #k bs.ctx

# compute near and far intersection points
scoreboard players operation #x bs.ctx > #y bs.ctx
scoreboard players operation #x bs.ctx > #z bs.ctx
scoreboard players operation #i bs.ctx < #j bs.ctx
scoreboard players operation #i bs.ctx < #k bs.ctx

# check for valid intersection: near ≤ far and within ray bounds
execute if score #i bs.ctx matches 0.. \
  if score #x bs.ctx <= #i bs.ctx \
  if score #move.toi bs.data > #x bs.ctx \
  run function bs.move:collision/collide

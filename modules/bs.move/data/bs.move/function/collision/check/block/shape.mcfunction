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

# get next AABB from block shape stack
execute store result score #x bs.ctx run data get storage bs:ctx _[-1][0] 625000
execute store result score #y bs.ctx run data get storage bs:ctx _[-1][1] 625000
execute store result score #z bs.ctx run data get storage bs:ctx _[-1][2] 625000
execute store result score #i bs.ctx run data get storage bs:ctx _[-1][3] 625000
execute store result score #j bs.ctx run data get storage bs:ctx _[-1][4] 625000
execute store result score #k bs.ctx run data get storage bs:ctx _[-1][5] 625000
data remove storage bs:ctx _[-1]

# offset hitbox coordinates by relative position
scoreboard players operation #x bs.ctx += #p bs.ctx
scoreboard players operation #y bs.ctx += #move.y bs.data
scoreboard players operation #z bs.ctx += #q bs.ctx
scoreboard players operation #i bs.ctx += #p bs.ctx
scoreboard players operation #j bs.ctx += #move.y bs.data
scoreboard players operation #k bs.ctx += #q bs.ctx

# perform AABB collision check
function bs.move:collision/check/aabb

# continue checking remaining AABBs in the shape if any
execute if data storage bs:ctx _[0] run function bs.move:collision/check/block/shape

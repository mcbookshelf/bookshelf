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

# get cube bounding box coordinates
execute store result score #i bs.ctx run scoreboard players operation #x bs.ctx = #move.x bs.data
execute store result score #j bs.ctx run scoreboard players operation #y bs.ctx = #move.y bs.data
execute store result score #k bs.ctx run scoreboard players operation #z bs.ctx = #move.z bs.data
scoreboard players add #i bs.ctx 10000000
scoreboard players add #j bs.ctx 10000000
scoreboard players add #k bs.ctx 10000000

# perform AABB collision check
function bs.move:collision/check/aabb

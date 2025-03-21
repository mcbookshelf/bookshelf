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

# get the travelled distance and the surface that was hit
scoreboard players operation #move.ctime bs.data = #x bs.ctx
execute if score #move.vx bs.data matches ..-1 run scoreboard players set $move.hit_face bs.lambda 5
execute if score #move.vx bs.data matches 0.. run scoreboard players set $move.hit_face bs.lambda 4
execute if score #move.ctime bs.data = #z bs.ctx if score #move.vz bs.data matches ..-1 run scoreboard players set $move.hit_face bs.lambda 3
execute if score #move.ctime bs.data = #z bs.ctx if score #move.vz bs.data matches 0.. run scoreboard players set $move.hit_face bs.lambda 2
execute if score #move.ctime bs.data = #y bs.ctx if score #move.vy bs.data matches ..-1 run scoreboard players set $move.hit_face bs.lambda 1
execute if score #move.ctime bs.data = #y bs.ctx if score #move.vy bs.data matches 0.. run scoreboard players set $move.hit_face bs.lambda 0

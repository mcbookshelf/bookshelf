# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2026 Gunivers
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

execute store result storage bs.hitbox: x int -131072 run data get storage bs.hitbox: pos[0] .00000762939453125
execute store result storage bs.hitbox: y int -131072 run data get storage bs.hitbox: pos[1] .00000762939453125
execute store result storage bs.hitbox: z int -131072 run data get storage bs.hitbox: pos[2] .00000762939453125
function bs.hitbox:utils/move_by_region with storage bs.hitbox:
data modify storage bs.hitbox: pos set from entity @s Pos
execute store result score #x bs.ctx run data get storage bs.hitbox: pos[0] 16384
execute store result score #y bs.ctx run data get storage bs.hitbox: pos[1] 16384
execute store result score #z bs.ctx run data get storage bs.hitbox: pos[2] 16384
tp @s ~ -1000000 ~
kill @s

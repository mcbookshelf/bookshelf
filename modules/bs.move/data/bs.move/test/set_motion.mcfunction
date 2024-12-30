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

summon minecraft:pig ~ ~ ~ {Tags:["bs.packtest"]}
scoreboard players set @e[type=minecraft:pig,tag=bs.packtest] bs.vel.x 250
scoreboard players set @e[type=minecraft:pig,tag=bs.packtest] bs.vel.y 50
scoreboard players set @e[type=minecraft:pig,tag=bs.packtest] bs.vel.z 0
execute as @e[type=minecraft:pig,tag=bs.packtest] run function #bs.move:set_motion {scale:0.001}
assert data entity @n[type=minecraft:pig,tag=bs.packtest] {Motion:[0.25d,0.05d,0.0d]}

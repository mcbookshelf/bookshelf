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

execute unless block ~ ~ ~ #bs.hitbox:is_composite run return run function bs.raycast:collide/cube

function #bs.hitbox:get_block
execute store result score #raycast.ox bs.data run data get storage bs:out hitbox.offset.x 10000000
execute store result score #raycast.oz bs.data run data get storage bs:out hitbox.offset.z 10000000

execute if score #raycast.ux bs.data matches 0.. run scoreboard players operation #raycast.lx bs.data -= #raycast.dx bs.data
execute if score #raycast.uy bs.data matches 0.. run scoreboard players operation #raycast.ly bs.data -= #raycast.dy bs.data
execute if score #raycast.uz bs.data matches 0.. run scoreboard players operation #raycast.lz bs.data -= #raycast.dz bs.data
function bs.raycast:check/block/shape
execute if score #raycast.ux bs.data matches 0.. run scoreboard players operation #raycast.lx bs.data += #raycast.dx bs.data
execute if score #raycast.uy bs.data matches 0.. run scoreboard players operation #raycast.ly bs.data += #raycast.dy bs.data
execute if score #raycast.uz bs.data matches 0.. run scoreboard players operation #raycast.lz bs.data += #raycast.dz bs.data

execute unless score #raycast.distance bs.data matches 2147483647 run function bs.raycast:collide/block

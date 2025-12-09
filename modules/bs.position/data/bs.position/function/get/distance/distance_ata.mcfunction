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

execute summon minecraft:marker run function bs.position:get/position/ctx
$execute store result score #x bs.ctx run data get storage bs:ctx _[0] $(scale)
$execute store result score #y bs.ctx run data get storage bs:ctx _[1] $(scale)
$execute store result score #z bs.ctx run data get storage bs:ctx _[2] $(scale)
$execute store result score #u bs.ctx run data get entity @s Pos[0] $(scale)
$execute store result score #v bs.ctx run data get entity @s Pos[1] $(scale)
$execute store result score #w bs.ctx run data get entity @s Pos[2] $(scale)

# compute Euclidean distance: sqrt(x^2+y^2+z^2)
# Thanks to Triton365 for sharing this trick on the Minecraft Commands discord
execute store result storage bs:data position.distance[0] float 1 run scoreboard players operation #x bs.ctx -= #u bs.ctx
execute store result storage bs:data position.distance[4] float 1 run scoreboard players operation #y bs.ctx -= #v bs.ctx
execute store result storage bs:data position.distance[8] float 1 run scoreboard players operation #z bs.ctx -= #w bs.ctx
data modify entity B5-0-0-0-2 transformation set from storage bs:data position.distance

execute store result score $position.get_distance_ata bs.out run return run data get entity B5-0-0-0-2 transformation.scale[0]

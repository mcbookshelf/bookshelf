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

execute summon minecraft:marker run function bs.position:get/position/ctx
$execute store result score #x bs.ctx run data get storage bs:ctx _[0] $(scale)
$execute store result score #y bs.ctx run data get storage bs:ctx _[1] $(scale)
$execute store result score #z bs.ctx run data get storage bs:ctx _[2] $(scale)
$execute store result score #u bs.ctx run data get entity @s Pos[0] $(scale)
$execute store result score #v bs.ctx run data get entity @s Pos[1] $(scale)
$execute store result score #w bs.ctx run data get entity @s Pos[2] $(scale)

execute store result storage bs:ctx x int 1 run scoreboard players operation #x bs.ctx -= #u bs.ctx
execute store result storage bs:ctx y int 1 run scoreboard players operation #y bs.ctx -= #v bs.ctx
execute store result storage bs:ctx z int 1 run scoreboard players operation #z bs.ctx -= #w bs.ctx

execute store result score $position.get_distance_ata bs.out as B5-0-0-0-2 run return run function bs.position:get/distance/compute with storage bs:ctx

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

scoreboard players operation #x bs.ctx -= #u bs.ctx
scoreboard players operation #y bs.ctx -= #v bs.ctx
scoreboard players operation #z bs.ctx -= #w bs.ctx
scoreboard players operation #x bs.ctx *= #x bs.ctx
scoreboard players operation #y bs.ctx *= #y bs.ctx
scoreboard players operation #z bs.ctx *= #z bs.ctx

scoreboard players operation #x bs.ctx += #y bs.ctx
execute store result score $position.get_distance_squared_ata bs.out run return run scoreboard players operation #x bs.ctx += #z bs.ctx

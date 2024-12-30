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

scoreboard players operation $id.suid bs.in = @s bs.link.to
execute at @n[predicate=bs.id:suid_equal,sort=arbitrary] run function #bs.position:get_pos_and_rot {scale:1000}

scoreboard players operation #x bs.ctx = @s bs.pos.x
scoreboard players operation #y bs.ctx = @s bs.pos.y
scoreboard players operation #z bs.ctx = @s bs.pos.z
scoreboard players operation #h bs.ctx = @s bs.rot.h
scoreboard players operation #v bs.ctx = @s bs.rot.v

execute store result score @s bs.pos.x run data get entity @s Pos[0] 1000
execute store result score @s bs.pos.y run data get entity @s Pos[1] 1000
execute store result score @s bs.pos.z run data get entity @s Pos[2] 1000
execute store result score @s bs.rot.h run data get entity @s Rotation[0] 1000
execute store result score @s bs.rot.v run data get entity @s Rotation[1] 1000

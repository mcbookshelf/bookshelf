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

function #bs.position:get_relative_ata {scale:1000}
scoreboard players operation @s bs.link.rx = @s bs.pos.x
scoreboard players operation @s bs.link.ry = @s bs.pos.y
scoreboard players operation @s bs.link.rz = @s bs.pos.z

function #bs.position:canonical_to_local
scoreboard players operation @s bs.link.lx = @s bs.pos.x
scoreboard players operation @s bs.link.ly = @s bs.pos.y
scoreboard players operation @s bs.link.lz = @s bs.pos.z

execute store result score @s bs.link.lh run data get entity @s Rotation[0] 1000
execute store result score @s bs.link.lv run data get entity @s Rotation[1] 1000
function #bs.position:get_rot {scale:1000}
scoreboard players operation @s bs.link.lh -= @s bs.rot.h
scoreboard players operation @s bs.link.lv -= @s bs.rot.v

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

execute unless entity @s[type=#bs.hitbox:is_sized] on passengers run return run function bs.move:collision/utils/add_passengers_size

function #bs.hitbox:get_entity
execute store result score #s bs.ctx run data get storage bs:out hitbox.scale 1000
execute store result score #w bs.ctx run data get storage bs:out hitbox.width 5000
execute store result score #d bs.ctx run data get storage bs:out hitbox.depth 5000
execute store result score #h bs.ctx run data get storage bs:out hitbox.height 5000
scoreboard players operation #w bs.ctx *= #s bs.ctx
scoreboard players operation #d bs.ctx *= #s bs.ctx
scoreboard players operation #h bs.ctx *= #s bs.ctx

execute in minecraft:overworld positioned as @s as B5-0-0-0-1 run function bs.move:collision/utils/get_y_pos
scoreboard players operation #y bs.ctx -= #move.y bs.data
scoreboard players operation #y bs.ctx *= 1000 bs.const
scoreboard players operation #h bs.ctx += #y bs.ctx

scoreboard players operation #move.hw bs.data > #w bs.ctx
scoreboard players operation #move.hh bs.data > #h bs.ctx
scoreboard players operation #move.hd bs.data > #d bs.ctx

execute on passengers run function bs.move:collision/utils/add_passengers_size

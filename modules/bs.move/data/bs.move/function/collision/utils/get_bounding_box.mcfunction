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

execute if entity @s[scores={bs.width=0..,bs.height=0..,bs.depth=0..}] run return run function bs.move:collision/utils/get_custom_size

execute store result score #move.hw bs.data store result score #move.hh bs.data run scoreboard players set #move.hd bs.data 0
execute if entity @s[type=#bs.hitbox:is_sized] run function bs.move:collision/utils/get_default_size
scoreboard players operation #y bs.ctx = #move.vy bs.data
scoreboard players operation #y bs.ctx /= 1000 bs.const
scoreboard players operation #move.y bs.data += #y bs.ctx
execute on passengers run function bs.move:collision/utils/add_passengers_size

scoreboard players operation #move.w bs.data = #move.hw bs.data
scoreboard players operation #move.h bs.data = #move.hh bs.data
scoreboard players operation #move.d bs.data = #move.hd bs.data
scoreboard players operation #move.w bs.data *= 2 bs.const
scoreboard players operation #move.h bs.data *= 2 bs.const
scoreboard players operation #move.d bs.data *= 2 bs.const

scoreboard players operation #move.ry bs.data += #move.hh bs.data
scoreboard players operation #move.ny bs.data += #move.hh bs.data

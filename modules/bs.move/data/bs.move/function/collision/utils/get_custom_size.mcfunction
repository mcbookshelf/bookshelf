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

execute store result score #move.hw bs.data run scoreboard players operation #move.w bs.data = @s bs.width
execute store result score #move.hh bs.data run scoreboard players operation #move.h bs.data = @s bs.height
execute store result score #move.hd bs.data run scoreboard players operation #move.d bs.data = @s bs.depth
scoreboard players operation #move.w bs.data *= 2 bs.const
scoreboard players operation #move.h bs.data *= 2 bs.const
scoreboard players operation #move.d bs.data *= 2 bs.const

execute if entity @s[tag=bs.hitbox.centered] run return 0
scoreboard players operation #move.ry bs.data += #move.hh bs.data
scoreboard players operation #move.ny bs.data += #move.hh bs.data

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

# slime_like group
execute store result score #s bs.ctx run data get entity @s Size
scoreboard players add #s bs.ctx 1
scoreboard players operation #s bs.ctx *= 255 bs.const
scoreboard players set #w bs.ctx 2040
scoreboard players set #h bs.ctx 2040
execute store result storage bs:out hitbox.width double .000001 run scoreboard players operation #w bs.ctx *= #s bs.ctx
execute store result storage bs:out hitbox.height double .000001 run scoreboard players operation #h bs.ctx *= #s bs.ctx

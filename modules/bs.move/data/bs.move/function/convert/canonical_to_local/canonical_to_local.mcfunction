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

# sincos(h: Phi) & sincos(v: Theta)
execute in minecraft:overworld as B5-0-0-0-1 run function bs.move:convert/canonical_to_local/sincos

# X' = Z * sin(h) + X * cos(h)
scoreboard players operation #x bs.ctx = @s bs.vel.z
scoreboard players operation #x bs.ctx *= #j bs.ctx
scoreboard players operation #t bs.ctx = @s bs.vel.x
scoreboard players operation #t bs.ctx *= #i bs.ctx
scoreboard players operation #x bs.ctx += #t bs.ctx
scoreboard players operation #x bs.ctx /= 1000 bs.const

# Y' = (z * cos(h) - x * sin(h)) * sin(v) + y * cos(v)
scoreboard players operation #y bs.ctx = @s bs.vel.z
scoreboard players operation #y bs.ctx *= #i bs.ctx
scoreboard players operation #t bs.ctx = @s bs.vel.x
scoreboard players operation #t bs.ctx *= #j bs.ctx
scoreboard players operation #y bs.ctx -= #t bs.ctx
execute store result score #z bs.ctx run scoreboard players operation #y bs.ctx /= 1000 bs.const
scoreboard players operation #y bs.ctx *= #l bs.ctx
scoreboard players operation #t bs.ctx = @s bs.vel.y
scoreboard players operation #t bs.ctx *= #k bs.ctx
scoreboard players operation #y bs.ctx += #t bs.ctx
scoreboard players operation #y bs.ctx /= 1000 bs.const

# Z' = (z * cos(h) - x * sin(h)) * cos(v) - y * sin(v)
scoreboard players operation #z bs.ctx *= #k bs.ctx
scoreboard players operation #t bs.ctx = @s bs.vel.y
scoreboard players operation #t bs.ctx *= #l bs.ctx
scoreboard players operation #z bs.ctx -= #t bs.ctx
scoreboard players operation #z bs.ctx /= 1000 bs.const

scoreboard players operation @s bs.vel.x = #x bs.ctx
scoreboard players operation @s bs.vel.y = #y bs.ctx
scoreboard players operation @s bs.vel.z = #z bs.ctx

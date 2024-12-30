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

execute if score #t bs.ctx matches ..0 run return run scoreboard players set #n bs.ctx 0

scoreboard players operation #g bs.ctx = #i bs.ctx
scoreboard players operation #g bs.ctx *= 13 bs.const
scoreboard players operation #g bs.ctx += #j bs.ctx
scoreboard players operation #g bs.ctx += $random.simplex_noise_2d.seed bs.in

execute store result score #n bs.ctx run scoreboard players operation #g bs.ctx *= #g bs.ctx
scoreboard players operation #n bs.ctx /= 2 bs.const
scoreboard players operation #g bs.ctx *= #g bs.ctx
scoreboard players operation #g bs.ctx /= 24 bs.const
scoreboard players operation #n bs.ctx += #g bs.ctx
scoreboard players operation #n bs.ctx %= 8 bs.const

scoreboard players set #g bs.ctx 0
execute if score #n bs.ctx matches 0..2 run scoreboard players operation #g bs.ctx += #u bs.ctx
execute if score #n bs.ctx matches 1 run scoreboard players operation #g bs.ctx -= #v bs.ctx
execute if score #n bs.ctx matches 2..3 run scoreboard players operation #g bs.ctx += #v bs.ctx
execute if score #n bs.ctx matches 4..5 run scoreboard players operation #g bs.ctx -= #v bs.ctx
execute if score #n bs.ctx matches 5..7 run scoreboard players operation #g bs.ctx -= #u bs.ctx
execute if score #n bs.ctx matches 6 run scoreboard players operation #g bs.ctx += #v bs.ctx

execute store result score #n bs.ctx run scoreboard players operation #t bs.ctx *= #t bs.ctx
scoreboard players operation #t bs.ctx /= 1000 bs.const
scoreboard players operation #n bs.ctx *= #t bs.ctx
scoreboard players operation #n bs.ctx /= 1000 bs.const
scoreboard players operation #n bs.ctx *= #g bs.ctx
scoreboard players operation #n bs.ctx /= 1000 bs.const

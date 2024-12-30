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

data modify storage bs:ctx x set from storage bs:in math.sqrt.x
function bs.math:frexp/run

# secant approximation (x / 79249 + 19750 => 2 iters)
execute store result score #x bs.ctx store result score #y bs.ctx store result score #i bs.ctx store result score #j bs.ctx run data get storage bs:ctx x 1073741824
scoreboard players operation #x bs.ctx /= 79249 bs.const
scoreboard players add #x bs.ctx 19750
scoreboard players operation #i bs.ctx /= #x bs.ctx
scoreboard players operation #x bs.ctx += #i bs.ctx
scoreboard players operation #x bs.ctx /= 2 bs.const
scoreboard players operation #j bs.ctx /= #x bs.ctx
scoreboard players operation #x bs.ctx += #j bs.ctx
execute store result score #i bs.ctx store result score #j bs.ctx run scoreboard players operation #x bs.ctx /= 2 bs.const

# secant approximation (x - isqrt(x)^2) / (isqrt(x) * 2 + 1)
scoreboard players operation #i bs.ctx *= 2 bs.const
scoreboard players add #i bs.ctx 1
scoreboard players operation #j bs.ctx *= #j bs.ctx
scoreboard players operation #y bs.ctx -= #j bs.ctx
scoreboard players operation #y bs.ctx *= 32768 bs.const
scoreboard players operation #y bs.ctx /= #i bs.ctx
scoreboard players operation #x bs.ctx *= 32768 bs.const

scoreboard players operation #t bs.ctx = #e bs.ctx
scoreboard players operation #t bs.ctx %= 2 bs.const
scoreboard players operation #e bs.ctx += #t bs.ctx
scoreboard players operation #e bs.ctx /= 2 bs.const
execute if score #t bs.ctx matches 0 store result storage bs:ctx x float .000000000931322574615478515625 run scoreboard players operation #x bs.ctx += #y bs.ctx
execute if score #t bs.ctx matches 1 store result storage bs:ctx x float .00000000065854450798271929168823261686546190196711592079736874438822269439697265625 run scoreboard players operation #x bs.ctx += #y bs.ctx
function bs.math:ldexp/run
data modify storage bs:out math.sqrt set from storage bs:ctx x

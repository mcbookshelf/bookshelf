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

scoreboard players operation #c bs.ctx = $random.simplex_noise_2d.x bs.in
scoreboard players operation #d bs.ctx = $random.simplex_noise_2d.y bs.in
scoreboard players operation #c bs.ctx %= 1000000000 bs.const

# Skew the input space to determine which simplex cell we're in
execute store result score #i bs.ctx store result score #s bs.ctx run scoreboard players add #c bs.ctx 1000
execute store result score #j bs.ctx run scoreboard players operation #d bs.ctx %= 1000000000 bs.const
execute store result storage bs:ctx y int 1 run scoreboard players operation #s bs.ctx += #d bs.ctx
execute store result score #s bs.ctx run data get storage bs:ctx y .36602540378

scoreboard players operation #i bs.ctx += #s bs.ctx
execute store result score #u bs.ctx store result score #t bs.ctx run scoreboard players operation #i bs.ctx /= 1000 bs.const
scoreboard players operation #j bs.ctx += #s bs.ctx
execute store result score #v bs.ctx run scoreboard players operation #j bs.ctx /= 1000 bs.const
execute store result storage bs:ctx y int 1 run scoreboard players operation #t bs.ctx += #j bs.ctx
execute store result score #t bs.ctx run data get storage bs:ctx y 211.3248654

scoreboard players operation #u bs.ctx *= -1000 bs.const
scoreboard players operation #v bs.ctx *= -1000 bs.const
scoreboard players operation #u bs.ctx += #t bs.ctx
scoreboard players operation #v bs.ctx += #t bs.ctx
execute store result score #t bs.ctx run scoreboard players operation #u bs.ctx += #c bs.ctx
execute store result score #d bs.ctx run scoreboard players operation #v bs.ctx += #d bs.ctx

# Determine which simplex cell we are in
execute store success score #c bs.ctx if score #u bs.ctx > #v bs.ctx

# Calculate the contribution from the first corner
scoreboard players operation #t bs.ctx *= #t bs.ctx
scoreboard players operation #d bs.ctx *= #d bs.ctx
scoreboard players operation #t bs.ctx += #d bs.ctx
scoreboard players remove #t bs.ctx 500000
scoreboard players operation #t bs.ctx /= -1000 bs.const
scoreboard players set #n bs.ctx 0
execute if score #t bs.ctx matches 1.. run function bs.random:noise/simplex_noise_2d/gradient
scoreboard players operation $random.simplex_noise_2d bs.out = #n bs.ctx

# Calculate the contribution from the second corner
execute store result score #t bs.ctx run scoreboard players remove #u bs.ctx 578
execute store result score #d bs.ctx run scoreboard players remove #v bs.ctx 578
scoreboard players operation #t bs.ctx *= #t bs.ctx
scoreboard players operation #d bs.ctx *= #d bs.ctx
scoreboard players operation #t bs.ctx += #d bs.ctx
scoreboard players remove #t bs.ctx 500000
scoreboard players operation #t bs.ctx /= -1000 bs.const
scoreboard players add #i bs.ctx 1
scoreboard players add #j bs.ctx 1
scoreboard players set #n bs.ctx 0
execute if score #t bs.ctx matches 1.. run function bs.random:noise/simplex_noise_2d/gradient
scoreboard players operation $random.simplex_noise_2d bs.out += #n bs.ctx

# Calculate the contribution from the third corner
execute if score #c bs.ctx matches 1 run scoreboard players remove #u bs.ctx 1000
execute if score #c bs.ctx matches 0 run scoreboard players remove #v bs.ctx 1000
execute store result score #t bs.ctx run scoreboard players add #u bs.ctx 789
execute store result score #d bs.ctx run scoreboard players add #v bs.ctx 789
scoreboard players operation #t bs.ctx *= #t bs.ctx
scoreboard players operation #d bs.ctx *= #d bs.ctx
scoreboard players operation #t bs.ctx += #d bs.ctx
scoreboard players remove #t bs.ctx 500000
scoreboard players operation #t bs.ctx /= -1000 bs.const
execute if score #c bs.ctx matches 0 run scoreboard players remove #i bs.ctx 1
execute if score #c bs.ctx matches 1 run scoreboard players remove #j bs.ctx 1
scoreboard players set #n bs.ctx 0
execute if score #t bs.ctx matches 1.. run function bs.random:noise/simplex_noise_2d/gradient
scoreboard players operation $random.simplex_noise_2d bs.out += #n bs.ctx

# Scale the result to cover the range [-1000, 1000]
return run scoreboard players operation $random.simplex_noise_2d bs.out /= 14 bs.const

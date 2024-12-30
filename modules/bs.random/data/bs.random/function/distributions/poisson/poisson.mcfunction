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

# Modified from https://github.com/Aeldrion/Minecraft-Random

# Save expected value as two scores
$data modify storage bs:ctx _ set value $(lambda)
execute store result score #i bs.ctx run data get storage bs:ctx _
execute store result score #d bs.ctx run data get storage bs:ctx _ 10
execute unless score #d bs.ctx matches 0..100 run function #bs.log:error { \
  namespace:"bs.random", \
  tag:"poisson", \
  message:'"Lambda must be between 0 and 10."', \
  path:"bs.random:distributions/poisson/poisson", \
}
scoreboard players operation #d bs.ctx %= 10 bs.const

# Make sure expected value is valid
execute if score #i bs.ctx matches ..-1 run scoreboard players set #i bs.ctx 0
execute if score #i bs.ctx matches 11.. run scoreboard players set #i bs.ctx 10
execute if score #i bs.ctx matches 0 if score #d bs.ctx matches 0 run scoreboard players set #d bs.ctx 1

# Evaluate exp(-l). The result is a number between 0 and 1 (but not 0), we save it with a scale of 2147483648
execute if score #i bs.ctx matches 0 run scoreboard players set #e bs.ctx 32768
execute if score #i bs.ctx matches 1 run scoreboard players set #e bs.ctx 12054
execute if score #i bs.ctx matches 2 run scoreboard players set #e bs.ctx 4434
execute if score #i bs.ctx matches 3 run scoreboard players set #e bs.ctx 1631
execute if score #i bs.ctx matches 4 run scoreboard players set #e bs.ctx 600
execute if score #i bs.ctx matches 5 run scoreboard players set #e bs.ctx 221
execute if score #i bs.ctx matches 6 run scoreboard players set #e bs.ctx 81
execute if score #i bs.ctx matches 7 run scoreboard players set #e bs.ctx 30
execute if score #i bs.ctx matches 8 run scoreboard players set #e bs.ctx 11
execute if score #i bs.ctx matches 9 run scoreboard players set #e bs.ctx 4
execute if score #i bs.ctx matches 10 run scoreboard players set #e bs.ctx 2

# e * exp(0)*65536, e * exp(-0.1)*65536, e * exp(-0.2)*65536, ..., e * exp(-0.9)*65536,
execute if score #d bs.ctx matches 0 run scoreboard players operation #e bs.ctx *= 65536 bs.const
execute if score #d bs.ctx matches 1 run scoreboard players operation #e bs.ctx *= 59299 bs.const
execute if score #d bs.ctx matches 2 run scoreboard players operation #e bs.ctx *= 53656 bs.const
execute if score #d bs.ctx matches 3 run scoreboard players operation #e bs.ctx *= 48550 bs.const
execute if score #d bs.ctx matches 4 run scoreboard players operation #e bs.ctx *= 43930 bs.const
execute if score #d bs.ctx matches 5 run scoreboard players operation #e bs.ctx *= 39750 bs.const
execute if score #d bs.ctx matches 6 run scoreboard players operation #e bs.ctx *= 35967 bs.const
execute if score #d bs.ctx matches 7 run scoreboard players operation #e bs.ctx *= 32544 bs.const
execute if score #d bs.ctx matches 8 run scoreboard players operation #e bs.ctx *= 29447 bs.const
execute if score #d bs.ctx matches 9 run scoreboard players operation #e bs.ctx *= 26645 bs.const

# Draw random number using Knuth's method
scoreboard players set #p bs.ctx 2147483647
scoreboard players set #k bs.ctx -1
function bs.random:distributions/poisson/loop
return run scoreboard players operation $random.poisson bs.out = #k bs.ctx

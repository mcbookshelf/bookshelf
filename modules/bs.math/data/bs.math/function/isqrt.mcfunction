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

# Note: Thanks to the Minecraft Commands' discord server for the help provided (https://discord.gg/QAFXFtZ)

execute store result score #s bs.ctx store result score #t bs.ctx store result score #u bs.ctx store result score #v bs.ctx run scoreboard players operation $math.isqrt bs.out = $math.isqrt.x bs.in

execute if score $math.isqrt.x bs.in matches 0..1515359 run scoreboard players operation $math.isqrt bs.out /= 559 bs.const
execute if score $math.isqrt.x bs.in matches 0..1515359 run scoreboard players add $math.isqrt bs.out 15
execute if score $math.isqrt.x bs.in matches 1515360.. run scoreboard players operation $math.isqrt bs.out /= 32768 bs.const
execute if score $math.isqrt.x bs.in matches 1515360.. run scoreboard players add $math.isqrt bs.out 2456

scoreboard players operation #s bs.ctx /= $math.isqrt bs.out
scoreboard players operation $math.isqrt bs.out += #s bs.ctx
scoreboard players operation $math.isqrt bs.out /= 2 bs.const
scoreboard players operation #t bs.ctx /= $math.isqrt bs.out
scoreboard players operation $math.isqrt bs.out += #t bs.ctx
scoreboard players operation $math.isqrt bs.out /= 2 bs.const
scoreboard players operation #u bs.ctx /= $math.isqrt bs.out
scoreboard players operation $math.isqrt bs.out += #u bs.ctx
scoreboard players operation $math.isqrt bs.out /= 2 bs.const

scoreboard players operation #v bs.ctx /= $math.isqrt bs.out
execute if score $math.isqrt bs.out > #v bs.ctx run scoreboard players remove $math.isqrt bs.out 1
return run scoreboard players get $math.isqrt bs.out

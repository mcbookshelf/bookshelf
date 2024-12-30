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

# Note: This algorithm is taken from the Handbook of Mathematical Functions (M. Abramowitz and I.A. Stegun, Ed.)

scoreboard players operation #x bs.ctx = $math.acos.x bs.in
execute if score $math.acos.x bs.in matches ..-1 run scoreboard players operation #x bs.ctx *= -1 bs.const

scoreboard players set $math.acos bs.out 107311
scoreboard players operation $math.acos bs.out *= #x bs.ctx
scoreboard players operation $math.acos bs.out /= 1000 bs.const
scoreboard players remove $math.acos bs.out 425484
scoreboard players operation $math.acos bs.out *= #x bs.ctx
scoreboard players operation $math.acos bs.out /= 1000 bs.const
scoreboard players add $math.acos bs.out 1215325
scoreboard players operation $math.acos bs.out *= #x bs.ctx
scoreboard players operation $math.acos bs.out /= 1000 bs.const
scoreboard players remove $math.acos bs.out 9000000
scoreboard players operation $math.acos bs.out /= 100 bs.const

scoreboard players operation $math.isqrt.x bs.in >< #x bs.ctx
scoreboard players operation $math.isqrt.x bs.in *= -100000 bs.const
scoreboard players add $math.isqrt.x bs.in 100000000
function #bs.math:isqrt
scoreboard players operation $math.isqrt.x bs.in >< #x bs.ctx
scoreboard players operation $math.acos bs.out *= $math.isqrt bs.out
scoreboard players operation $math.acos bs.out /= 100000 bs.const

execute if score $math.acos.x bs.in matches 0.. run scoreboard players operation $math.acos bs.out *= -1 bs.const
execute if score $math.acos.x bs.in matches ..-1 run scoreboard players add $math.acos bs.out 18000

return run scoreboard players get $math.acos bs.out

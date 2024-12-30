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

# Normalize angle
scoreboard players operation $math.cos bs.out = $math.cos.x bs.in
execute store result score #x bs.ctx run scoreboard players operation $math.cos bs.out %= 36000 bs.const
execute if score #x bs.ctx matches 9000..27000 run scoreboard players remove $math.cos bs.out 18000
execute if score #x bs.ctx matches 27001.. run scoreboard players remove $math.cos bs.out 36000

# Compute Bhāskara cosine approximation
execute store result score #y bs.ctx run scoreboard players operation $math.cos bs.out *= $math.cos bs.out
scoreboard players operation $math.cos bs.out *= -4 bs.const
scoreboard players add $math.cos bs.out 324000000
scoreboard players add #y bs.ctx 324000000
scoreboard players operation #y bs.ctx /= 1000 bs.const
execute if score #x bs.ctx matches 9000..27000 run scoreboard players operation #y bs.ctx *= -1 bs.const
return run scoreboard players operation $math.cos bs.out /= #y bs.ctx

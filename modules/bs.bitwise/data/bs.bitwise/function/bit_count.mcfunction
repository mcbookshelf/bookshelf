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

scoreboard players set $bitwise.bit_count bs.out 0
scoreboard players operation #n bs.ctx = $bitwise.bit_count.n bs.in
execute if score #n bs.ctx matches ..-1 run scoreboard players operation #n bs.ctx *= -1 bs.const
scoreboard players operation #n bs.ctx *= 2 bs.const
execute if score #n bs.ctx matches ..-1 run scoreboard players add $bitwise.bit_count bs.out 1
scoreboard players operation #n bs.ctx *= 2 bs.const
execute if score #n bs.ctx matches ..-1 run scoreboard players add $bitwise.bit_count bs.out 1
scoreboard players operation #n bs.ctx *= 2 bs.const
execute if score #n bs.ctx matches ..-1 run scoreboard players add $bitwise.bit_count bs.out 1
scoreboard players operation #n bs.ctx *= 2 bs.const
execute if score #n bs.ctx matches ..-1 run scoreboard players add $bitwise.bit_count bs.out 1
scoreboard players operation #n bs.ctx *= 2 bs.const
execute if score #n bs.ctx matches ..-1 run scoreboard players add $bitwise.bit_count bs.out 1
scoreboard players operation #n bs.ctx *= 2 bs.const
execute if score #n bs.ctx matches ..-1 run scoreboard players add $bitwise.bit_count bs.out 1
scoreboard players operation #n bs.ctx *= 2 bs.const
execute if score #n bs.ctx matches ..-1 run scoreboard players add $bitwise.bit_count bs.out 1
scoreboard players operation #n bs.ctx *= 2 bs.const
execute if score #n bs.ctx matches ..-1 run scoreboard players add $bitwise.bit_count bs.out 1
scoreboard players operation #n bs.ctx *= 2 bs.const
execute if score #n bs.ctx matches ..-1 run scoreboard players add $bitwise.bit_count bs.out 1
scoreboard players operation #n bs.ctx *= 2 bs.const
execute if score #n bs.ctx matches ..-1 run scoreboard players add $bitwise.bit_count bs.out 1
scoreboard players operation #n bs.ctx *= 2 bs.const
execute if score #n bs.ctx matches ..-1 run scoreboard players add $bitwise.bit_count bs.out 1
scoreboard players operation #n bs.ctx *= 2 bs.const
execute if score #n bs.ctx matches ..-1 run scoreboard players add $bitwise.bit_count bs.out 1
scoreboard players operation #n bs.ctx *= 2 bs.const
execute if score #n bs.ctx matches ..-1 run scoreboard players add $bitwise.bit_count bs.out 1
scoreboard players operation #n bs.ctx *= 2 bs.const
execute if score #n bs.ctx matches ..-1 run scoreboard players add $bitwise.bit_count bs.out 1
scoreboard players operation #n bs.ctx *= 2 bs.const
execute if score #n bs.ctx matches ..-1 run scoreboard players add $bitwise.bit_count bs.out 1
scoreboard players operation #n bs.ctx *= 2 bs.const
execute if score #n bs.ctx matches ..-1 run scoreboard players add $bitwise.bit_count bs.out 1
scoreboard players operation #n bs.ctx *= 2 bs.const
execute if score #n bs.ctx matches ..-1 run scoreboard players add $bitwise.bit_count bs.out 1
scoreboard players operation #n bs.ctx *= 2 bs.const
execute if score #n bs.ctx matches ..-1 run scoreboard players add $bitwise.bit_count bs.out 1
scoreboard players operation #n bs.ctx *= 2 bs.const
execute if score #n bs.ctx matches ..-1 run scoreboard players add $bitwise.bit_count bs.out 1
scoreboard players operation #n bs.ctx *= 2 bs.const
execute if score #n bs.ctx matches ..-1 run scoreboard players add $bitwise.bit_count bs.out 1
scoreboard players operation #n bs.ctx *= 2 bs.const
execute if score #n bs.ctx matches ..-1 run scoreboard players add $bitwise.bit_count bs.out 1
scoreboard players operation #n bs.ctx *= 2 bs.const
execute if score #n bs.ctx matches ..-1 run scoreboard players add $bitwise.bit_count bs.out 1
scoreboard players operation #n bs.ctx *= 2 bs.const
execute if score #n bs.ctx matches ..-1 run scoreboard players add $bitwise.bit_count bs.out 1
scoreboard players operation #n bs.ctx *= 2 bs.const
execute if score #n bs.ctx matches ..-1 run scoreboard players add $bitwise.bit_count bs.out 1
scoreboard players operation #n bs.ctx *= 2 bs.const
execute if score #n bs.ctx matches ..-1 run scoreboard players add $bitwise.bit_count bs.out 1
scoreboard players operation #n bs.ctx *= 2 bs.const
execute if score #n bs.ctx matches ..-1 run scoreboard players add $bitwise.bit_count bs.out 1
scoreboard players operation #n bs.ctx *= 2 bs.const
execute if score #n bs.ctx matches ..-1 run scoreboard players add $bitwise.bit_count bs.out 1
scoreboard players operation #n bs.ctx *= 2 bs.const
execute if score #n bs.ctx matches ..-1 run scoreboard players add $bitwise.bit_count bs.out 1
scoreboard players operation #n bs.ctx *= 2 bs.const
execute if score #n bs.ctx matches ..-1 run scoreboard players add $bitwise.bit_count bs.out 1
scoreboard players operation #n bs.ctx *= 2 bs.const
execute if score #n bs.ctx matches ..-1 run scoreboard players add $bitwise.bit_count bs.out 1
scoreboard players operation #n bs.ctx *= 2 bs.const
execute if score #n bs.ctx matches ..-1 run scoreboard players add $bitwise.bit_count bs.out 1
return run scoreboard players get $bitwise.bit_count bs.out

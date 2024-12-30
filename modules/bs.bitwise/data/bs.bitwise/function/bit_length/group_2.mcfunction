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

execute if score #n bs.ctx matches 128..255 run return run scoreboard players set $bitwise.bit_length bs.out 8
execute if score #n bs.ctx matches 256..511 run return run scoreboard players set $bitwise.bit_length bs.out 9
execute if score #n bs.ctx matches 512..1023 run return run scoreboard players set $bitwise.bit_length bs.out 10
execute if score #n bs.ctx matches 1024..2047 run return run scoreboard players set $bitwise.bit_length bs.out 11
execute if score #n bs.ctx matches 2048..4095 run return run scoreboard players set $bitwise.bit_length bs.out 12
execute if score #n bs.ctx matches 4096..8191 run return run scoreboard players set $bitwise.bit_length bs.out 13
execute if score #n bs.ctx matches 8192..16383 run return run scoreboard players set $bitwise.bit_length bs.out 14
execute if score #n bs.ctx matches 16384..32767 run return run scoreboard players set $bitwise.bit_length bs.out 15

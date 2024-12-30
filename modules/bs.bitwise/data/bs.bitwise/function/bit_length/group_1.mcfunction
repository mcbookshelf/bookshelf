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

execute if score #n bs.ctx matches 0 run return run scoreboard players set $bitwise.bit_length bs.out 0
execute if score #n bs.ctx matches 1 run return run scoreboard players set $bitwise.bit_length bs.out 1
execute if score #n bs.ctx matches 2..3 run return run scoreboard players set $bitwise.bit_length bs.out 2
execute if score #n bs.ctx matches 4..7 run return run scoreboard players set $bitwise.bit_length bs.out 3
execute if score #n bs.ctx matches 8..15 run return run scoreboard players set $bitwise.bit_length bs.out 4
execute if score #n bs.ctx matches 16..31 run return run scoreboard players set $bitwise.bit_length bs.out 5
execute if score #n bs.ctx matches 32..63 run return run scoreboard players set $bitwise.bit_length bs.out 6
execute if score #n bs.ctx matches 64..127 run return run scoreboard players set $bitwise.bit_length bs.out 7

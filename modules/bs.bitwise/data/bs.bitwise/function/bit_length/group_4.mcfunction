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

execute if score #n bs.ctx matches 8388608..16777215 run return run scoreboard players set $bitwise.bit_length bs.out 24
execute if score #n bs.ctx matches 16777216..33554431 run return run scoreboard players set $bitwise.bit_length bs.out 25
execute if score #n bs.ctx matches 33554432..67108863 run return run scoreboard players set $bitwise.bit_length bs.out 26
execute if score #n bs.ctx matches 67108864..134217727 run return run scoreboard players set $bitwise.bit_length bs.out 27
execute if score #n bs.ctx matches 134217728..268435455 run return run scoreboard players set $bitwise.bit_length bs.out 28
execute if score #n bs.ctx matches 268435456..536870911 run return run scoreboard players set $bitwise.bit_length bs.out 29
execute if score #n bs.ctx matches 536870912..1073741823 run return run scoreboard players set $bitwise.bit_length bs.out 30
execute if score #n bs.ctx matches 1073741824.. run return run scoreboard players set $bitwise.bit_length bs.out 31

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

execute if score #n bs.ctx matches 32768..65535 run return run scoreboard players set $bitwise.bit_length bs.out 16
execute if score #n bs.ctx matches 65536..131071 run return run scoreboard players set $bitwise.bit_length bs.out 17
execute if score #n bs.ctx matches 131072..262143 run return run scoreboard players set $bitwise.bit_length bs.out 18
execute if score #n bs.ctx matches 262144..524287 run return run scoreboard players set $bitwise.bit_length bs.out 19
execute if score #n bs.ctx matches 524288..1048575 run return run scoreboard players set $bitwise.bit_length bs.out 20
execute if score #n bs.ctx matches 1048576..2097151 run return run scoreboard players set $bitwise.bit_length bs.out 21
execute if score #n bs.ctx matches 2097152..4194303 run return run scoreboard players set $bitwise.bit_length bs.out 22
execute if score #n bs.ctx matches 4194304..8388607 run return run scoreboard players set $bitwise.bit_length bs.out 23

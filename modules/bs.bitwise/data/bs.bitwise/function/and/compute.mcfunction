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

scoreboard players set #x bs.ctx 0
execute if score #a bs.ctx matches ..-1 if score #b bs.ctx matches ..-1 run scoreboard players set #x bs.ctx -2147483648
scoreboard players operation #a bs.ctx *= 2 bs.const
scoreboard players operation #b bs.ctx *= 2 bs.const
execute if score #a bs.ctx matches ..-1 if score #b bs.ctx matches ..-1 run scoreboard players add #x bs.ctx 1073741824
scoreboard players operation #a bs.ctx *= 2 bs.const
scoreboard players operation #b bs.ctx *= 2 bs.const
execute if score #a bs.ctx matches ..-1 if score #b bs.ctx matches ..-1 run scoreboard players add #x bs.ctx 536870912
scoreboard players operation #a bs.ctx *= 2 bs.const
scoreboard players operation #b bs.ctx *= 2 bs.const
execute if score #a bs.ctx matches ..-1 if score #b bs.ctx matches ..-1 run scoreboard players add #x bs.ctx 268435456
scoreboard players operation #a bs.ctx *= 2 bs.const
scoreboard players operation #b bs.ctx *= 2 bs.const
execute if score #a bs.ctx matches ..-1 if score #b bs.ctx matches ..-1 run scoreboard players add #x bs.ctx 134217728
scoreboard players operation #a bs.ctx *= 2 bs.const
scoreboard players operation #b bs.ctx *= 2 bs.const
execute if score #a bs.ctx matches ..-1 if score #b bs.ctx matches ..-1 run scoreboard players add #x bs.ctx 67108864
scoreboard players operation #a bs.ctx *= 2 bs.const
scoreboard players operation #b bs.ctx *= 2 bs.const
execute if score #a bs.ctx matches ..-1 if score #b bs.ctx matches ..-1 run scoreboard players add #x bs.ctx 33554432
scoreboard players operation #a bs.ctx *= 2 bs.const
scoreboard players operation #b bs.ctx *= 2 bs.const
execute if score #a bs.ctx matches ..-1 if score #b bs.ctx matches ..-1 run scoreboard players add #x bs.ctx 16777216
scoreboard players operation #a bs.ctx *= 2 bs.const
scoreboard players operation #b bs.ctx *= 2 bs.const
execute if score #a bs.ctx matches ..-1 if score #b bs.ctx matches ..-1 run scoreboard players add #x bs.ctx 8388608
scoreboard players operation #a bs.ctx *= 2 bs.const
scoreboard players operation #b bs.ctx *= 2 bs.const
execute if score #a bs.ctx matches ..-1 if score #b bs.ctx matches ..-1 run scoreboard players add #x bs.ctx 4194304
scoreboard players operation #a bs.ctx *= 2 bs.const
scoreboard players operation #b bs.ctx *= 2 bs.const
execute if score #a bs.ctx matches ..-1 if score #b bs.ctx matches ..-1 run scoreboard players add #x bs.ctx 2097152
scoreboard players operation #a bs.ctx *= 2 bs.const
scoreboard players operation #b bs.ctx *= 2 bs.const
execute if score #a bs.ctx matches ..-1 if score #b bs.ctx matches ..-1 run scoreboard players add #x bs.ctx 1048576
scoreboard players operation #a bs.ctx *= 2 bs.const
scoreboard players operation #b bs.ctx *= 2 bs.const
execute if score #a bs.ctx matches ..-1 if score #b bs.ctx matches ..-1 run scoreboard players add #x bs.ctx 524288
scoreboard players operation #a bs.ctx *= 2 bs.const
scoreboard players operation #b bs.ctx *= 2 bs.const
execute if score #a bs.ctx matches ..-1 if score #b bs.ctx matches ..-1 run scoreboard players add #x bs.ctx 262144
scoreboard players operation #a bs.ctx *= 2 bs.const
scoreboard players operation #b bs.ctx *= 2 bs.const
execute if score #a bs.ctx matches ..-1 if score #b bs.ctx matches ..-1 run scoreboard players add #x bs.ctx 131072
scoreboard players operation #a bs.ctx *= 2 bs.const
scoreboard players operation #b bs.ctx *= 2 bs.const
execute if score #a bs.ctx matches ..-1 if score #b bs.ctx matches ..-1 run scoreboard players add #x bs.ctx 65536
scoreboard players operation #a bs.ctx *= 2 bs.const
scoreboard players operation #b bs.ctx *= 2 bs.const
execute if score #a bs.ctx matches ..-1 if score #b bs.ctx matches ..-1 run scoreboard players add #x bs.ctx 32768
scoreboard players operation #a bs.ctx *= 2 bs.const
scoreboard players operation #b bs.ctx *= 2 bs.const
execute if score #a bs.ctx matches ..-1 if score #b bs.ctx matches ..-1 run scoreboard players add #x bs.ctx 16384
scoreboard players operation #a bs.ctx *= 2 bs.const
scoreboard players operation #b bs.ctx *= 2 bs.const
execute if score #a bs.ctx matches ..-1 if score #b bs.ctx matches ..-1 run scoreboard players add #x bs.ctx 8192
scoreboard players operation #a bs.ctx *= 2 bs.const
scoreboard players operation #b bs.ctx *= 2 bs.const
execute if score #a bs.ctx matches ..-1 if score #b bs.ctx matches ..-1 run scoreboard players add #x bs.ctx 4096
scoreboard players operation #a bs.ctx *= 2 bs.const
scoreboard players operation #b bs.ctx *= 2 bs.const
execute if score #a bs.ctx matches ..-1 if score #b bs.ctx matches ..-1 run scoreboard players add #x bs.ctx 2048
scoreboard players operation #a bs.ctx *= 2 bs.const
scoreboard players operation #b bs.ctx *= 2 bs.const
execute if score #a bs.ctx matches ..-1 if score #b bs.ctx matches ..-1 run scoreboard players add #x bs.ctx 1024
scoreboard players operation #a bs.ctx *= 2 bs.const
scoreboard players operation #b bs.ctx *= 2 bs.const
execute if score #a bs.ctx matches ..-1 if score #b bs.ctx matches ..-1 run scoreboard players add #x bs.ctx 512
scoreboard players operation #a bs.ctx *= 2 bs.const
scoreboard players operation #b bs.ctx *= 2 bs.const
execute if score #a bs.ctx matches ..-1 if score #b bs.ctx matches ..-1 run scoreboard players add #x bs.ctx 256
scoreboard players operation #a bs.ctx *= 2 bs.const
scoreboard players operation #b bs.ctx *= 2 bs.const
execute if score #a bs.ctx matches ..-1 if score #b bs.ctx matches ..-1 run scoreboard players add #x bs.ctx 128
scoreboard players operation #a bs.ctx *= 2 bs.const
scoreboard players operation #b bs.ctx *= 2 bs.const
execute if score #a bs.ctx matches ..-1 if score #b bs.ctx matches ..-1 run scoreboard players add #x bs.ctx 64
scoreboard players operation #a bs.ctx *= 2 bs.const
scoreboard players operation #b bs.ctx *= 2 bs.const
execute if score #a bs.ctx matches ..-1 if score #b bs.ctx matches ..-1 run scoreboard players add #x bs.ctx 32
scoreboard players operation #a bs.ctx *= 2 bs.const
scoreboard players operation #b bs.ctx *= 2 bs.const
execute if score #a bs.ctx matches ..-1 if score #b bs.ctx matches ..-1 run scoreboard players add #x bs.ctx 16
scoreboard players operation #a bs.ctx *= 2 bs.const
scoreboard players operation #b bs.ctx *= 2 bs.const
execute if score #a bs.ctx matches ..-1 if score #b bs.ctx matches ..-1 run scoreboard players add #x bs.ctx 8
scoreboard players operation #a bs.ctx *= 2 bs.const
scoreboard players operation #b bs.ctx *= 2 bs.const
execute if score #a bs.ctx matches ..-1 if score #b bs.ctx matches ..-1 run scoreboard players add #x bs.ctx 4
scoreboard players operation #a bs.ctx *= 2 bs.const
scoreboard players operation #b bs.ctx *= 2 bs.const
execute if score #a bs.ctx matches ..-1 if score #b bs.ctx matches ..-1 run scoreboard players add #x bs.ctx 2
scoreboard players operation #a bs.ctx *= 2 bs.const
scoreboard players operation #b bs.ctx *= 2 bs.const
execute if score #a bs.ctx matches ..-1 if score #b bs.ctx matches ..-1 run scoreboard players add #x bs.ctx 1

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

forceload add -30000000 1600
setblock -30000000 0 1606 minecraft:decorated_pot

scoreboard objectives add bs.const dummy [{"text":"BS ","color":"dark_gray"},{"text":"Constants","color":"aqua"}]
scoreboard objectives add bs.ctx dummy [{"text":"BS ","color":"dark_gray"},{"text":"Context","color":"aqua"}]
scoreboard objectives add bs.out dummy [{"text":"BS ","color":"dark_gray"},{"text":"Output","color":"aqua"}]

scoreboard players set 2 bs.const 2
scoreboard players set 11 bs.const 11
scoreboard players set 15 bs.const 15
scoreboard players set 255 bs.const 255
scoreboard players set 1000 bs.const 1000
scoreboard players set 65536 bs.const 65536
scoreboard players set 3129871 bs.const 3129871
scoreboard players set 1000000 bs.const 1000000
scoreboard players set 10000000 bs.const 10000000
scoreboard players set 16777216 bs.const 16777216
scoreboard players set 42317861 bs.const 42317861
scoreboard players set 116129781 bs.const 116129781
scoreboard players set 268435456 bs.const 268435456

data modify storage bs:data hitbox.offsets set value []

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

execute store result score #x bs.ctx run scoreboard players operation $math.divide bs.out = $math.divide.x bs.in
scoreboard players operation $math.divide bs.out /= $math.divide.y bs.in
execute store result score #y bs.ctx run scoreboard players operation #x bs.ctx %= $math.divide.y bs.in
scoreboard players operation #y bs.ctx -= $math.divide.y bs.in
scoreboard players operation #y bs.ctx *= -1 bs.const
execute if score #y bs.ctx < #x bs.ctx run scoreboard players add $math.divide bs.out 1
return run scoreboard players get $math.divide bs.out

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
# @dummy

execute store result score @s bs.pos.z run random value -10000..10000
function #bs.position:set_pos_z {scale:.001}
execute store result score #z bs.ctx run data get entity @s Pos[2] 1000
scoreboard players operation #z bs.ctx -= @s bs.pos.z

assert score #z bs.ctx matches -2..2

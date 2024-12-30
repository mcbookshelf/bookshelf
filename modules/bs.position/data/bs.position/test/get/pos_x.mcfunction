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

execute at @s positioned ~1 ~1 ~1 run function #bs.position:get_pos_x {scale:10}

execute store result score #x bs.ctx run data get entity @s Pos[0] 10
scoreboard players operation #x bs.ctx -= @s bs.pos.x

assert score #x bs.ctx matches -11..-9

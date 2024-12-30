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

scoreboard players add #k bs.ctx 1
scoreboard players add #i bs.ctx 1

scoreboard players operation $math.combine bs.out /= #i bs.ctx
scoreboard players operation $math.combine bs.out *= #k bs.ctx

scoreboard players operation #m bs.ctx %= #i bs.ctx
scoreboard players operation #m bs.ctx *= #k bs.ctx
scoreboard players operation #m bs.ctx /= #i bs.ctx
execute store result score #m bs.ctx run scoreboard players operation $math.combine bs.out += #m bs.ctx

execute if score #i bs.ctx < #n bs.ctx run function bs.math:combine/recurse/next

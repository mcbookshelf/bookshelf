# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Gunivers
#
# This file is part of the Bookshelf project (https://github.com/mcbookshelf/bookshelf).
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

scoreboard players operation #move.vy bs.data /= -10000 bs.const
scoreboard players operation #move.vy bs.data *= -1 bs.const
execute store result score #move.dy bs.data run scoreboard players operation #move.ny bs.data += #move.hh bs.data
scoreboard players operation #move.dy bs.data /= 10000000 bs.const
execute store result score #move.sy bs.data store result score #t bs.ctx run scoreboard players operation #move.ry bs.data -= #move.hh bs.data
scoreboard players operation #move.ny bs.data -= #move.ry bs.data
execute store result storage bs:data move.sy int 1 run scoreboard players operation #t bs.ctx /= 10000000 bs.const
execute store result storage bs:data move.dy int 1 run scoreboard players operation #move.dy bs.data -= #t bs.ctx
scoreboard players operation #move.ry bs.data *= -1 bs.const
scoreboard players operation #t bs.ctx *= 10000000 bs.const
scoreboard players operation #move.ry bs.data += #t bs.ctx

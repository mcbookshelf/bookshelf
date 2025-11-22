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

scoreboard players operation #move.vx bs.data /= 10000 bs.const
execute store result score #move.dx bs.data run scoreboard players operation #move.rx bs.data += #move.hw bs.data
scoreboard players operation #move.dx bs.data /= 10000000 bs.const
scoreboard players operation #move.nx bs.data -= #move.hw bs.data
execute store result storage bs:data move.sx int 1 run scoreboard players operation #move.nx bs.data /= 10000000 bs.const
execute store result storage bs:data move.dx int 1 run scoreboard players operation #move.dx bs.data -= #move.nx bs.data
execute store result score #move.sx bs.data run scoreboard players operation #move.rx bs.data -= #move.w bs.data
scoreboard players operation #move.rx bs.data *= -1 bs.const
scoreboard players operation #move.nx bs.data *= 10000000 bs.const
scoreboard players operation #move.rx bs.data += #move.nx bs.data
scoreboard players operation #move.nx bs.data = #move.w bs.data

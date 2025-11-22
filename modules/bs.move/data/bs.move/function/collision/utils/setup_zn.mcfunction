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

scoreboard players operation #move.vz bs.data /= 10000 bs.const
execute store result score #move.dz bs.data run scoreboard players operation #move.rz bs.data += #move.hd bs.data
scoreboard players operation #move.dz bs.data /= 10000000 bs.const
scoreboard players operation #move.nz bs.data -= #move.hd bs.data
execute store result storage bs:data move.sz int 1 run scoreboard players operation #move.nz bs.data /= 10000000 bs.const
execute store result storage bs:data move.dz int 1 run scoreboard players operation #move.dz bs.data -= #move.nz bs.data
execute store result score #move.sz bs.data run scoreboard players operation #move.rz bs.data -= #move.d bs.data
scoreboard players operation #move.rz bs.data *= -1 bs.const
scoreboard players operation #move.nz bs.data *= 10000000 bs.const
scoreboard players operation #move.rz bs.data += #move.nz bs.data
scoreboard players operation #move.nz bs.data = #move.d bs.data

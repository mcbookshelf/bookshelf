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

execute store result score #move.my bs.data run scoreboard players operation #move.ry bs.data *= -1 bs.const
execute store result score #r bs.ctx run scoreboard players operation #move.ry bs.data %= -10000000 bs.const
execute store result storage bs:data move.ry int -.0000000999999999999999 run scoreboard players operation #r bs.ctx -= #move.h bs.data
execute store result score #r bs.ctx run data get storage bs:data move.ry 10000000
scoreboard players operation #move.ry bs.data += #r bs.ctx

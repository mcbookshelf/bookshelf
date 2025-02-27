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

scoreboard players operation #move.rx bs.data *= -1 bs.const
scoreboard players operation #move.mx bs.data -= #move.rx bs.data
execute store result score #r bs.ctx run scoreboard players operation #move.rx bs.data %= -10000000 bs.const
scoreboard players operation #move.mx bs.data += #move.rx bs.data
scoreboard players operation #r bs.ctx += #move.w bs.data
execute store result storage bs:data move.rx int 1 run scoreboard players operation #r bs.ctx /= -10000000 bs.const
scoreboard players operation #r bs.ctx *= -10000000 bs.const
scoreboard players operation #move.rx bs.data -= #r bs.ctx
scoreboard players operation #move.mx bs.data -= #move.w bs.data
scoreboard players operation #move.mx bs.data /= -10000000 bs.const
scoreboard players operation #move.mx bs.data *= 10000000 bs.const

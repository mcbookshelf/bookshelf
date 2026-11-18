# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2026 Gunivers
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

setblock -30000000 0 1606 minecraft:air
forceload remove -30000000 1600

scoreboard objectives remove bs.ctx
scoreboard objectives remove bs.const

data remove storage bs.random:choice _i
data remove storage bs.random:weighted_choice _table
data remove storage bs.random:weighted_choice _options
data remove storage bs.random:weighted_choice _weights
data remove storage bs.random:weighted_choice _pick

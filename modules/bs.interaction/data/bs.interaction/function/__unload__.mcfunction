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

kill B5-0-0-0-2
forceload remove -30000000 1600

execute as @e[type=minecraft:interaction] run function #bs.interaction:clear_events {with:{}}

scoreboard objectives remove bs.interaction.id
scoreboard objectives remove bs.interaction.hover
scoreboard objectives remove bs.interaction.logout

scoreboard objectives remove bs.ctx
scoreboard objectives remove bs.data
scoreboard objectives remove bs.const

data remove storage bs:data interaction

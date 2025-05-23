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

execute store result score #i bs.ctx run scoreboard players get @s bs.interaction.logout
execute store result score #h bs.ctx run scoreboard players get @s bs.interaction.hover
execute at @s store result score #p bs.ctx if entity @a[distance=..24,predicate=bs.interaction:hover_equal]
scoreboard players operation #i bs.ctx -= #p bs.ctx
execute if score #i bs.ctx matches 1.. run function bs.interaction:on_event/hover_leave/as_target

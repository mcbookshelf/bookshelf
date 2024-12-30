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

scoreboard players operation #interaction.unhandled_hover bs.data = #interaction.active_hover bs.data
execute as @a at @s run function bs.interaction:on_event/player_process
execute if score #interaction.unhandled_hover bs.data matches 1.. \
  as @n[type=minecraft:interaction,scores={bs.interaction.hover=1..},limit=2147483647] \
  run function bs.interaction:on_event/hover_leave/try_leave

execute if score #interaction.process bs.data matches 1 run schedule function bs.interaction:on_event/process 1t

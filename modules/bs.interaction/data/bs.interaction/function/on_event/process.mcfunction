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

scoreboard players operation #interaction.await_hover bs.data = #interaction.hovered bs.data
execute as @a[scores={bs.interaction.logout=1..}] run function bs.interaction:on_event/hover/reset
execute as @a at @s run function bs.interaction:on_event/process_hover

execute if score #interaction.await_hover bs.data matches 1.. \
  as @e[type=minecraft:interaction,tag=bs.interaction.hovered] \
  run function bs.interaction:on_event/hover_leave/try_leave

execute if entity @n[type=minecraft:interaction,tag=bs.interaction.is_hoverable,sort=arbitrary] run schedule function bs.interaction:on_event/process 1t

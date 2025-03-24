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

execute store result storage bs:ctx y double .000001 run attribute @s minecraft:entity_interaction_range get 1000000
execute unless score @s bs.interaction.hover matches ..2147483647 run return run function bs.interaction:on_event/hover_enter/try_enter with storage bs:ctx
execute if score @s bs.interaction.hover matches ..2147483647 run function bs.interaction:on_event/hover/hover with storage bs:ctx
scoreboard players remove #interaction.await_hover bs.data 1

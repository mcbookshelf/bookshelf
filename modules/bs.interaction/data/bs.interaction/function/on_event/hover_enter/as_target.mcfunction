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

scoreboard players add @s bs.interaction.hover 1
scoreboard players add #interaction.active_hover bs.data 1
execute store result storage bs:ctx y int 1 run scoreboard players operation @p[distance=0,tag=bs.interaction.source] bs.interaction.id = @s bs.interaction.id
execute if entity @s[tag=bs.interaction.listen_hover_enter] run function bs.interaction:on_event/hover_enter/dispatch with storage bs:ctx
execute if entity @s[tag=bs.interaction.listen_hover] run function bs.interaction:on_event/hover/dispatch with storage bs:ctx
tag @s remove bs.interaction.target

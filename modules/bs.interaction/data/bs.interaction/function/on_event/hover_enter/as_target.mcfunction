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

scoreboard players add @s bs.interaction.logout 1
scoreboard players add #interaction.hovered bs.data 1
scoreboard players operation @p[distance=0,tag=bs.interaction.source] bs.interaction.hover = @s bs.interaction.hover

execute if entity @s[tag=bs.interaction.listen_hover_enter] run function bs.interaction:on_event/hover_enter/run
tag @s add bs.interaction.hovered
execute if entity @s[tag=bs.interaction.listen_hover] run function bs.interaction:on_event/hover/run
tag @s remove bs.interaction.target

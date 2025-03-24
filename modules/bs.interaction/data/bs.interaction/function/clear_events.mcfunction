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

$execute store result score #i bs.ctx run data remove entity @s data."bs.interaction".events[$(with)]
data modify storage bs:ctx _ set from entity @s data."bs.interaction".events

execute unless data storage bs:ctx _[{type:"hover"}] run tag @s remove bs.interaction.listen_hover
execute unless data storage bs:ctx _[{type:"hover_enter"}] run tag @s remove bs.interaction.listen_hover_enter
execute unless data storage bs:ctx _[{type:"hover_leave"}] run tag @s remove bs.interaction.listen_hover_leave
execute unless data storage bs:ctx _[{type:"left_click"}] run tag @s remove bs.interaction.listen_left_click
execute unless data storage bs:ctx _[{type:"right_click"}] run tag @s remove bs.interaction.listen_right_click

execute unless entity @s[tag=bs.interaction.listen_hover] \
  unless entity @s[tag=bs.interaction.listen_hover_enter] \
  unless entity @s[tag=bs.interaction.listen_hover_leave] \
  run tag @s remove bs.interaction.is_hoverable

scoreboard players reset @s[tag=!bs.interaction.is_hoverable] bs.interaction.hover

return run scoreboard players get #i bs.ctx

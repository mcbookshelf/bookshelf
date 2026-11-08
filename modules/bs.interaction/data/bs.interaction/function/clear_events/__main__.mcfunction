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

data modify storage bs.interaction: clear set from storage bs.interaction:clear_events in
data modify storage bs.interaction: clear.filter set value {}
data modify storage bs.interaction: clear.filter.id set from storage bs.interaction:clear_events in.id
execute if data storage bs.interaction: clear.type store result score #c bs.ctx run function bs.interaction:clear_events/type with storage bs.interaction: clear
execute unless data storage bs.interaction: clear.type run function bs.interaction:clear_events/all with storage bs.interaction: clear

execute unless data entity @s data."bs.interaction".hover[0] run tag @s remove bs.interaction.listen_hover
execute unless data entity @s data."bs.interaction".hover_enter[0] run tag @s remove bs.interaction.listen_hover_enter
execute unless data entity @s data."bs.interaction".hover_leave[0] run tag @s remove bs.interaction.listen_hover_leave
execute unless data entity @s data."bs.interaction".left_click[0] run tag @s remove bs.interaction.listen_left_click
execute unless data entity @s data."bs.interaction".right_click[0] run tag @s remove bs.interaction.listen_right_click

execute unless entity @s[tag=bs.interaction.listen_hover] \
  unless entity @s[tag=bs.interaction.listen_hover_enter] \
  unless entity @s[tag=bs.interaction.listen_hover_leave] \
  run tag @s remove bs.interaction.is_hoverable

scoreboard players reset @s[tag=!bs.interaction.is_hoverable] bs.interaction.hover

return run scoreboard players get #c bs.ctx

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
# @template ward:empty/9x9x9

summon minecraft:interaction ~4.5 ~1 ~5.5 {Tags:["ward.interaction.once"],width:1f,height:2f}
execute as @n[type=minecraft:interaction,tag=ward.interaction.once] run function #bs.interaction:on_hover_enter.in {run:"execute unless entity @s[tag=bs.interaction.hovered] run scoreboard players add #ward.interaction.once bs.data 1",executor:"target",with:{}}
execute as @n[type=minecraft:interaction,tag=ward.interaction.once] run function #bs.interaction:on_hover_leave.in {run:"execute unless entity @s[tag=bs.interaction.hovered] run scoreboard players remove #ward.interaction.once bs.data 1",executor:"target",with:{}}
scoreboard players set #ward.interaction.once bs.data 0

# The interaction is hovered until the last player looks away
execute positioned ~4.2 ~1 ~4.5 rotated 0 0 run dummy ward_once_1 spawn
await score #ward.interaction.once bs.data matches 1
execute positioned ~4.8 ~1 ~4.5 rotated 0 0 run dummy ward_once_2 spawn
await delay 2t
assert score #ward.interaction.once bs.data matches 1
dummy ward_once_2 leave
await delay 2t
assert score #ward.interaction.once bs.data matches 1
assert entity @n[type=minecraft:interaction,tag=ward.interaction.once,tag=bs.interaction.hovered]
dummy ward_once_1 leave
await score #ward.interaction.once bs.data matches 0
assert not entity @n[type=minecraft:interaction,tag=ward.interaction.once,tag=bs.interaction.hovered]

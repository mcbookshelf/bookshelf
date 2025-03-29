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

## === SETUP ===

fill ~-1 ~-1 ~-1 ~1 ~1 ~1 minecraft:air replace minecraft:barrier
summon minecraft:interaction ~.5 ~ ~1.5 {Tags: ["bs.packtest","bs.packtest.1"], width: 1.0, height: 2.0}
execute as @n[type=minecraft:interaction,tag=bs.packtest,distance=..3] run function #bs.interaction:on_hover_enter { run: "execute unless entity @s[tag=bs.interaction.hovered] run scoreboard players add #packtest.interaction_hover_once bs.data 1", executor: "target" }
execute as @n[type=minecraft:interaction,tag=bs.packtest,distance=..3] run function #bs.interaction:on_hover_leave { run: "execute unless entity @s[tag=bs.interaction.hovered] run scoreboard players remove #packtest.interaction_hover_once bs.data 1", executor: "target" }
scoreboard players set #packtest.interaction_hover_once bs.data 0

## === EXPECTED BEHAVIORS ===

execute positioned ~.5 ~ ~.5 run dummy on_hover_once_1 spawn
await score #packtest.interaction_hover_once bs.data matches 1
execute positioned ~.5 ~ ~.5 run dummy on_hover_once_2 spawn
await score #packtest.interaction_hover_once bs.data matches 1
dummy on_hover_once_2 leave
await score #packtest.interaction_hover_once bs.data matches 1
dummy on_hover_once_1 leave
await score #packtest.interaction_hover_once bs.data matches 0

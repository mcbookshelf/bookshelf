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
# @dummy

## === SETUP ===

fill ~-1 ~-1 ~-1 ~1 ~1 ~1 minecraft:air replace minecraft:barrier
summon minecraft:interaction ~.5 ~ ~1.5 {Tags: ["bs.ward"], width: 1.0, height: 2.0}
execute as @n[type=minecraft:interaction,tag=bs.ward,distance=..2] run function #bs.interaction:on_hover_enter { run: "scoreboard players add #ward.interaction_hover_count bs.data 1", executor: "target" }
execute as @n[type=minecraft:interaction,tag=bs.ward,distance=..2] run function #bs.interaction:on_hover_leave { run: "scoreboard players remove #ward.interaction_hover_count bs.data 1", executor: "target" }
scoreboard players set #ward.interaction_hover_count bs.data 0

## === EXPECTED BEHAVIORS ===

execute positioned ~.5 ~ ~.5 run dummy on_hover_logout spawn
await score #ward.interaction_hover_count bs.data matches 2
dummy on_hover_logout leave
await score #ward.interaction_hover_count bs.data matches 1

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
summon minecraft:interaction ~ ~ ~1.5 {Tags: ["bs.ward","bs.ward.1"], width: 1.0, height: 2.0}
summon minecraft:interaction ~1 ~ ~1.5 {Tags: ["bs.ward","bs.ward.2"], width: 1.0, height: 2.0}
execute as @n[type=minecraft:interaction,tag=bs.ward,distance=..3,limit=2] run function #bs.interaction:on_hover_enter { run: "tag @s add bs.ward.target", executor: "target" }
execute as @n[type=minecraft:interaction,tag=bs.ward,distance=..3,limit=2] run function #bs.interaction:on_hover_leave { run: "tag @s remove bs.ward.target", executor: "target" }

## === EXPECTED BEHAVIORS ===

tp @s ~.5 ~ ~.5 45 0
await entity @n[type=minecraft:interaction,tag=bs.ward.1,tag=bs.ward.target,distance=..2]
tp @s ~.5 ~ ~.5 -45 0
await entity @n[type=minecraft:interaction,tag=bs.ward.2,tag=bs.ward.target,distance=..2]
await not entity @n[type=minecraft:interaction,tag=bs.ward.1,tag=bs.ward.target,distance=..2]

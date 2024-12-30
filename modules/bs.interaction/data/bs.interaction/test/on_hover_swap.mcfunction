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
# @dummy

## === SETUP ===

fill ~-1 ~-1 ~-1 ~1 ~1 ~1 minecraft:air replace minecraft:barrier
summon minecraft:interaction ~ ~ ~1.5 {Tags: ["bs.packtest","bs.packtest.1"], width: 1.0, height: 2.0}
summon minecraft:interaction ~1 ~ ~1.5 {Tags: ["bs.packtest","bs.packtest.2"], width: 1.0, height: 2.0}
execute as @n[type=minecraft:interaction,tag=bs.packtest,distance=..3,limit=2] run function #bs.interaction:on_hover_enter { run: "tag @s add bs.packtest.target", executor: "target" }
execute as @n[type=minecraft:interaction,tag=bs.packtest,distance=..3,limit=2] run function #bs.interaction:on_hover_leave { run: "tag @s remove bs.packtest.target", executor: "target" }

## === EXPECTED BEHAVIORS ===

tp @s ~.5 ~ ~.5 45 0
await delay 2t
execute unless entity @n[type=minecraft:interaction,tag=bs.packtest.1,tag=bs.packtest.target,distance=..2] run fail "Failed to run callback on target entity"
tp @s ~.5 ~ ~.5 -45 0
await delay 2t
execute if entity @n[type=minecraft:interaction,tag=bs.packtest.1,tag=bs.packtest.target,distance=..2] run fail "Failed to swap hover to an other target entity"
execute unless entity @n[type=minecraft:interaction,tag=bs.packtest.2,tag=bs.packtest.target,distance=..2] run fail "Failed to swap hover to an other target entity"

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
summon minecraft:interaction ~.5 ~ ~1.5 {Tags: ["bs.packtest","bs.packtest.executor"], width: 1.0, height: 2.0}
summon minecraft:interaction ~1.5 ~ ~.5 {Tags: ["bs.packtest","bs.packtest.trap"], width: 1.0, height: 2.0}
summon minecraft:interaction ~-.5 ~ ~.5 {Tags: ["bs.packtest","bs.packtest.trap"], width: 1.0, height: 2.0}
execute as @n[type=minecraft:interaction,tag=bs.packtest,distance=..2,limit=4] run function #bs.interaction:on_hover_leave { run: "tag @s add bs.packtest.source", executor: "source" }
execute as @n[type=minecraft:interaction,tag=bs.packtest,distance=..2,limit=4] run function #bs.interaction:on_hover_leave { run: "tag @s add bs.packtest.target", executor: "target" }
execute as @n[type=minecraft:interaction,tag=bs.packtest,distance=..2,limit=4] run function #bs.interaction:on_hover_leave { run: "tag @s add bs.packtest.interpreted", executor: { selector: "@n[tag=bs.packtest.executor,distance=..2]", lazy: false } }
execute as @n[type=minecraft:interaction,tag=bs.packtest,distance=..2,limit=4] run function #bs.interaction:on_hover_leave { run: "tag @s add bs.packtest.lazy", executor: { selector: "@n[tag=bs.packtest.executor,distance=..2]", lazy: true } }

## === EXPECTED BEHAVIORS ===

await delay 1t
execute if entity @s[tag=bs.packtest.source] run fail "Callback should not run before the interaction is unhovered"
tp @s ~.5 ~ ~.5 180 0
await delay 1t
execute unless entity @s[tag=bs.packtest.source] run fail "Failed to run callback on source entity"
execute unless entity @n[type=minecraft:interaction,tag=bs.packtest,tag=!bs.packtest.trap,tag=bs.packtest.target,distance=..2] run fail "Failed to run callback on target entity"
execute unless entity @n[type=minecraft:interaction,tag=bs.packtest,tag=!bs.packtest.trap,tag=bs.packtest.interpreted,distance=..2] run fail "Failed to run callback using an interpreted selector"
execute unless entity @n[type=minecraft:interaction,tag=bs.packtest,tag=!bs.packtest.trap,tag=bs.packtest.lazy,distance=..2] run fail "Failed to run callback using a lazy selector"
execute if entity @n[type=minecraft:interaction,tag=bs.packtest.trap,tag=bs.packtest.target,distance=..2] run fail "Failed to run callback on the right interaction"

tag @s remove bs.packtest.source
tag @e[distance=..2] remove bs.packtest.target
tag @e[distance=..2] remove bs.packtest.interpreted
tag @e[distance=..2] remove bs.packtest.lazy
await delay 1t

execute if entity @s[tag=bs.packtest.source] run fail "Callback should run only once on leave"
execute if entity @n[type=minecraft:interaction,tag=bs.packtest,tag=!bs.packtest.trap,tag=bs.packtest.target,distance=..2] run fail "Callback should run only once on leave"
execute if entity @n[type=minecraft:interaction,tag=bs.packtest,tag=!bs.packtest.trap,tag=bs.packtest.interpreted,distance=..2] run fail "Callback should run only once on leave"
execute if entity @n[type=minecraft:interaction,tag=bs.packtest,tag=!bs.packtest.trap,tag=bs.packtest.lazy,distance=..2] run fail "Callback should run only once on leave"

tag @e[distance=..2] remove bs.packtest.executor
tag @s add bs.packtest.executor

tp @s ~.5 ~ ~.5 0 0
await delay 1t
tp @s ~.5 ~ ~.5 180 0
await delay 1t
execute unless entity @s[tag=bs.packtest.source] run fail "Failed to run callback on source entity"
execute unless entity @n[type=minecraft:interaction,tag=bs.packtest,tag=!bs.packtest.trap,tag=bs.packtest.target,distance=..2] run fail "Failed to run callback on target entity"
execute unless entity @n[type=minecraft:interaction,tag=bs.packtest,tag=!bs.packtest.trap,tag=bs.packtest.interpreted,distance=..2] run fail "Failed to run callback using an interpreted selector"
execute if entity @n[type=minecraft:interaction,tag=bs.packtest,tag=!bs.packtest.trap,tag=bs.packtest.lazy,distance=..2] run fail "Failed to run callback using a lazy selector"
execute unless entity @s[tag=bs.packtest.lazy] run fail "Failed to run callback using a lazy selector"

## === INPUT ERRORS ===

execute store result score #s bs.ctx run function #bs.interaction:on_hover_leave { run: "", executor: "source" }
execute unless score #s bs.ctx matches 0 run fail "Failed to return an error when function is called on a non interaction entity"
execute as @n[type=minecraft:interaction,tag=bs.packtest,distance=..2] store result score #s bs.ctx run function #bs.interaction:on_hover_leave { run: "", executor: "target" }
execute unless score #s bs.ctx matches 0 run fail "Failed to return an error when the command is invalid"
execute as @n[type=minecraft:interaction,tag=bs.packtest,distance=..2] store result score #s bs.ctx run function #bs.interaction:on_hover_leave { run: "help", executor: { selector: "¯\\_(ツ)_/¯" } }
execute unless score #s bs.ctx matches 0 run fail "Failed to return an error when the selector is invalid"
execute as @n[type=minecraft:interaction,tag=bs.packtest,distance=..2] store result score #s bs.ctx run function #bs.interaction:on_hover_leave { run: "help", executor: { selector: "@n[type=minecraft:allay,tag=bs.is_never_gonna_be_released]", lazy: false } }
execute unless score #s bs.ctx matches 0 run fail "Failed to return an error when the selector is interpreted and points to no entity"

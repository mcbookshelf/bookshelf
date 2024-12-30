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

summon minecraft:interaction ~.5 ~ ~.5 {Tags: ["bs.packtest","bs.packtest.executor"], width: 1.0, height: 2.0}
execute as @n[type=minecraft:interaction,tag=bs.packtest,distance=..2] run function #bs.interaction:on_left_click { run: "tag @s add bs.packtest.source", executor: "source" }
execute as @n[type=minecraft:interaction,tag=bs.packtest,distance=..2] run function #bs.interaction:on_left_click { run: "tag @s add bs.packtest.target", executor: "target" }
execute as @n[type=minecraft:interaction,tag=bs.packtest,distance=..2] run function #bs.interaction:on_left_click { run: "tag @s add bs.packtest.interpreted", executor: { selector: "@n[tag=bs.packtest.executor,distance=..2]", lazy: false } }
execute as @n[type=minecraft:interaction,tag=bs.packtest,distance=..2] run function #bs.interaction:on_left_click { run: "tag @s add bs.packtest.lazy", executor: { selector: "@n[tag=bs.packtest.executor,distance=..2]", lazy: true } }

## === EXPECTED BEHAVIORS ===

dummy @s attack @n[type=minecraft:interaction,tag=bs.packtest,distance=..2]
execute unless entity @s[tag=bs.packtest.source] run fail "Failed to run callback on source entity"
execute unless entity @n[type=minecraft:interaction,tag=bs.packtest,tag=bs.packtest.target,distance=..2] run fail "Failed to run callback on target entity"
execute unless entity @n[type=minecraft:interaction,tag=bs.packtest,tag=bs.packtest.interpreted,distance=..2] run fail "Failed to run callback using an interpreted selector"
execute unless entity @n[type=minecraft:interaction,tag=bs.packtest,tag=bs.packtest.lazy,distance=..2] run fail "Failed to run callback using a lazy selector"

tag @e[distance=..2] remove bs.packtest.lazy
tag @e[distance=..2] remove bs.packtest.interpreted
tag @e[distance=..2] remove bs.packtest.executor
tag @s add bs.packtest.executor
dummy @s attack @n[type=minecraft:interaction,tag=bs.packtest,distance=..2]
execute unless entity @n[type=minecraft:interaction,tag=bs.packtest,tag=bs.packtest.interpreted,distance=..2] run fail "Failed to run callback using an interpreted selector"
execute if entity @n[type=minecraft:interaction,tag=bs.packtest,tag=bs.packtest.lazy,distance=..2] run fail "Failed to run callback using a lazy selector"
execute unless entity @s[tag=bs.packtest.lazy] run fail "Failed to run callback using a lazy selector"

## === INPUT ERRORS ===

execute store result score #s bs.ctx run function #bs.interaction:on_left_click { run: "", executor: "source" }
execute unless score #s bs.ctx matches 0 run fail "Failed to return an error when function is called on a non interaction entity"
execute as @n[type=minecraft:interaction,tag=bs.packtest,distance=..2] store result score #s bs.ctx run function #bs.interaction:on_left_click { run: "", executor: "target" }
execute unless score #s bs.ctx matches 0 run fail "Failed to return an error when the command is invalid"
execute as @n[type=minecraft:interaction,tag=bs.packtest,distance=..2] store result score #s bs.ctx run function #bs.interaction:on_left_click { run: "help", executor: { selector: "¯\\_(ツ)_/¯" } }
execute unless score #s bs.ctx matches 0 run fail "Failed to return an error when the selector is invalid"
execute as @n[type=minecraft:interaction,tag=bs.packtest,distance=..2] store result score #s bs.ctx run function #bs.interaction:on_left_click { run: "help", executor: { selector: "@n[type=minecraft:allay,tag=bs.is_never_gonna_be_released]", lazy: false } }
execute unless score #s bs.ctx matches 0 run fail "Failed to return an error when the selector is interpreted and points to no entity"

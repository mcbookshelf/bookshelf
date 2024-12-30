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

## === SETUP ===

summon minecraft:interaction ~.5 ~ ~.5 {Tags: ["bs.packtest","bs.packtest.executor"], width: 1.0, height: 2.0}
execute as @n[type=minecraft:interaction,tag=bs.packtest,distance=..2] run function #bs.interaction:on_left_click { run: "help", executor: "target" }
execute as @n[type=minecraft:interaction,tag=bs.packtest,distance=..2] run function #bs.interaction:on_left_click { run: "help", executor: "target" }
execute as @n[type=minecraft:interaction,tag=bs.packtest,distance=..2] run function #bs.interaction:on_right_click { run: "help", executor: "target" }
execute as @n[type=minecraft:interaction,tag=bs.packtest,distance=..2] run function #bs.interaction:on_right_click { run: "help", executor: "target" }
execute as @n[type=minecraft:interaction,tag=bs.packtest,distance=..2] run function #bs.interaction:on_hover_enter { run: "help", executor: "target" }
execute as @n[type=minecraft:interaction,tag=bs.packtest,distance=..2] run function #bs.interaction:on_hover_enter { run: "help", executor: "target" }
execute as @n[type=minecraft:interaction,tag=bs.packtest,distance=..2] run function #bs.interaction:on_hover_leave { run: "help", executor: "target" }
execute as @n[type=minecraft:interaction,tag=bs.packtest,distance=..2] run function #bs.interaction:on_hover_leave { run: "help", executor: "target" }
execute as @n[type=minecraft:interaction,tag=bs.packtest,distance=..2] run function #bs.interaction:on_hover { run: "help", executor: "target" }
execute as @n[type=minecraft:interaction,tag=bs.packtest,distance=..2] run function #bs.interaction:on_hover { run: "help", executor: "target" }
data modify storage bs:data packtest set value {with:{}}

## === EXPECTED BEHAVIORS (CLEAR LEFT CLICK) ===

execute as @n[type=minecraft:interaction,tag=bs.packtest,distance=..2] store result storage bs:data packtest.with.id int 1 run function #bs.interaction:on_left_click { run: "help", executor: "target" }
execute as @n[type=minecraft:interaction,tag=bs.packtest,distance=..2] store result score #i bs.ctx run function #bs.interaction:clear_events with storage bs:data packtest
execute unless score #i bs.ctx matches 1 run fail "Clear events should clear a single event when using the id"
execute as @n[type=minecraft:interaction,tag=bs.packtest,distance=..2] store result score #i bs.ctx run function #bs.interaction:clear_events { with: { type: "left_click" } }
execute unless score #i bs.ctx matches 2 run fail "Clear events should clear all events when using the type"
execute as @n[type=minecraft:interaction,tag=bs.packtest,distance=..2] if entity @s[tag=bs.interaction.listen_left_click] run fail "Interaction should stop listening to left_click events when they are cleared"

## === EXPECTED BEHAVIORS (CLEAR RIGHT CLICK) ===

execute as @n[type=minecraft:interaction,tag=bs.packtest,distance=..2] store result storage bs:data packtest.with.id int 1 run function #bs.interaction:on_right_click { run: "help", executor: "target" }
execute as @n[type=minecraft:interaction,tag=bs.packtest,distance=..2] store result score #i bs.ctx run function #bs.interaction:clear_events with storage bs:data packtest
execute unless score #i bs.ctx matches 1 run fail "Clear events should clear a single event when using the id"
execute as @n[type=minecraft:interaction,tag=bs.packtest,distance=..2] store result score #i bs.ctx run function #bs.interaction:clear_events { with: { type: "right_click" } }
execute unless score #i bs.ctx matches 2 run fail "Clear events should clear all events when using the type"
execute as @n[type=minecraft:interaction,tag=bs.packtest,distance=..2] if entity @s[tag=bs.interaction.listen_right_click] run fail "Interaction should stop listening to right_click events when they are cleared"

## === EXPECTED BEHAVIORS (CLEAR HOVER ENTER) ===

execute as @n[type=minecraft:interaction,tag=bs.packtest,distance=..2] store result storage bs:data packtest.with.id int 1 run function #bs.interaction:on_hover_enter { run: "help", executor: "target" }
execute as @n[type=minecraft:interaction,tag=bs.packtest,distance=..2] store result score #i bs.ctx run function #bs.interaction:clear_events with storage bs:data packtest
execute unless score #i bs.ctx matches 1 run fail "Clear events should clear a single event when using the id"
execute as @n[type=minecraft:interaction,tag=bs.packtest,distance=..2] store result score #i bs.ctx run function #bs.interaction:clear_events { with: { type: "hover_enter" } }
execute unless score #i bs.ctx matches 2 run fail "Clear events should clear all events when using the type"
execute as @n[type=minecraft:interaction,tag=bs.packtest,distance=..2] if entity @s[tag=bs.interaction.listen_hover_enter] run fail "Interaction should stop listening to hover_enter events when they are cleared"

## === EXPECTED BEHAVIORS (CLEAR HOVER LEAVE) ===

execute as @n[type=minecraft:interaction,tag=bs.packtest,distance=..2] store result storage bs:data packtest.with.id int 1 run function #bs.interaction:on_hover_leave { run: "help", executor: "target" }
execute as @n[type=minecraft:interaction,tag=bs.packtest,distance=..2] store result score #i bs.ctx run function #bs.interaction:clear_events with storage bs:data packtest
execute unless score #i bs.ctx matches 1 run fail "Clear events should clear a single event when using the id"
execute as @n[type=minecraft:interaction,tag=bs.packtest,distance=..2] store result score #i bs.ctx run function #bs.interaction:clear_events { with: { type: "hover_leave" } }
execute unless score #i bs.ctx matches 2 run fail "Clear events should clear all events when using the type"
execute as @n[type=minecraft:interaction,tag=bs.packtest,distance=..2] if entity @s[tag=bs.interaction.listen_hover_leave] run fail "Interaction should stop listening to hover_leave events when they are cleared"

## === EXPECTED BEHAVIORS (CLEAR HOVER) ===

execute as @n[type=minecraft:interaction,tag=bs.packtest,distance=..2] store result storage bs:data packtest.with.id int 1 run function #bs.interaction:on_hover { run: "help", executor: "target" }
execute as @n[type=minecraft:interaction,tag=bs.packtest,distance=..2] store result score #i bs.ctx run function #bs.interaction:clear_events with storage bs:data packtest
execute unless score #i bs.ctx matches 1 run fail "Clear events should clear a single event when using the id"
execute as @n[type=minecraft:interaction,tag=bs.packtest,distance=..2] store result score #i bs.ctx run function #bs.interaction:clear_events { with: { type: "hover" } }
execute unless score #i bs.ctx matches 2 run fail "Clear events should clear all events when using the type"
execute as @n[type=minecraft:interaction,tag=bs.packtest,distance=..2] if entity @s[tag=bs.interaction.listen_hover] run fail "Interaction should stop listening to hover events when they are cleared"
execute as @n[type=minecraft:interaction,tag=bs.packtest,distance=..2] if entity @s[tag=bs.interaction.is_hoverable] run fail "Interaction should stop listening to all hover events when they are cleared"
execute as @n[type=minecraft:interaction,tag=bs.packtest,distance=..2] if score @s bs.interaction.id matches 1.. run fail "Clear events should reset the interaction id when all events are cleared"

## === EXPECTED BEHAVIORS (CLEAR ALL) ===

execute as @n[type=minecraft:interaction,tag=bs.packtest,distance=..2] run function #bs.interaction:on_left_click { run: "help", executor: "target" }
execute as @n[type=minecraft:interaction,tag=bs.packtest,distance=..2] run function #bs.interaction:on_right_click { run: "help", executor: "target" }
execute as @n[type=minecraft:interaction,tag=bs.packtest,distance=..2] run function #bs.interaction:on_hover_enter { run: "help", executor: "target" }
execute as @n[type=minecraft:interaction,tag=bs.packtest,distance=..2] run function #bs.interaction:on_hover_leave { run: "help", executor: "target" }
execute as @n[type=minecraft:interaction,tag=bs.packtest,distance=..2] run function #bs.interaction:on_hover { run: "help", executor: "target" }
execute as @n[type=minecraft:interaction,tag=bs.packtest,distance=..2] store result score #i bs.ctx run function #bs.interaction:clear_events { with: {} }
execute unless score #i bs.ctx matches 5 run fail "Clear events should clear all events when using an empty object"

## === EXPECTED BEHAVIORS (CLEAR NONE) ===

execute as @n[type=minecraft:interaction,tag=bs.packtest,distance=..2] store result score #i bs.ctx run function #bs.interaction:clear_events { with: {} }
execute unless score #i bs.ctx matches 0 run fail "Clear events should return 0 when no events are registered"

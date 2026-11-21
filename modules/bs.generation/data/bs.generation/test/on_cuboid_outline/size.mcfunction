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

# Only the outside of the cuboid is done: its inside is left alone
data modify storage bs.generation:on_cuboid_outline in set value {run:"setblock ~ ~ ~ minecraft:polished_andesite",size:[3,3,3]}
function #bs.generation:on_cuboid_outline/xyz
assert block ~ ~ ~ minecraft:polished_andesite
assert block ~2 ~2 ~2 minecraft:polished_andesite
assert block ~1 ~1 ~ minecraft:polished_andesite
assert block ~1 ~ ~1 minecraft:polished_andesite
assert block ~ ~1 ~1 minecraft:polished_andesite
assert block ~2 ~1 ~1 minecraft:polished_andesite
assert block ~1 ~2 ~1 minecraft:polished_andesite
assert block ~1 ~1 ~2 minecraft:polished_andesite
assert not block ~1 ~1 ~1 minecraft:polished_andesite
assert not block ~3 ~ ~ minecraft:polished_andesite

# Each position of the outside is done once, whatever the size
scoreboard players set #ward.generation.outline bs.data 0
data modify storage bs.generation:on_cuboid_outline in set value {run:"scoreboard players add #ward.generation.outline bs.data 1",size:[5,4,3]}
function #bs.generation:on_cuboid_outline/xyz
assert score #ward.generation.outline bs.data matches 54
scoreboard players set #ward.generation.outline bs.data 0
data modify storage bs.generation:on_cuboid_outline in set value {run:"scoreboard players add #ward.generation.outline bs.data 1",size:[4,4,4]}
function #bs.generation:on_cuboid_outline/xyz
assert score #ward.generation.outline bs.data matches 56
scoreboard players set #ward.generation.outline bs.data 0
data modify storage bs.generation:on_cuboid_outline in set value {run:"scoreboard players add #ward.generation.outline bs.data 1",size:[2,2,2]}
function #bs.generation:on_cuboid_outline/xyz
assert score #ward.generation.outline bs.data matches 8
scoreboard players set #ward.generation.outline bs.data 0
data modify storage bs.generation:on_cuboid_outline in set value {run:"scoreboard players add #ward.generation.outline bs.data 1",size:[1,1,1]}
function #bs.generation:on_cuboid_outline/xyz
assert score #ward.generation.outline bs.data matches 1
scoreboard players set #ward.generation.outline bs.data 0
data modify storage bs.generation:on_cuboid_outline in set value {run:"scoreboard players add #ward.generation.outline bs.data 1",size:[5,1,1]}
function #bs.generation:on_cuboid_outline/xyz
assert score #ward.generation.outline bs.data matches 5
scoreboard players set #ward.generation.outline bs.data 0
data modify storage bs.generation:on_cuboid_outline in set value {run:"scoreboard players add #ward.generation.outline bs.data 1",size:[1,5,5]}
function #bs.generation:on_cuboid_outline/xyz
assert score #ward.generation.outline bs.data matches 25
scoreboard players set #ward.generation.outline bs.data 0
data modify storage bs.generation:on_cuboid_outline in set value {run:"scoreboard players add #ward.generation.outline bs.data 1",size:[5,5,1]}
function #bs.generation:on_cuboid_outline/xyz
assert score #ward.generation.outline bs.data matches 25
scoreboard players set #ward.generation.outline bs.data 0
data modify storage bs.generation:on_cuboid_outline in set value {run:"scoreboard players add #ward.generation.outline bs.data 1",size:[2,5,5]}
function #bs.generation:on_cuboid_outline/xyz
assert score #ward.generation.outline bs.data matches 50

# The size is missing: a single position
scoreboard players set #ward.generation.outline bs.data 0
data modify storage bs.generation:on_cuboid_outline in set value {run:"scoreboard players add #ward.generation.outline bs.data 1"}
function #bs.generation:on_cuboid_outline/xyz
assert score #ward.generation.outline bs.data matches 1

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

# Only the positions inside the ellipse are done
data modify storage bs.generation:on_ellipse in set value {run:"setblock ~ ~ ~ minecraft:calcite",size:[5,5]}
function #bs.generation:on_ellipse/xz
assert not block ~ ~ ~ minecraft:calcite
assert block ~ ~ ~1 minecraft:calcite
assert block ~ ~ ~2 minecraft:calcite
assert block ~ ~ ~3 minecraft:calcite
assert not block ~ ~ ~4 minecraft:calcite
assert block ~1 ~ ~ minecraft:calcite
assert block ~1 ~ ~1 minecraft:calcite
assert block ~1 ~ ~2 minecraft:calcite
assert block ~1 ~ ~3 minecraft:calcite
assert block ~1 ~ ~4 minecraft:calcite
assert block ~2 ~ ~ minecraft:calcite
assert block ~2 ~ ~1 minecraft:calcite
assert block ~2 ~ ~2 minecraft:calcite
assert block ~2 ~ ~3 minecraft:calcite
assert block ~2 ~ ~4 minecraft:calcite
assert block ~3 ~ ~ minecraft:calcite
assert block ~3 ~ ~1 minecraft:calcite
assert block ~3 ~ ~2 minecraft:calcite
assert block ~3 ~ ~3 minecraft:calcite
assert block ~3 ~ ~4 minecraft:calcite
assert not block ~4 ~ ~ minecraft:calcite
assert block ~4 ~ ~1 minecraft:calcite
assert block ~4 ~ ~2 minecraft:calcite
assert block ~4 ~ ~3 minecraft:calcite
assert not block ~4 ~ ~4 minecraft:calcite

# The size follows the order of the function name
data modify storage bs.generation:on_ellipse in set value {run:"setblock ~ ~ ~ minecraft:emerald_block",size:[7,4]}
execute positioned ~ ~2 ~ run function #bs.generation:on_ellipse/zx
execute positioned ~ ~2 ~ run assert block ~2 ~ ~3 minecraft:emerald_block
execute positioned ~ ~2 ~ run assert block ~1 ~ ~ minecraft:emerald_block
execute positioned ~ ~2 ~ run assert block ~1 ~ ~6 minecraft:emerald_block
execute positioned ~ ~2 ~ run assert not block ~ ~ ~ minecraft:emerald_block
execute positioned ~ ~2 ~ run assert not block ~3 ~ ~6 minecraft:emerald_block
execute positioned ~ ~2 ~ run assert not block ~4 ~ ~3 minecraft:emerald_block

# Each position inside is done once, whatever the size
scoreboard players set #ward.generation.round bs.data 0
data modify storage bs.generation:on_ellipse in set value {run:"scoreboard players add #ward.generation.round bs.data 1",size:[1,1],batch:100000}
function #bs.generation:on_ellipse/xz
assert score #ward.generation.round bs.data matches 1
scoreboard players set #ward.generation.round bs.data 0
data modify storage bs.generation:on_ellipse in set value {run:"scoreboard players add #ward.generation.round bs.data 1",size:[2,2],batch:100000}
function #bs.generation:on_ellipse/xz
assert score #ward.generation.round bs.data matches 4
scoreboard players set #ward.generation.round bs.data 0
data modify storage bs.generation:on_ellipse in set value {run:"scoreboard players add #ward.generation.round bs.data 1",size:[3,3],batch:100000}
function #bs.generation:on_ellipse/xz
assert score #ward.generation.round bs.data matches 9
scoreboard players set #ward.generation.round bs.data 0
data modify storage bs.generation:on_ellipse in set value {run:"scoreboard players add #ward.generation.round bs.data 1",size:[4,4],batch:100000}
function #bs.generation:on_ellipse/xz
assert score #ward.generation.round bs.data matches 12
scoreboard players set #ward.generation.round bs.data 0
data modify storage bs.generation:on_ellipse in set value {run:"scoreboard players add #ward.generation.round bs.data 1",size:[5,5],batch:100000}
function #bs.generation:on_ellipse/xz
assert score #ward.generation.round bs.data matches 21
scoreboard players set #ward.generation.round bs.data 0
data modify storage bs.generation:on_ellipse in set value {run:"scoreboard players add #ward.generation.round bs.data 1",size:[8,8],batch:100000}
function #bs.generation:on_ellipse/xz
assert score #ward.generation.round bs.data matches 52
scoreboard players set #ward.generation.round bs.data 0
data modify storage bs.generation:on_ellipse in set value {run:"scoreboard players add #ward.generation.round bs.data 1",size:[9,9],batch:100000}
function #bs.generation:on_ellipse/xz
assert score #ward.generation.round bs.data matches 69
scoreboard players set #ward.generation.round bs.data 0
data modify storage bs.generation:on_ellipse in set value {run:"scoreboard players add #ward.generation.round bs.data 1",size:[16,16],batch:100000}
function #bs.generation:on_ellipse/xz
assert score #ward.generation.round bs.data matches 208
scoreboard players set #ward.generation.round bs.data 0
data modify storage bs.generation:on_ellipse in set value {run:"scoreboard players add #ward.generation.round bs.data 1",size:[12,5],batch:100000}
function #bs.generation:on_ellipse/xz
assert score #ward.generation.round bs.data matches 48
scoreboard players set #ward.generation.round bs.data 0
data modify storage bs.generation:on_ellipse in set value {run:"scoreboard players add #ward.generation.round bs.data 1",size:[3,11],batch:100000}
function #bs.generation:on_ellipse/xz
assert score #ward.generation.round bs.data matches 29
scoreboard players set #ward.generation.round bs.data 0
data modify storage bs.generation:on_ellipse in set value {run:"scoreboard players add #ward.generation.round bs.data 1",size:[1,7],batch:100000}
function #bs.generation:on_ellipse/xz
assert score #ward.generation.round bs.data matches 7
scoreboard players set #ward.generation.round bs.data 0
data modify storage bs.generation:on_ellipse in set value {run:"scoreboard players add #ward.generation.round bs.data 1",size:[7,1],batch:100000}
function #bs.generation:on_ellipse/xz
assert score #ward.generation.round bs.data matches 7
scoreboard players set #ward.generation.round bs.data 0
data modify storage bs.generation:on_ellipse in set value {run:"scoreboard players add #ward.generation.round bs.data 1",size:[31,31],batch:100000}
function #bs.generation:on_ellipse/xz
assert score #ward.generation.round bs.data matches 749

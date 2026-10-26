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

# Every order does the same number of positions
scoreboard players set #ward.generation.round bs.data 0
data modify storage bs.generation:on_ellipse in set value {run:"scoreboard players add #ward.generation.round bs.data 1",size:[9,6],batch:100000}
function #bs.generation:on_ellipse/xy
assert score #ward.generation.round bs.data matches 42
scoreboard players set #ward.generation.round bs.data 0
data modify storage bs.generation:on_ellipse in set value {run:"scoreboard players add #ward.generation.round bs.data 1",size:[9,6],batch:100000}
function #bs.generation:on_ellipse/xz
assert score #ward.generation.round bs.data matches 42
scoreboard players set #ward.generation.round bs.data 0
data modify storage bs.generation:on_ellipse in set value {run:"scoreboard players add #ward.generation.round bs.data 1",size:[9,6],batch:100000}
function #bs.generation:on_ellipse/yx
assert score #ward.generation.round bs.data matches 42
scoreboard players set #ward.generation.round bs.data 0
data modify storage bs.generation:on_ellipse in set value {run:"scoreboard players add #ward.generation.round bs.data 1",size:[9,6],batch:100000}
function #bs.generation:on_ellipse/yz
assert score #ward.generation.round bs.data matches 42
scoreboard players set #ward.generation.round bs.data 0
data modify storage bs.generation:on_ellipse in set value {run:"scoreboard players add #ward.generation.round bs.data 1",size:[9,6],batch:100000}
function #bs.generation:on_ellipse/zx
assert score #ward.generation.round bs.data matches 42
scoreboard players set #ward.generation.round bs.data 0
data modify storage bs.generation:on_ellipse in set value {run:"scoreboard players add #ward.generation.round bs.data 1",size:[9,6],batch:100000}
function #bs.generation:on_ellipse/zy
assert score #ward.generation.round bs.data matches 42

# A negative size goes the other way
data modify storage bs.generation:on_ellipse in set value {run:"setblock ~ ~ ~ minecraft:diamond_block",size:[-5,5]}
execute positioned ~10 ~ ~ run function #bs.generation:on_ellipse/xy
assert block ~9 ~ ~ minecraft:diamond_block
assert block ~7 ~ ~ minecraft:diamond_block
assert block ~10 ~2 ~ minecraft:diamond_block
assert block ~8 ~2 ~ minecraft:diamond_block
assert block ~6 ~2 ~ minecraft:diamond_block
assert block ~8 ~4 ~ minecraft:diamond_block
assert not block ~10 ~ ~ minecraft:diamond_block
assert not block ~6 ~ ~ minecraft:diamond_block
assert not block ~6 ~4 ~ minecraft:diamond_block
assert not block ~11 ~2 ~ minecraft:diamond_block
assert not block ~5 ~2 ~ minecraft:diamond_block

# One position each tick: the lines that are cut by a tick go on where they stopped
scoreboard players set #ward.generation.round.slow bs.data 0
data modify storage bs.generation:on_ellipse in set value {run:"scoreboard players add #ward.generation.round.slow bs.data 1",size:[6,6],batch:1}
function #bs.generation:on_ellipse/zx
assert score #ward.generation.round.slow bs.data matches 1
await delay 60t
assert score #ward.generation.round.slow bs.data matches 32

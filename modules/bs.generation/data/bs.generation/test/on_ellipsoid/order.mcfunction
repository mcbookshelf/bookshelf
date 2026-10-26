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
data modify storage bs.generation:on_ellipsoid in set value {run:"scoreboard players add #ward.generation.round bs.data 1",size:[9,6,4],batch:100000}
function #bs.generation:on_ellipsoid/xyz
assert score #ward.generation.round bs.data matches 116
scoreboard players set #ward.generation.round bs.data 0
data modify storage bs.generation:on_ellipsoid in set value {run:"scoreboard players add #ward.generation.round bs.data 1",size:[9,6,4],batch:100000}
function #bs.generation:on_ellipsoid/xzy
assert score #ward.generation.round bs.data matches 116
scoreboard players set #ward.generation.round bs.data 0
data modify storage bs.generation:on_ellipsoid in set value {run:"scoreboard players add #ward.generation.round bs.data 1",size:[9,6,4],batch:100000}
function #bs.generation:on_ellipsoid/yxz
assert score #ward.generation.round bs.data matches 116
scoreboard players set #ward.generation.round bs.data 0
data modify storage bs.generation:on_ellipsoid in set value {run:"scoreboard players add #ward.generation.round bs.data 1",size:[9,6,4],batch:100000}
function #bs.generation:on_ellipsoid/yzx
assert score #ward.generation.round bs.data matches 116
scoreboard players set #ward.generation.round bs.data 0
data modify storage bs.generation:on_ellipsoid in set value {run:"scoreboard players add #ward.generation.round bs.data 1",size:[9,6,4],batch:100000}
function #bs.generation:on_ellipsoid/zxy
assert score #ward.generation.round bs.data matches 116
scoreboard players set #ward.generation.round bs.data 0
data modify storage bs.generation:on_ellipsoid in set value {run:"scoreboard players add #ward.generation.round bs.data 1",size:[9,6,4],batch:100000}
function #bs.generation:on_ellipsoid/zyx
assert score #ward.generation.round bs.data matches 116

# The size follows the order of the function name
data modify storage bs.generation:on_ellipsoid in set value {run:"setblock ~ ~ ~ minecraft:amethyst_block",size:[7,3,5]}
function #bs.generation:on_ellipsoid/zyx
assert not block ~ ~ ~ minecraft:amethyst_block
assert not block ~1 ~ ~ minecraft:amethyst_block
assert not block ~2 ~ ~ minecraft:amethyst_block
assert not block ~3 ~ ~ minecraft:amethyst_block
assert not block ~4 ~ ~ minecraft:amethyst_block
assert not block ~ ~1 ~ minecraft:amethyst_block
assert block ~1 ~1 ~ minecraft:amethyst_block
assert block ~2 ~1 ~ minecraft:amethyst_block
assert block ~3 ~1 ~ minecraft:amethyst_block
assert not block ~4 ~1 ~ minecraft:amethyst_block
assert not block ~ ~2 ~ minecraft:amethyst_block
assert not block ~1 ~2 ~ minecraft:amethyst_block
assert not block ~2 ~2 ~ minecraft:amethyst_block
assert not block ~3 ~2 ~ minecraft:amethyst_block
assert not block ~4 ~2 ~ minecraft:amethyst_block
assert not block ~ ~ ~1 minecraft:amethyst_block
assert block ~1 ~ ~1 minecraft:amethyst_block
assert block ~2 ~ ~1 minecraft:amethyst_block
assert block ~3 ~ ~1 minecraft:amethyst_block
assert not block ~4 ~ ~1 minecraft:amethyst_block
assert block ~ ~1 ~1 minecraft:amethyst_block
assert block ~1 ~1 ~1 minecraft:amethyst_block
assert block ~2 ~1 ~1 minecraft:amethyst_block
assert block ~3 ~1 ~1 minecraft:amethyst_block
assert block ~4 ~1 ~1 minecraft:amethyst_block
assert not block ~ ~2 ~1 minecraft:amethyst_block
assert block ~1 ~2 ~1 minecraft:amethyst_block
assert block ~2 ~2 ~1 minecraft:amethyst_block
assert block ~3 ~2 ~1 minecraft:amethyst_block
assert not block ~4 ~2 ~1 minecraft:amethyst_block
assert not block ~ ~ ~2 minecraft:amethyst_block
assert block ~1 ~ ~2 minecraft:amethyst_block
assert block ~2 ~ ~2 minecraft:amethyst_block
assert block ~3 ~ ~2 minecraft:amethyst_block
assert not block ~4 ~ ~2 minecraft:amethyst_block
assert block ~ ~1 ~2 minecraft:amethyst_block
assert block ~1 ~1 ~2 minecraft:amethyst_block
assert block ~2 ~1 ~2 minecraft:amethyst_block
assert block ~3 ~1 ~2 minecraft:amethyst_block
assert block ~4 ~1 ~2 minecraft:amethyst_block
assert not block ~ ~2 ~2 minecraft:amethyst_block
assert block ~1 ~2 ~2 minecraft:amethyst_block
assert block ~2 ~2 ~2 minecraft:amethyst_block
assert block ~3 ~2 ~2 minecraft:amethyst_block
assert not block ~4 ~2 ~2 minecraft:amethyst_block
assert not block ~ ~ ~3 minecraft:amethyst_block
assert block ~1 ~ ~3 minecraft:amethyst_block
assert block ~2 ~ ~3 minecraft:amethyst_block
assert block ~3 ~ ~3 minecraft:amethyst_block
assert not block ~4 ~ ~3 minecraft:amethyst_block
assert block ~ ~1 ~3 minecraft:amethyst_block
assert block ~1 ~1 ~3 minecraft:amethyst_block
assert block ~2 ~1 ~3 minecraft:amethyst_block
assert block ~3 ~1 ~3 minecraft:amethyst_block
assert block ~4 ~1 ~3 minecraft:amethyst_block
assert not block ~ ~2 ~3 minecraft:amethyst_block
assert block ~1 ~2 ~3 minecraft:amethyst_block
assert block ~2 ~2 ~3 minecraft:amethyst_block
assert block ~3 ~2 ~3 minecraft:amethyst_block
assert not block ~4 ~2 ~3 minecraft:amethyst_block
assert not block ~ ~ ~4 minecraft:amethyst_block
assert block ~1 ~ ~4 minecraft:amethyst_block
assert block ~2 ~ ~4 minecraft:amethyst_block
assert block ~3 ~ ~4 minecraft:amethyst_block
assert not block ~4 ~ ~4 minecraft:amethyst_block
assert block ~ ~1 ~4 minecraft:amethyst_block
assert block ~1 ~1 ~4 minecraft:amethyst_block
assert block ~2 ~1 ~4 minecraft:amethyst_block
assert block ~3 ~1 ~4 minecraft:amethyst_block
assert block ~4 ~1 ~4 minecraft:amethyst_block
assert not block ~ ~2 ~4 minecraft:amethyst_block
assert block ~1 ~2 ~4 minecraft:amethyst_block
assert block ~2 ~2 ~4 minecraft:amethyst_block
assert block ~3 ~2 ~4 minecraft:amethyst_block
assert not block ~4 ~2 ~4 minecraft:amethyst_block
assert not block ~ ~ ~5 minecraft:amethyst_block
assert block ~1 ~ ~5 minecraft:amethyst_block
assert block ~2 ~ ~5 minecraft:amethyst_block
assert block ~3 ~ ~5 minecraft:amethyst_block
assert not block ~4 ~ ~5 minecraft:amethyst_block
assert block ~ ~1 ~5 minecraft:amethyst_block
assert block ~1 ~1 ~5 minecraft:amethyst_block
assert block ~2 ~1 ~5 minecraft:amethyst_block
assert block ~3 ~1 ~5 minecraft:amethyst_block
assert block ~4 ~1 ~5 minecraft:amethyst_block
assert not block ~ ~2 ~5 minecraft:amethyst_block
assert block ~1 ~2 ~5 minecraft:amethyst_block
assert block ~2 ~2 ~5 minecraft:amethyst_block
assert block ~3 ~2 ~5 minecraft:amethyst_block
assert not block ~4 ~2 ~5 minecraft:amethyst_block
assert not block ~ ~ ~6 minecraft:amethyst_block
assert not block ~1 ~ ~6 minecraft:amethyst_block
assert not block ~2 ~ ~6 minecraft:amethyst_block
assert not block ~3 ~ ~6 minecraft:amethyst_block
assert not block ~4 ~ ~6 minecraft:amethyst_block
assert not block ~ ~1 ~6 minecraft:amethyst_block
assert block ~1 ~1 ~6 minecraft:amethyst_block
assert block ~2 ~1 ~6 minecraft:amethyst_block
assert block ~3 ~1 ~6 minecraft:amethyst_block
assert not block ~4 ~1 ~6 minecraft:amethyst_block
assert not block ~ ~2 ~6 minecraft:amethyst_block
assert not block ~1 ~2 ~6 minecraft:amethyst_block
assert not block ~2 ~2 ~6 minecraft:amethyst_block
assert not block ~3 ~2 ~6 minecraft:amethyst_block
assert not block ~4 ~2 ~6 minecraft:amethyst_block

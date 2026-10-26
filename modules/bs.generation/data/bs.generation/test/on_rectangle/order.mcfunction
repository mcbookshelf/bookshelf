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

# The first axis of the order runs first: with two positions per tick, only its line is done at once
data modify storage bs.generation:on_rectangle in set value {run:"setblock ~ ~ ~ minecraft:stone",size:[2,2],batch:2}
function #bs.generation:on_rectangle/xz
assert block ~1 ~ ~ minecraft:stone
assert not block ~ ~ ~1 minecraft:stone
await block ~1 ~ ~1 minecraft:stone

data modify storage bs.generation:on_rectangle in set value {run:"setblock ~ ~ ~ minecraft:gold_block",size:[2,2],batch:2}
function #bs.generation:on_rectangle/zx
assert block ~ ~ ~1 minecraft:gold_block
assert not block ~1 ~ ~ minecraft:gold_block
await block ~1 ~ ~1 minecraft:gold_block

data modify storage bs.generation:on_rectangle in set value {run:"setblock ~ ~ ~ minecraft:iron_block",size:[2,2],batch:2}
execute positioned ~3 ~ ~ run function #bs.generation:on_rectangle/zy
assert block ~3 ~ ~1 minecraft:iron_block
assert not block ~3 ~1 ~ minecraft:iron_block
await block ~3 ~1 ~1 minecraft:iron_block
assert not block ~4 ~ ~ minecraft:iron_block

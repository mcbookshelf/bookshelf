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

# Every position of the rectangle is done, on the two axes of the order
data modify storage bs.generation:on_rectangle in set value {run:"setblock ~ ~ ~ minecraft:stone",size:[2,3]}
function #bs.generation:on_rectangle/xz
assert block ~ ~ ~ minecraft:stone
assert block ~1 ~ ~ minecraft:stone
assert block ~ ~ ~2 minecraft:stone
assert block ~1 ~ ~2 minecraft:stone
assert not block ~2 ~ ~ minecraft:stone
assert not block ~ ~ ~3 minecraft:stone
assert not block ~ ~1 ~ minecraft:stone

# The size follows the order of the function name, and a negative size goes west, down or north
data modify storage bs.generation:on_rectangle in set value {run:"setblock ~ ~ ~ minecraft:gold_block",size:[3,-2]}
execute positioned ~5 ~ ~ run function #bs.generation:on_rectangle/yx
assert block ~5 ~ ~ minecraft:gold_block
assert block ~4 ~ ~ minecraft:gold_block
assert block ~5 ~2 ~ minecraft:gold_block
assert block ~4 ~2 ~ minecraft:gold_block
assert not block ~3 ~ ~ minecraft:gold_block
assert not block ~5 ~3 ~ minecraft:gold_block
assert not block ~5 ~ ~1 minecraft:gold_block

# A size that is missing or not positive counts as 1
data modify storage bs.generation:on_rectangle in set value {run:"setblock ~ ~ ~ minecraft:iron_block",size:[3,-1]}
execute positioned ~ ~6 ~ run function #bs.generation:on_rectangle/xz
assert block ~2 ~6 ~ minecraft:iron_block
assert not block ~ ~6 ~1 minecraft:iron_block
assert not block ~ ~6 ~-1 minecraft:iron_block

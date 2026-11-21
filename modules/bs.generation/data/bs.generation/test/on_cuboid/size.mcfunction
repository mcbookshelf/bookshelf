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

# Every position of the cuboid is done, from the corner the function runs at
data modify storage bs.generation:on_cuboid in set value {run:"setblock ~ ~ ~ minecraft:stone",size:[2,2,2]}
function #bs.generation:on_cuboid/xyz
assert block ~ ~ ~ minecraft:stone
assert block ~1 ~ ~ minecraft:stone
assert block ~ ~1 ~ minecraft:stone
assert block ~1 ~1 ~ minecraft:stone
assert block ~ ~ ~1 minecraft:stone
assert block ~1 ~ ~1 minecraft:stone
assert block ~ ~1 ~1 minecraft:stone
assert block ~1 ~1 ~1 minecraft:stone
assert not block ~2 ~ ~ minecraft:stone
assert not block ~ ~2 ~ minecraft:stone
assert not block ~ ~ ~2 minecraft:stone

# The size follows the order of the function name: three positions on z, one on y, two on x
data modify storage bs.generation:on_cuboid in set value {run:"setblock ~ ~ ~ minecraft:iron_block",size:[3,1,2]}
execute positioned ~ ~3 ~ run function #bs.generation:on_cuboid/zyx
assert block ~1 ~3 ~2 minecraft:iron_block
assert not block ~2 ~3 ~ minecraft:iron_block
assert not block ~ ~3 ~3 minecraft:iron_block
assert not block ~ ~4 ~ minecraft:iron_block

# A size that is missing or not positive counts as 1, even after a generation that had a larger one
data modify storage bs.generation:on_cuboid in set value {run:"setblock ~ ~ ~ minecraft:gold_block"}
execute positioned ~ ~6 ~ run function #bs.generation:on_cuboid/xyz
assert block ~ ~6 ~ minecraft:gold_block
assert not block ~1 ~6 ~ minecraft:gold_block
assert not block ~ ~7 ~ minecraft:gold_block
data modify storage bs.generation:on_cuboid in set value {run:"setblock ~ ~ ~ minecraft:gold_block",size:[2,0,2]}
execute positioned ~ ~8 ~ run function #bs.generation:on_cuboid/xyz
assert block ~1 ~8 ~1 minecraft:gold_block
assert not block ~ ~9 ~ minecraft:gold_block

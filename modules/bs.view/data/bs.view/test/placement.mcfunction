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

# @template ward:empty/9x9x9
# @dummy ~4.5 ~ ~4.5

# against each face of a sponge, where the game would place a block
setblock ~4 ~1 ~6 minecraft:sponge
tp @s ~4.5 ~ ~4.5 0 0
assert run function #bs.view:at_block_placement.in {run:"setblock ~ ~ ~ minecraft:bookshelf",with:{}}
assert block ~4 ~1 ~5 minecraft:bookshelf
fill ~ ~ ~ ~8 ~8 ~8 minecraft:air

setblock ~4 ~1 ~2 minecraft:sponge
tp @s ~4.5 ~ ~4.5 180 0
assert run function #bs.view:at_block_placement.in {run:"setblock ~ ~ ~ minecraft:bookshelf",with:{}}
assert block ~4 ~1 ~3 minecraft:bookshelf
fill ~ ~ ~ ~8 ~8 ~8 minecraft:air

setblock ~6 ~1 ~4 minecraft:sponge
tp @s ~4.5 ~ ~4.5 -90 0
assert run function #bs.view:at_block_placement.in {run:"setblock ~ ~ ~ minecraft:bookshelf",with:{}}
assert block ~5 ~1 ~4 minecraft:bookshelf
fill ~ ~ ~ ~8 ~8 ~8 minecraft:air

setblock ~2 ~1 ~4 minecraft:sponge
tp @s ~4.5 ~ ~4.5 90 0
assert run function #bs.view:at_block_placement.in {run:"setblock ~ ~ ~ minecraft:bookshelf",with:{}}
assert block ~3 ~1 ~4 minecraft:bookshelf
fill ~ ~ ~ ~8 ~8 ~8 minecraft:air

setblock ~4 ~ ~5 minecraft:sponge
tp @s ~4.5 ~ ~4.5 0 45
assert run function #bs.view:at_block_placement.in {run:"setblock ~ ~ ~ minecraft:bookshelf",with:{}}
assert block ~4 ~1 ~5 minecraft:bookshelf
fill ~ ~ ~ ~8 ~8 ~8 minecraft:air

setblock ~4 ~3 ~5 minecraft:sponge
tp @s ~4.5 ~ ~4.5 0 -45
assert run function #bs.view:at_block_placement.in {run:"setblock ~ ~ ~ minecraft:bookshelf",with:{}}
assert block ~4 ~2 ~5 minecraft:bookshelf
fill ~ ~ ~ ~8 ~8 ~8 minecraft:air

# aiming into a cauldron places on top of it, as the game does
setblock ~4 ~ ~5 minecraft:cauldron
tp @s ~4.5 ~ ~4.5 0 45
assert run function #bs.view:at_block_placement.in {run:"setblock ~ ~ ~ minecraft:bookshelf",with:{}}
assert block ~4 ~1 ~5 minecraft:bookshelf

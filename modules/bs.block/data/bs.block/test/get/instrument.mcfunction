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

data modify storage bs:out block set value {}

setblock ~ ~ ~ minecraft:stone
function #bs.block:get_instrument
assert data storage bs:out block{ instrument: "minecraft:block.note_block.basedrum" }

setblock ~ ~ ~ minecraft:bookshelf
function #bs.block:get_instrument
assert data storage bs:out block{ instrument: "minecraft:block.note_block.bass" }

setblock ~ ~ ~ minecraft:glowstone
function #bs.block:get_instrument
assert data storage bs:out block{ instrument: "minecraft:block.note_block.pling" }

setblock ~ ~ ~ minecraft:creeper_head
function #bs.block:get_instrument
assert data storage bs:out block{ instrument: "minecraft:block.note_block.imitate.creeper" }

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

data modify storage bs:in generation.on_rectangle set value {width:3,limit:1,run:'function #bs.generation:callback/set_block {block:"minecraft:stone",with:{}}'}
function #bs.generation:on_rectangle

assert block ~ ~ ~ minecraft:stone
assert not block ~1 ~ ~ minecraft:stone
await block ~1 ~ ~ minecraft:stone
assert not block ~2 ~ ~ minecraft:stone
await block ~2 ~ ~ minecraft:stone

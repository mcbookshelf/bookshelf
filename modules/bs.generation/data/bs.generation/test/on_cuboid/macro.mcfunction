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


# The macro variant takes the input as arguments
function #bs.generation:on_cuboid/xyz.in {run:"setblock ~ ~ ~ minecraft:lapis_block",size:[2,1,2],with:{}}
assert block ~ ~ ~ minecraft:lapis_block
assert block ~1 ~ ~1 minecraft:lapis_block

# The optional ones go in `with`
execute positioned ~ ~2 ~ run function #bs.generation:on_rectangle/xy.in {run:"setblock ~ ~ ~ minecraft:lapis_block",size:[2,2],with:{batch:2}}
assert block ~1 ~2 ~ minecraft:lapis_block
assert not block ~ ~3 ~ minecraft:lapis_block
await block ~1 ~3 ~ minecraft:lapis_block

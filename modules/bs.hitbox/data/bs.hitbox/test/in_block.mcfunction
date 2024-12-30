# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2024 Gunivers
#
# This file is part of the Bookshelf project (https://github.com/mcbookshelf/Bookshelf).
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

## |TEST CASE|: Player should not be inside the slab
setblock ~ ~ ~ minecraft:stone_slab
execute positioned ~.5 ~.5 ~.5 if function #bs.hitbox:is_in_block run fail "Should not be inside the slab"

## |TEST CASE|: Player should be inside the block
setblock ~ ~ ~ minecraft:bookshelf
execute positioned ~.5 ~.5 ~.5 unless function #bs.hitbox:is_in_block run fail "Should be inside the block"

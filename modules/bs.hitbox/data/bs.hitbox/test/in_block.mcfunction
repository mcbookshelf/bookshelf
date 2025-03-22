# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Gunivers
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

# Full cube, position is inside both boxes
setblock ~ ~ ~ minecraft:bookshelf
execute positioned ~.5 ~.5 ~.5 unless function #bs.hitbox:is_in_block_collision run fail "Should be inside the block"
execute positioned ~.5 ~.5 ~.5 unless function #bs.hitbox:is_in_block_interaction run fail "Should be inside the block"

# Bottom slab, position is outside both boxes
setblock ~ ~ ~ minecraft:stone_slab
execute positioned ~.5 ~.5 ~.5 if function #bs.hitbox:is_in_block_collision run fail "Should not be inside the slab"
execute positioned ~.5 ~.5 ~.5 if function #bs.hitbox:is_in_block_interaction run fail "Should not be inside the slab"

# Top slab, position is inside both boxes
setblock ~ ~ ~ minecraft:stone_slab[type=top]
execute positioned ~.5 ~.5 ~.5 unless function #bs.hitbox:is_in_block_collision run fail "Should be inside the slab"
execute positioned ~.5 ~.5 ~.5 unless function #bs.hitbox:is_in_block_interaction run fail "Should be inside the slab"

# Closed fence gate, position is inside both boxes
setblock ~ ~ ~ minecraft:oak_fence_gate
execute positioned ~.5 ~.5 ~.5 unless function #bs.hitbox:is_in_block_collision run fail "Should be inside the fence gate"
execute positioned ~.5 ~.5 ~.5 unless function #bs.hitbox:is_in_block_interaction run fail "Should be inside the fence gate"

# Open fence gate, position is inside the interaction box only
setblock ~ ~ ~ minecraft:oak_fence_gate[open=true]
execute positioned ~.5 ~.5 ~.5 unless function #bs.hitbox:is_in_block_interaction run fail "Should be inside the fence gate"
execute positioned ~.5 ~.5 ~.5 if function #bs.hitbox:is_in_block_collision run fail "Should not be inside the fence gate"

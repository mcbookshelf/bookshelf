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
# @dummy
# @skyaccess true

setblock ~ ~ ~ minecraft:stone_slab[type=bottom]

# Entity is outside the slab
tp @s ~.5 ~.75 ~.5
execute if function #bs.hitbox:is_entity_in_block_collision run fail "Entity should not be inside the slab"
execute if function #bs.hitbox:is_entity_in_block_interaction run fail "Entity should not be inside the slab"
tp @s ~-.31 ~ ~-.31
execute if function #bs.hitbox:is_entity_in_block_collision run fail "Entity should not be inside the slab"
execute if function #bs.hitbox:is_entity_in_block_interaction run fail "Entity should not be inside the slab"

# Entity is inside the slab
tp @s ~.5 ~-1 ~.5
execute unless function #bs.hitbox:is_entity_in_block_collision run fail "Entity should be inside the slab"
execute unless function #bs.hitbox:is_entity_in_block_interaction run fail "Entity should be inside the slab"
tp @s ~-.29 ~ ~-.29
execute unless function #bs.hitbox:is_entity_in_block_collision run fail "Entity should be inside the slab"
execute unless function #bs.hitbox:is_entity_in_block_interaction run fail "Entity should be inside the slab"

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
# @dummy

fill ~-1 ~-1 ~-1 ~1 ~1 ~1 minecraft:air replace minecraft:barrier
setblock ~ ~ ~ minecraft:stone_slab[type=bottom]

## |TEST CASE|: Entity is not inside the block
tp @s ~.5 ~.75 ~.5
execute if function #bs.hitbox:is_entity_in_block run fail "Entity should not be inside the slab"
tp @s ~-.3 ~ ~-.3
await delay 5t
execute if function #bs.hitbox:is_entity_in_block run fail "Entity should not be inside the slab"

## |TEST CASE|: Entity is inside the block
tp @s ~.5 ~-1 ~.5
execute unless function #bs.hitbox:is_entity_in_block run fail "Entity should be inside the slab"
tp @s ~-.29 ~ ~-.29
execute unless function #bs.hitbox:is_entity_in_block run fail "Entity should be inside the slab"

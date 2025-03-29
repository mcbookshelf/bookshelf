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

setblock ~-1 ~ ~-1 minecraft:bookshelf

# Entity is outside a block
execute if function #bs.hitbox:is_entity_in_blocks_collision run fail "Entity should be outside blocks"
execute if function #bs.hitbox:is_entity_in_blocks_interaction run fail "Entity should be outside blocks"

# Entity is inside a block
tp @s ~ ~ ~
execute unless function #bs.hitbox:is_entity_in_blocks_collision run fail "Entity should be inside a block"
execute unless function #bs.hitbox:is_entity_in_blocks_interaction run fail "Entity should be inside a block"

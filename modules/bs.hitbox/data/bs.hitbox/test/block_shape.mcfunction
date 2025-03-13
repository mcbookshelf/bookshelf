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

# Bottom stone slab shape
setblock ~ ~ ~ minecraft:stone_slab[type=bottom]
function #bs.hitbox:get_block
assert data storage bs:out hitbox{ collision_shape: [[0.0, 0.0, 0.0, 16.0, 8.0, 16.0]], interaction_shape: [[0.0, 0.0, 0.0, 16.0, 8.0, 16.0]] }

# Top stone slab shape
setblock ~ ~ ~ minecraft:stone_slab[type=top]
function #bs.hitbox:get_block
assert data storage bs:out hitbox{ collision_shape: [[0.0, 0.0, 0.0, 16.0, 8.0, 16.0]], interaction_shape: [[0.0, 0.0, 0.0, 16.0, 8.0, 16.0]] }

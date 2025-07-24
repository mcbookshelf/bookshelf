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

# @deprecated (remove this file in in 4.0.0)
data modify storage bs:out hitbox set value {}
loot replace entity B5-0-0-0-3 contents loot bs.hitbox:block/default
data modify storage bs:out hitbox.interaction_shape set from entity B5-0-0-0-3 item.components."minecraft:custom_data".shape
loot replace entity B5-0-0-0-3 contents loot bs.hitbox:block/collision
data modify storage bs:out hitbox.collision_shape set from entity B5-0-0-0-3 item.components."minecraft:custom_data".shape

execute if block ~ ~ ~ #bs.hitbox:has_shape_offset summon minecraft:marker run function bs.hitbox:get_block/offset/get

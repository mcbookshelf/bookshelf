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

function #bs.hitbox:get_entity
execute if entity @s[type=#bs.hitbox:is_shaped] run function bs.hitbox:is_entity_in_block/entity/shaped
execute unless entity @s[type=#bs.hitbox:is_shaped] run function bs.hitbox:is_entity_in_block/entity/sized

function #bs.hitbox:get_block
$execute store success score #s bs.ctx run data modify storage bs:ctx _ set from storage bs:out hitbox.$(kind)_shape
execute if score #s bs.ctx matches 0 run return 0
execute store result score #u bs.ctx run data get storage bs:out hitbox.offset.x 1000000
execute store result score #v bs.ctx run data get storage bs:out hitbox.offset.z 1000000
return run function bs.hitbox:is_entity_in_block/check/shape

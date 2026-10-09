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

execute if data storage bs.hitbox:overlaps in{entities:"#bs.hitbox:get_entity/living"} run return run execute if predicate bs.hitbox:get_entity/living at @s run function bs.hitbox:overlaps/blocks/hitbox
execute if data storage bs.hitbox:overlaps in{entities:"#bs.hitbox:get_entity/pushable"} run return run execute if predicate bs.hitbox:get_entity/pushable at @s run function bs.hitbox:overlaps/blocks/hitbox
execute if data storage bs.hitbox:overlaps in{entities:"#bs.hitbox:get_entity/sized"} run return run execute if predicate bs.hitbox:get_entity/sized at @s run function bs.hitbox:overlaps/blocks/hitbox
execute if data storage bs.hitbox:overlaps in{entities:"#bs.hitbox:get_entity/solid"} run return run execute if predicate bs.hitbox:get_entity/solid at @s run function bs.hitbox:overlaps/blocks/hitbox
execute if data storage bs.hitbox:overlaps in{entities:"#bs.hitbox:get_entity/targetable"} run return run execute if predicate bs.hitbox:get_entity/targetable at @s run function bs.hitbox:overlaps/blocks/hitbox

execute at @s run return run function bs.hitbox:overlaps/blocks/custom

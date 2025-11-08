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

# check block, entity, and custom entity collisions
$execute unless block ~ ~ ~ $(ignored_blocks) run function bs.raycast:check/block/any with storage bs:data raycast
$execute if score #raycast.max_distance bs.data matches 1.. as @e[tag=bs.hitbox.custom,tag=$(entities),predicate=!bs.raycast:internal/checked,distance=..24,sort=nearest] run function bs.raycast:check/entity/any
$execute if score #raycast.max_distance bs.data matches 1.. as @e[type=!$(ignored_entities),tag=$(entities),predicate=!bs.raycast:internal/checked,dx=0,sort=nearest] run function bs.raycast:check/entity/any
execute if score #raycast.max_distance bs.data matches 1.. if score $raycast.distance bs.lambda <= #raycast.lx bs.data if score $raycast.distance bs.lambda <= #raycast.ly bs.data if score $raycast.distance bs.lambda <= #raycast.lz bs.data run function bs.raycast:collide/any

# advance on the grid by the shortest length
execute if score #raycast.lx bs.data <= #raycast.ly bs.data if score #raycast.lx bs.data <= #raycast.lz bs.data if score #raycast.lx bs.data <= #raycast.max_distance bs.data run return run function bs.raycast:recurse/5/x with storage bs:data raycast
execute if score #raycast.ly bs.data <= #raycast.lz bs.data if score #raycast.ly bs.data <= #raycast.max_distance bs.data run return run function bs.raycast:recurse/5/y with storage bs:data raycast
execute if score #raycast.lz bs.data <= #raycast.max_distance bs.data run return run function bs.raycast:recurse/5/z with storage bs:data raycast

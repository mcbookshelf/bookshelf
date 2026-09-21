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

# check entity and custom entity collisions
$execute as @e[tag=bs.hitbox.custom,tag=$(entities),tag=!bs.raycast.checked,distance=..24,sort=nearest] run function bs.raycast:check/entity/any
$execute as @e[type=!$(ignored_entities),tag=$(entities),tag=!bs.raycast.checked,dx=0,sort=nearest] run function bs.raycast:check/entity/any
execute if predicate bs.raycast:internal/shortest_tm run function bs.raycast:react/any

# advance on the grid by the shortest length
execute if predicate bs.raycast:internal/shortest_x run return run function bs.raycast:recurse/3/x with storage bs:data raycast
execute if predicate bs.raycast:internal/shortest_y run return run function bs.raycast:recurse/3/y with storage bs:data raycast
execute if predicate bs.raycast:internal/shortest_z run return run function bs.raycast:recurse/3/z with storage bs:data raycast

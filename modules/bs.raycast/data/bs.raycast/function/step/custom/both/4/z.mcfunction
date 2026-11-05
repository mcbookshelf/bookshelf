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

# check block and entity collisions
scoreboard players operation #raycast.lz bs.data += #raycast.dz bs.data
$execute if function $(blocks) run function $(_block)
$execute as @e[dx=0,tag=!bs.raycast.omit,tag=!bs.raycast.done,tag=!bs.hitbox.unbounded,$(selector)] if function $(_entity) if score @s bs.raycast.hit = #raycast.entity bs.data run function $(_nearest)
$execute unless score #raycast.max bs.data matches -2147483648 unless score #raycast.lx bs.data <= #raycast.next bs.data unless score #raycast.ly bs.data <= #raycast.next bs.data unless score #raycast.lz bs.data <= #raycast.next bs.data run function $(_react)

# advance on the grid by the shortest length
execute if score #raycast.lx bs.data <= #raycast.ly bs.data if score #raycast.lx bs.data <= #raycast.lz bs.data if score #raycast.lx bs.data <= #raycast.max bs.data positioned ~-1 ~ ~ run return run function bs.raycast:step/custom/both/4/x with storage bs.raycast: ray
execute if score #raycast.ly bs.data <= #raycast.lz bs.data if score #raycast.ly bs.data <= #raycast.max bs.data positioned ~ ~-1 ~ run return run function bs.raycast:step/custom/both/4/y with storage bs.raycast: ray
execute if score #raycast.lz bs.data <= #raycast.max bs.data positioned ~ ~ ~1 run return run function bs.raycast:step/custom/both/4/z with storage bs.raycast: ray

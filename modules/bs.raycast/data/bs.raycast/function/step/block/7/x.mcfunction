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

# check block collisions
scoreboard players operation #raycast.lx bs.data += #raycast.dx bs.data
$execute if function $(blocks) run function $(_block)

# advance on the grid by the shortest length
execute if score #raycast.lx bs.data <= #raycast.ly bs.data if score #raycast.lx bs.data <= #raycast.lz bs.data if score #raycast.lx bs.data <= #raycast.max bs.data positioned ~1 ~ ~ run return run function bs.raycast:step/block/7/x with storage bs.raycast: ray
execute if score #raycast.ly bs.data <= #raycast.lz bs.data if score #raycast.ly bs.data <= #raycast.max bs.data positioned ~ ~-1 ~ run return run function bs.raycast:step/block/7/y with storage bs.raycast: ray
execute if score #raycast.lz bs.data <= #raycast.max bs.data positioned ~ ~ ~-1 run return run function bs.raycast:step/block/7/z with storage bs.raycast: ray

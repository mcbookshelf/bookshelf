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

# check block and entity collision (debug: particle minecraft:block_marker{block_state:"barrier"} ~.5 ~.5 ~.5 0 0 0 0 1)
$execute unless data storage bs:data raycast{blocks:0b} unless block ~ ~ ~ $(ignored_blocks) run function bs.raycast:check/block/any
$execute unless data storage bs:data raycast{entities:0b} as @e[type=!$(ignored_entities),tag=$(entities),tag=!bs.raycast.omit,dx=0] run function bs.raycast:check/entity/any

# advance on the grid by the shortest length
execute if score #raycast.lx bs.data <= #raycast.ly bs.data if score #raycast.lx bs.data <= #raycast.lz bs.data if score #raycast.lx bs.data <= #raycast.max_distance bs.data run return run function bs.raycast:recurse/x with storage bs:data raycast
execute if score #raycast.ly bs.data <= #raycast.lz bs.data if score #raycast.ly bs.data <= #raycast.max_distance bs.data run return run function bs.raycast:recurse/y with storage bs:data raycast
execute if score #raycast.lz bs.data <= #raycast.max_distance bs.data run return run function bs.raycast:recurse/z with storage bs:data raycast

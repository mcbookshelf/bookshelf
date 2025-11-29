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

data remove storage bs:lambda raycast
scoreboard players operation $raycast.pierce_distance bs.lambda -= $raycast.distance bs.lambda
scoreboard players operation $raycast.pierce_distance bs.lambda *= -1 bs.const
execute store result storage bs:lambda raycast.distance double .001 run scoreboard players get $raycast.distance bs.lambda
execute if score $raycast.distance bs.lambda = #raycast.btoi bs.data run function bs.raycast:collide/block/handle
execute if score $raycast.distance bs.lambda = #raycast.etoi bs.data positioned as @s run function bs.raycast:collide/entity/handle

# stop the recursion if piercing is 0
execute if score $raycast.piercing bs.lambda matches 0 run return run scoreboard players set #raycast.max_distance bs.data -2147483648
scoreboard players set $raycast.distance bs.lambda 2147483646
scoreboard players operation $raycast.distance bs.lambda < #raycast.btoi bs.data
scoreboard players operation $raycast.distance bs.lambda < #raycast.etoi bs.data

execute if score $raycast.distance bs.lambda <= #raycast.lx bs.data \
  if score $raycast.distance bs.lambda <= #raycast.ly bs.data \
  if score $raycast.distance bs.lambda <= #raycast.lz bs.data \
  run function bs.raycast:collide/any

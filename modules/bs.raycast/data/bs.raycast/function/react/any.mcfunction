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

execute if score #raycast.tm bs.data = #raycast.tb bs.data run function bs.raycast:react/block
execute if score #raycast.tm bs.data = #raycast.te bs.data positioned as @s as @e[tag=bs.raycast.checked,predicate=bs.raycast:internal/id,distance=..255,limit=1] run function bs.raycast:react/entity

# stop the recursion if piercing is 0
execute if score $raycast.piercing bs.lambda matches 0 run return run scoreboard players set #raycast.dm bs.data -2147483648

execute store result score $raycast.prev_entry_distance bs.lambda run data get storage bs:data raycast.tmin
execute store result score $raycast.prev_exit_distance bs.lambda run data get storage bs:data raycast.tmax

scoreboard players set #raycast.tm bs.data 2147483647
scoreboard players operation #raycast.tm bs.data < #raycast.tb bs.data
scoreboard players operation #raycast.tm bs.data < #raycast.te bs.data

execute if score #raycast.tm bs.data <= #raycast.lx bs.data \
  if score #raycast.tm bs.data <= #raycast.ly bs.data \
  if score #raycast.tm bs.data <= #raycast.lz bs.data \
  run function bs.raycast:react/any

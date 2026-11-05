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

scoreboard players set #raycast.kind bs.data 1
scoreboard players operation #raycast.hit bs.data = @s bs.raycast.hit
scoreboard players operation #raycast.ex bs.data = @s bs.raycast.x
scoreboard players operation #raycast.ey bs.data = @s bs.raycast.y
scoreboard players operation #raycast.ez bs.data = @s bs.raycast.z
execute if data storage bs.raycast: ray.on_entity at @s run function bs.raycast:utils/on_entity with storage bs.raycast: ray
execute if data storage bs.raycast: ray.on_entry store result storage bs.raycast: ray._entry double 0.00000095367431640625 run scoreboard players get #raycast.hit bs.data
execute if data storage bs.raycast: ray.on_entry at B5-0-0-0-C1 run function bs.raycast:utils/at_entry with storage bs.raycast: ray
scoreboard players set #raycast.max bs.data -2147483648
scoreboard players set #raycast.kind bs.data 0

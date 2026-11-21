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
scoreboard players operation #raycast.ex bs.data = @s bs.raycast.x
scoreboard players operation #raycast.ey bs.data = @s bs.raycast.y
scoreboard players operation #raycast.ez bs.data = @s bs.raycast.z

execute unless score @s bs.raycast.shapes matches 1.. if data storage bs.raycast: ray.on_entity unless function bs.raycast:pierce/entity/on_entity run return fail
execute if score @s bs.raycast.shapes matches ..-1 run scoreboard players operation @s bs.raycast.shapes *= -1 bs.const
execute if data storage bs.raycast: ray.on_entry unless function bs.raycast:pierce/entity/on_entry run return fail
execute if data storage bs.raycast: ray.on_exit unless function bs.raycast:pierce/entity/on_exit run return fail

scoreboard players set #raycast.kind bs.data 0
execute store result score @s bs.raycast.hit run compute default integer bs.raycast:_pierce/e/next
execute if score @s bs.raycast.hit matches 2147483647 run scoreboard players remove #raycast.pending bs.data 1
execute unless score @s bs.raycast.hit matches 2147483647 if score @s bs.raycast.hit <= #raycast.other bs.data run return run function bs.raycast:pierce/entity/again

execute store result score #raycast.entity bs.data run scoreboard players set #raycast.other bs.data 2147483647
execute if score #raycast.pending bs.data matches 1.. run function bs.raycast:pierce/entity/scan with storage bs.raycast: ray
scoreboard players operation #raycast.next bs.data = #raycast.block bs.data
scoreboard players operation #raycast.next bs.data < #raycast.entity bs.data
execute unless score #raycast.next bs.data matches 2147483647 run scoreboard players operation #raycast.next bs.data /= 64 bs.const
execute unless score #raycast.lx bs.data <= #raycast.next bs.data unless score #raycast.ly bs.data <= #raycast.next bs.data unless score #raycast.lz bs.data <= #raycast.next bs.data as B5-0-0-0-C1 run function bs.raycast:pierce/react

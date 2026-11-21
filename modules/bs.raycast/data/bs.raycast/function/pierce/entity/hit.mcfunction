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

tag @s add bs.raycast.done
scoreboard players set @s bs.raycast.hit 2147483647
$execute unless function $(entities) run return fail
execute positioned as @s as B5-0-0-0-C1 run function bs.raycast:utils/position
tp B5-0-0-0-C1 ~ ~ ~
execute store result score #raycast.ex bs.data store result score @s bs.raycast.x run data get storage bs.raycast: pos[0] 16384
execute store result score #raycast.ey bs.data store result score @s bs.raycast.y run data get storage bs.raycast: pos[1] 16384
execute store result score #raycast.ez bs.data store result score @s bs.raycast.z run data get storage bs.raycast: pos[2] 16384
execute store result score #b bs.ctx run data get storage bs.hitbox:get_entity out
execute store result score @s bs.raycast.hit run compute default integer bs.raycast:_e/hit
execute if score @s bs.raycast.hit matches 2147483647 run return fail
execute if data storage bs.raycast: ray.on_exit store result score @s bs.raycast.e0 run compute default integer bs.raycast:_pierce/e/exit
scoreboard players set @s bs.raycast.shapes 0
return run function bs.raycast:pierce/entity/near

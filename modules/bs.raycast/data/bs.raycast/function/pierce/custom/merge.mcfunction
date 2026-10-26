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

execute store result score @s bs.raycast.s0 store result score #l bs.ctx run compute default integer bs.raycast:_pierce/start
execute store result score #l bs.ctx run compute default integer bs.raycast:_pierce/grow
execute store result score @s bs.raycast.e0 run function bs.raycast:pierce/grow
execute if score #g bs.ctx matches -2147483647 run return 1

scoreboard players set #l bs.ctx 0
execute store result score @s bs.raycast.s1 run scoreboard players operation #l bs.ctx -= #g bs.ctx
execute store result score #l bs.ctx run compute default integer bs.raycast:_pierce/grow
execute store result score @s bs.raycast.e1 run function bs.raycast:pierce/grow
execute if score #g bs.ctx matches -2147483647 run return 2

# @coverage off
scoreboard players set #l bs.ctx 0
execute store result score @s bs.raycast.s2 run scoreboard players operation #l bs.ctx -= #g bs.ctx
execute store result score #l bs.ctx run compute default integer bs.raycast:_pierce/grow
execute store result score @s bs.raycast.e2 run function bs.raycast:pierce/grow
execute if score #g bs.ctx matches -2147483647 run return 3

scoreboard players set #l bs.ctx 0
execute store result score @s bs.raycast.s3 run scoreboard players operation #l bs.ctx -= #g bs.ctx
execute store result score #l bs.ctx run compute default integer bs.raycast:_pierce/grow
execute store result score @s bs.raycast.e3 run function bs.raycast:pierce/grow
execute if score #g bs.ctx matches -2147483647 run return 4

scoreboard players set #l bs.ctx 0
execute store result score @s bs.raycast.s4 run scoreboard players operation #l bs.ctx -= #g bs.ctx
execute store result score #l bs.ctx run compute default integer bs.raycast:_pierce/grow
execute store result score @s bs.raycast.e4 run function bs.raycast:pierce/grow
execute if score #g bs.ctx matches -2147483647 run return 5

scoreboard players set #l bs.ctx 0
execute store result score @s bs.raycast.s5 run scoreboard players operation #l bs.ctx -= #g bs.ctx
execute store result score #l bs.ctx run compute default integer bs.raycast:_pierce/grow
execute store result score @s bs.raycast.e5 run function bs.raycast:pierce/grow
execute if score #g bs.ctx matches -2147483647 run return 6

scoreboard players set #l bs.ctx 0
execute store result score @s bs.raycast.s6 run scoreboard players operation #l bs.ctx -= #g bs.ctx
execute store result score #l bs.ctx run compute default integer bs.raycast:_pierce/grow
execute store result score @s bs.raycast.e6 run function bs.raycast:pierce/grow
execute if score #g bs.ctx matches -2147483647 run return 7

scoreboard players set #l bs.ctx 0
execute store result score @s bs.raycast.s7 run scoreboard players operation #l bs.ctx -= #g bs.ctx
execute store result score #l bs.ctx run compute default integer bs.raycast:_pierce/grow
execute store result score @s bs.raycast.e7 run function bs.raycast:pierce/grow
return 8

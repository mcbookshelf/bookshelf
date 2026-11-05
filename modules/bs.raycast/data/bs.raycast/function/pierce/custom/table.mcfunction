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

execute store result score #raycast.entry0 bs.data store result score @s bs.raycast.s0 run compute default integer bs.raycast:_pierce/e/in
execute store result score #raycast.exit0 bs.data store result score @s bs.raycast.e0 run compute default integer bs.raycast:_pierce/e/out
scoreboard players operation #m bs.ctx = @s bs.raycast.shapes

execute store result score #raycast.entry1 bs.data store result score @s bs.raycast.s1 run compute default integer bs.raycast:_pierce/e/in
execute store result score #raycast.exit1 bs.data store result score @s bs.raycast.e1 run compute default integer bs.raycast:_pierce/e/out
execute store result score #m bs.ctx run compute default integer bs.raycast:_pierce/rest
execute if score #m bs.ctx matches 0 run return 2

execute store result score #raycast.entry2 bs.data run compute default integer bs.raycast:_pierce/e/in
execute store result score #raycast.exit2 bs.data run compute default integer bs.raycast:_pierce/e/out
execute store result score #m bs.ctx run compute default integer bs.raycast:_pierce/rest
execute if score #m bs.ctx matches 0 run return 3

execute store result score #raycast.entry3 bs.data run compute default integer bs.raycast:_pierce/e/in
execute store result score #raycast.exit3 bs.data run compute default integer bs.raycast:_pierce/e/out
execute store result score #m bs.ctx run compute default integer bs.raycast:_pierce/rest
execute if score #m bs.ctx matches 0 run return 4

# @coverage off
execute store result score #raycast.entry4 bs.data run compute default integer bs.raycast:_pierce/e/in
execute store result score #raycast.exit4 bs.data run compute default integer bs.raycast:_pierce/e/out
execute store result score #m bs.ctx run compute default integer bs.raycast:_pierce/rest
execute if score #m bs.ctx matches 0 run return 5

execute store result score #raycast.entry5 bs.data run compute default integer bs.raycast:_pierce/e/in
execute store result score #raycast.exit5 bs.data run compute default integer bs.raycast:_pierce/e/out
execute store result score #m bs.ctx run compute default integer bs.raycast:_pierce/rest
execute if score #m bs.ctx matches 0 run return 6

execute store result score #raycast.entry6 bs.data run compute default integer bs.raycast:_pierce/e/in
execute store result score #raycast.exit6 bs.data run compute default integer bs.raycast:_pierce/e/out
execute store result score #m bs.ctx run compute default integer bs.raycast:_pierce/rest
execute if score #m bs.ctx matches 0 run return 7

execute store result score #raycast.entry7 bs.data run compute default integer bs.raycast:_pierce/e/in
execute store result score #raycast.exit7 bs.data run compute default integer bs.raycast:_pierce/e/out
return 8

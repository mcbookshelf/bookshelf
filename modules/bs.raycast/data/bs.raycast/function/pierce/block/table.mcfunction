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

execute store result score #raycast.entry0 bs.data store result score #raycast.start0 bs.data run compute default integer bs.raycast:_pierce/b/in
execute store result score #raycast.exit0 bs.data store result score #raycast.end0 bs.data run compute default integer bs.raycast:_pierce/b/out
scoreboard players operation #m bs.ctx = #raycast.shapes bs.data

execute store result score #raycast.entry1 bs.data store result score #raycast.start1 bs.data run compute default integer bs.raycast:_pierce/b/in
execute store result score #raycast.exit1 bs.data store result score #raycast.end1 bs.data run compute default integer bs.raycast:_pierce/b/out
execute store result score #m bs.ctx run compute default integer bs.raycast:_pierce/rest
execute if score #m bs.ctx matches 0 run return 2

execute store result score #raycast.entry2 bs.data run compute default integer bs.raycast:_pierce/b/in
execute store result score #raycast.exit2 bs.data run compute default integer bs.raycast:_pierce/b/out
execute store result score #m bs.ctx run compute default integer bs.raycast:_pierce/rest
execute if score #m bs.ctx matches 0 run return 3

execute store result score #raycast.entry3 bs.data run compute default integer bs.raycast:_pierce/b/in
execute store result score #raycast.exit3 bs.data run compute default integer bs.raycast:_pierce/b/out
execute store result score #m bs.ctx run compute default integer bs.raycast:_pierce/rest
execute if score #m bs.ctx matches 0 run return 4

# @coverage off
execute store result score #raycast.entry4 bs.data run compute default integer bs.raycast:_pierce/b/in
execute store result score #raycast.exit4 bs.data run compute default integer bs.raycast:_pierce/b/out
execute store result score #m bs.ctx run compute default integer bs.raycast:_pierce/rest
execute if score #m bs.ctx matches 0 run return 5

execute store result score #raycast.entry5 bs.data run compute default integer bs.raycast:_pierce/b/in
execute store result score #raycast.exit5 bs.data run compute default integer bs.raycast:_pierce/b/out
execute store result score #m bs.ctx run compute default integer bs.raycast:_pierce/rest
execute if score #m bs.ctx matches 0 run return 6

execute store result score #raycast.entry6 bs.data run compute default integer bs.raycast:_pierce/b/in
execute store result score #raycast.exit6 bs.data run compute default integer bs.raycast:_pierce/b/out
execute store result score #m bs.ctx run compute default integer bs.raycast:_pierce/rest
execute if score #m bs.ctx matches 0 run return 7

execute store result score #raycast.entry7 bs.data run compute default integer bs.raycast:_pierce/b/in
execute store result score #raycast.exit7 bs.data run compute default integer bs.raycast:_pierce/b/out
execute store result score #m bs.ctx run compute default integer bs.raycast:_pierce/rest
execute if score #m bs.ctx matches 0 run return 8

execute store result score #raycast.entry8 bs.data run compute default integer bs.raycast:_pierce/b/in
execute store result score #raycast.exit8 bs.data run compute default integer bs.raycast:_pierce/b/out
execute store result score #m bs.ctx run compute default integer bs.raycast:_pierce/rest
execute if score #m bs.ctx matches 0 run return 9

execute store result score #raycast.entry9 bs.data run compute default integer bs.raycast:_pierce/b/in
execute store result score #raycast.exit9 bs.data run compute default integer bs.raycast:_pierce/b/out
execute store result score #m bs.ctx run compute default integer bs.raycast:_pierce/rest
execute if score #m bs.ctx matches 0 run return 10

execute store result score #raycast.entry10 bs.data run compute default integer bs.raycast:_pierce/b/in
execute store result score #raycast.exit10 bs.data run compute default integer bs.raycast:_pierce/b/out
execute store result score #m bs.ctx run compute default integer bs.raycast:_pierce/rest
execute if score #m bs.ctx matches 0 run return 11

execute store result score #raycast.entry11 bs.data run compute default integer bs.raycast:_pierce/b/in
execute store result score #raycast.exit11 bs.data run compute default integer bs.raycast:_pierce/b/out
execute store result score #m bs.ctx run compute default integer bs.raycast:_pierce/rest
execute if score #m bs.ctx matches 0 run return 12

execute store result score #raycast.entry12 bs.data run compute default integer bs.raycast:_pierce/b/in
execute store result score #raycast.exit12 bs.data run compute default integer bs.raycast:_pierce/b/out
execute store result score #m bs.ctx run compute default integer bs.raycast:_pierce/rest
execute if score #m bs.ctx matches 0 run return 13

execute store result score #raycast.entry13 bs.data run compute default integer bs.raycast:_pierce/b/in
execute store result score #raycast.exit13 bs.data run compute default integer bs.raycast:_pierce/b/out
execute store result score #m bs.ctx run compute default integer bs.raycast:_pierce/rest
execute if score #m bs.ctx matches 0 run return 14

execute store result score #raycast.entry14 bs.data run compute default integer bs.raycast:_pierce/b/in
execute store result score #raycast.exit14 bs.data run compute default integer bs.raycast:_pierce/b/out
execute store result score #m bs.ctx run compute default integer bs.raycast:_pierce/rest
execute if score #m bs.ctx matches 0 run return 15

execute store result score #raycast.entry15 bs.data run compute default integer bs.raycast:_pierce/b/in
execute store result score #raycast.exit15 bs.data run compute default integer bs.raycast:_pierce/b/out
execute store result score #m bs.ctx run compute default integer bs.raycast:_pierce/rest
execute if score #m bs.ctx matches 0 run return 16

execute store result score #raycast.entry16 bs.data run compute default integer bs.raycast:_pierce/b/in
execute store result score #raycast.exit16 bs.data run compute default integer bs.raycast:_pierce/b/out
execute store result score #m bs.ctx run compute default integer bs.raycast:_pierce/rest
execute if score #m bs.ctx matches 0 run return 17

execute store result score #raycast.entry17 bs.data run compute default integer bs.raycast:_pierce/b/in
execute store result score #raycast.exit17 bs.data run compute default integer bs.raycast:_pierce/b/out
execute store result score #m bs.ctx run compute default integer bs.raycast:_pierce/rest
execute if score #m bs.ctx matches 0 run return 18

execute store result score #raycast.entry18 bs.data run compute default integer bs.raycast:_pierce/b/in
execute store result score #raycast.exit18 bs.data run compute default integer bs.raycast:_pierce/b/out
execute store result score #m bs.ctx run compute default integer bs.raycast:_pierce/rest
execute if score #m bs.ctx matches 0 run return 19

execute store result score #raycast.entry19 bs.data run compute default integer bs.raycast:_pierce/b/in
execute store result score #raycast.exit19 bs.data run compute default integer bs.raycast:_pierce/b/out
execute store result score #m bs.ctx run compute default integer bs.raycast:_pierce/rest
execute if score #m bs.ctx matches 0 run return 20

execute store result score #raycast.entry20 bs.data run compute default integer bs.raycast:_pierce/b/in
execute store result score #raycast.exit20 bs.data run compute default integer bs.raycast:_pierce/b/out
execute store result score #m bs.ctx run compute default integer bs.raycast:_pierce/rest
execute if score #m bs.ctx matches 0 run return 21

execute store result score #raycast.entry21 bs.data run compute default integer bs.raycast:_pierce/b/in
execute store result score #raycast.exit21 bs.data run compute default integer bs.raycast:_pierce/b/out
execute store result score #m bs.ctx run compute default integer bs.raycast:_pierce/rest
execute if score #m bs.ctx matches 0 run return 22

execute store result score #raycast.entry22 bs.data run compute default integer bs.raycast:_pierce/b/in
execute store result score #raycast.exit22 bs.data run compute default integer bs.raycast:_pierce/b/out
execute store result score #m bs.ctx run compute default integer bs.raycast:_pierce/rest
execute if score #m bs.ctx matches 0 run return 23

execute store result score #raycast.entry23 bs.data run compute default integer bs.raycast:_pierce/b/in
execute store result score #raycast.exit23 bs.data run compute default integer bs.raycast:_pierce/b/out
return 24

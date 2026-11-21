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

execute store result score #raycast.start0 bs.data store result score #l bs.ctx run compute default integer bs.raycast:_pierce/start
execute store result score #l bs.ctx run compute default integer bs.raycast:_pierce/grow
execute store result score #raycast.end0 bs.data run function bs.raycast:pierce/grow
execute if score #g bs.ctx matches -2147483647 run return 1

scoreboard players set #l bs.ctx 0
execute store result score #raycast.start1 bs.data run scoreboard players operation #l bs.ctx -= #g bs.ctx
execute store result score #l bs.ctx run compute default integer bs.raycast:_pierce/grow
execute store result score #raycast.end1 bs.data run function bs.raycast:pierce/grow
execute if score #g bs.ctx matches -2147483647 run return 2

# @coverage off
scoreboard players set #l bs.ctx 0
execute store result score #raycast.start2 bs.data run scoreboard players operation #l bs.ctx -= #g bs.ctx
execute store result score #l bs.ctx run compute default integer bs.raycast:_pierce/grow
execute store result score #raycast.end2 bs.data run function bs.raycast:pierce/grow
execute if score #g bs.ctx matches -2147483647 run return 3

scoreboard players set #l bs.ctx 0
execute store result score #raycast.start3 bs.data run scoreboard players operation #l bs.ctx -= #g bs.ctx
execute store result score #l bs.ctx run compute default integer bs.raycast:_pierce/grow
execute store result score #raycast.end3 bs.data run function bs.raycast:pierce/grow
execute if score #g bs.ctx matches -2147483647 run return 4

scoreboard players set #l bs.ctx 0
execute store result score #raycast.start4 bs.data run scoreboard players operation #l bs.ctx -= #g bs.ctx
execute store result score #l bs.ctx run compute default integer bs.raycast:_pierce/grow
execute store result score #raycast.end4 bs.data run function bs.raycast:pierce/grow
execute if score #g bs.ctx matches -2147483647 run return 5

scoreboard players set #l bs.ctx 0
execute store result score #raycast.start5 bs.data run scoreboard players operation #l bs.ctx -= #g bs.ctx
execute store result score #l bs.ctx run compute default integer bs.raycast:_pierce/grow
execute store result score #raycast.end5 bs.data run function bs.raycast:pierce/grow
execute if score #g bs.ctx matches -2147483647 run return 6

scoreboard players set #l bs.ctx 0
execute store result score #raycast.start6 bs.data run scoreboard players operation #l bs.ctx -= #g bs.ctx
execute store result score #l bs.ctx run compute default integer bs.raycast:_pierce/grow
execute store result score #raycast.end6 bs.data run function bs.raycast:pierce/grow
execute if score #g bs.ctx matches -2147483647 run return 7

scoreboard players set #l bs.ctx 0
execute store result score #raycast.start7 bs.data run scoreboard players operation #l bs.ctx -= #g bs.ctx
execute store result score #l bs.ctx run compute default integer bs.raycast:_pierce/grow
execute store result score #raycast.end7 bs.data run function bs.raycast:pierce/grow
execute if score #g bs.ctx matches -2147483647 run return 8

scoreboard players set #l bs.ctx 0
execute store result score #raycast.start8 bs.data run scoreboard players operation #l bs.ctx -= #g bs.ctx
execute store result score #l bs.ctx run compute default integer bs.raycast:_pierce/grow
execute store result score #raycast.end8 bs.data run function bs.raycast:pierce/grow
execute if score #g bs.ctx matches -2147483647 run return 9

scoreboard players set #l bs.ctx 0
execute store result score #raycast.start9 bs.data run scoreboard players operation #l bs.ctx -= #g bs.ctx
execute store result score #l bs.ctx run compute default integer bs.raycast:_pierce/grow
execute store result score #raycast.end9 bs.data run function bs.raycast:pierce/grow
execute if score #g bs.ctx matches -2147483647 run return 10

scoreboard players set #l bs.ctx 0
execute store result score #raycast.start10 bs.data run scoreboard players operation #l bs.ctx -= #g bs.ctx
execute store result score #l bs.ctx run compute default integer bs.raycast:_pierce/grow
execute store result score #raycast.end10 bs.data run function bs.raycast:pierce/grow
execute if score #g bs.ctx matches -2147483647 run return 11

scoreboard players set #l bs.ctx 0
execute store result score #raycast.start11 bs.data run scoreboard players operation #l bs.ctx -= #g bs.ctx
execute store result score #l bs.ctx run compute default integer bs.raycast:_pierce/grow
execute store result score #raycast.end11 bs.data run function bs.raycast:pierce/grow
execute if score #g bs.ctx matches -2147483647 run return 12

scoreboard players set #l bs.ctx 0
execute store result score #raycast.start12 bs.data run scoreboard players operation #l bs.ctx -= #g bs.ctx
execute store result score #l bs.ctx run compute default integer bs.raycast:_pierce/grow
execute store result score #raycast.end12 bs.data run function bs.raycast:pierce/grow
execute if score #g bs.ctx matches -2147483647 run return 13

scoreboard players set #l bs.ctx 0
execute store result score #raycast.start13 bs.data run scoreboard players operation #l bs.ctx -= #g bs.ctx
execute store result score #l bs.ctx run compute default integer bs.raycast:_pierce/grow
execute store result score #raycast.end13 bs.data run function bs.raycast:pierce/grow
execute if score #g bs.ctx matches -2147483647 run return 14

scoreboard players set #l bs.ctx 0
execute store result score #raycast.start14 bs.data run scoreboard players operation #l bs.ctx -= #g bs.ctx
execute store result score #l bs.ctx run compute default integer bs.raycast:_pierce/grow
execute store result score #raycast.end14 bs.data run function bs.raycast:pierce/grow
execute if score #g bs.ctx matches -2147483647 run return 15

scoreboard players set #l bs.ctx 0
execute store result score #raycast.start15 bs.data run scoreboard players operation #l bs.ctx -= #g bs.ctx
execute store result score #l bs.ctx run compute default integer bs.raycast:_pierce/grow
execute store result score #raycast.end15 bs.data run function bs.raycast:pierce/grow
execute if score #g bs.ctx matches -2147483647 run return 16

scoreboard players set #l bs.ctx 0
execute store result score #raycast.start16 bs.data run scoreboard players operation #l bs.ctx -= #g bs.ctx
execute store result score #l bs.ctx run compute default integer bs.raycast:_pierce/grow
execute store result score #raycast.end16 bs.data run function bs.raycast:pierce/grow
execute if score #g bs.ctx matches -2147483647 run return 17

scoreboard players set #l bs.ctx 0
execute store result score #raycast.start17 bs.data run scoreboard players operation #l bs.ctx -= #g bs.ctx
execute store result score #l bs.ctx run compute default integer bs.raycast:_pierce/grow
execute store result score #raycast.end17 bs.data run function bs.raycast:pierce/grow
execute if score #g bs.ctx matches -2147483647 run return 18

scoreboard players set #l bs.ctx 0
execute store result score #raycast.start18 bs.data run scoreboard players operation #l bs.ctx -= #g bs.ctx
execute store result score #l bs.ctx run compute default integer bs.raycast:_pierce/grow
execute store result score #raycast.end18 bs.data run function bs.raycast:pierce/grow
execute if score #g bs.ctx matches -2147483647 run return 19

scoreboard players set #l bs.ctx 0
execute store result score #raycast.start19 bs.data run scoreboard players operation #l bs.ctx -= #g bs.ctx
execute store result score #l bs.ctx run compute default integer bs.raycast:_pierce/grow
execute store result score #raycast.end19 bs.data run function bs.raycast:pierce/grow
execute if score #g bs.ctx matches -2147483647 run return 20

scoreboard players set #l bs.ctx 0
execute store result score #raycast.start20 bs.data run scoreboard players operation #l bs.ctx -= #g bs.ctx
execute store result score #l bs.ctx run compute default integer bs.raycast:_pierce/grow
execute store result score #raycast.end20 bs.data run function bs.raycast:pierce/grow
execute if score #g bs.ctx matches -2147483647 run return 21

scoreboard players set #l bs.ctx 0
execute store result score #raycast.start21 bs.data run scoreboard players operation #l bs.ctx -= #g bs.ctx
execute store result score #l bs.ctx run compute default integer bs.raycast:_pierce/grow
execute store result score #raycast.end21 bs.data run function bs.raycast:pierce/grow
execute if score #g bs.ctx matches -2147483647 run return 22

scoreboard players set #l bs.ctx 0
execute store result score #raycast.start22 bs.data run scoreboard players operation #l bs.ctx -= #g bs.ctx
execute store result score #l bs.ctx run compute default integer bs.raycast:_pierce/grow
execute store result score #raycast.end22 bs.data run function bs.raycast:pierce/grow
execute if score #g bs.ctx matches -2147483647 run return 23

scoreboard players set #l bs.ctx 0
execute store result score #raycast.start23 bs.data run scoreboard players operation #l bs.ctx -= #g bs.ctx
execute store result score #l bs.ctx run compute default integer bs.raycast:_pierce/grow
execute store result score #raycast.end23 bs.data run function bs.raycast:pierce/grow
return 24

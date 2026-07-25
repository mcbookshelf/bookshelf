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

fill ~-1 ~ ~-1 ~1 ~1 ~1 minecraft:air
setblock ~-1 ~ ~-1 minecraft:bookshelf
summon minecraft:interaction ~-.5 ~ ~-.5
execute store result score #packtest.on_targeted_block bs.data run scoreboard players set #packtest.on_targeted_entity bs.data 0
execute positioned ~.5 ~1 ~.5 facing ~-.51 ~-1.01 ~-1.49 run function #bs.raycast:run {with:{blocks:true,entities:true,piercing:1,on_targeted_block:"scoreboard players add #packtest.on_targeted_block bs.data 1",on_targeted_entity:"scoreboard players add #packtest.on_targeted_entity bs.data 1"}}
assert score #packtest.on_targeted_block bs.data matches 1
assert score #packtest.on_targeted_entity bs.data matches 1
execute store result score #packtest.on_targeted_block bs.data run scoreboard players set #packtest.on_targeted_entity bs.data 0
execute positioned ~.5 ~1 ~.5 facing ~-1.49 ~-1.01 ~-.51 run function #bs.raycast:run {with:{blocks:true,entities:true,piercing:1,on_targeted_block:"scoreboard players add #packtest.on_targeted_block bs.data 1",on_targeted_entity:"scoreboard players add #packtest.on_targeted_entity bs.data 1"}}
assert score #packtest.on_targeted_block bs.data matches 1
assert score #packtest.on_targeted_entity bs.data matches 1

kill @e[type=minecraft:interaction,distance=..2]
fill ~-1 ~ ~-1 ~1 ~1 ~1 minecraft:air
setblock ~-1 ~ ~1 minecraft:bookshelf
summon minecraft:interaction ~-.5 ~ ~1.5
execute store result score #packtest.on_targeted_block bs.data run scoreboard players set #packtest.on_targeted_entity bs.data 0
execute positioned ~.5 ~1 ~.5 facing ~-.51 ~-1.01 ~1.49 run function #bs.raycast:run {with:{blocks:true,entities:true,piercing:1,on_targeted_block:"scoreboard players add #packtest.on_targeted_block bs.data 1",on_targeted_entity:"scoreboard players add #packtest.on_targeted_entity bs.data 1"}}
assert score #packtest.on_targeted_block bs.data matches 1
assert score #packtest.on_targeted_entity bs.data matches 1
execute store result score #packtest.on_targeted_block bs.data run scoreboard players set #packtest.on_targeted_entity bs.data 0
execute positioned ~.5 ~1 ~.5 facing ~-1.49 ~-1.01 ~.51 run function #bs.raycast:run {with:{blocks:true,entities:true,piercing:1,on_targeted_block:"scoreboard players add #packtest.on_targeted_block bs.data 1",on_targeted_entity:"scoreboard players add #packtest.on_targeted_entity bs.data 1"}}
assert score #packtest.on_targeted_block bs.data matches 1
assert score #packtest.on_targeted_entity bs.data matches 1

kill @e[type=minecraft:interaction,distance=..2]
fill ~-1 ~ ~-1 ~1 ~1 ~1 minecraft:air
setblock ~1 ~ ~-1 minecraft:bookshelf
summon minecraft:interaction ~1.5 ~ ~-.5
execute store result score #packtest.on_targeted_block bs.data run scoreboard players set #packtest.on_targeted_entity bs.data 0
execute positioned ~.5 ~1 ~.5 facing ~.51 ~-1.01 ~-1.49 run function #bs.raycast:run {with:{blocks:true,entities:true,piercing:1,on_targeted_block:"scoreboard players add #packtest.on_targeted_block bs.data 1",on_targeted_entity:"scoreboard players add #packtest.on_targeted_entity bs.data 1"}}
assert score #packtest.on_targeted_block bs.data matches 1
assert score #packtest.on_targeted_entity bs.data matches 1
execute store result score #packtest.on_targeted_block bs.data run scoreboard players set #packtest.on_targeted_entity bs.data 0
execute positioned ~.5 ~1 ~.5 facing ~1.49 ~-1.01 ~-.51 run function #bs.raycast:run {with:{blocks:true,entities:true,piercing:1,on_targeted_block:"scoreboard players add #packtest.on_targeted_block bs.data 1",on_targeted_entity:"scoreboard players add #packtest.on_targeted_entity bs.data 1"}}
assert score #packtest.on_targeted_block bs.data matches 1
assert score #packtest.on_targeted_entity bs.data matches 1

kill @e[type=minecraft:interaction,distance=..2]
fill ~-1 ~ ~-1 ~1 ~1 ~1 minecraft:air
setblock ~1 ~ ~1 minecraft:bookshelf
summon minecraft:interaction ~1.5 ~ ~1.5
execute store result score #packtest.on_targeted_block bs.data run scoreboard players set #packtest.on_targeted_entity bs.data 0
execute positioned ~.5 ~1 ~.5 facing ~.51 ~-1.01 ~1.49 run function #bs.raycast:run {with:{blocks:true,entities:true,piercing:1,on_targeted_block:"scoreboard players add #packtest.on_targeted_block bs.data 1",on_targeted_entity:"scoreboard players add #packtest.on_targeted_entity bs.data 1"}}
assert score #packtest.on_targeted_block bs.data matches 1
assert score #packtest.on_targeted_entity bs.data matches 1
execute store result score #packtest.on_targeted_block bs.data run scoreboard players set #packtest.on_targeted_entity bs.data 0
execute positioned ~.5 ~1 ~.5 facing ~1.49 ~-1.01 ~.51 run function #bs.raycast:run {with:{blocks:true,entities:true,piercing:1,on_targeted_block:"scoreboard players add #packtest.on_targeted_block bs.data 1",on_targeted_entity:"scoreboard players add #packtest.on_targeted_entity bs.data 1"}}
assert score #packtest.on_targeted_block bs.data matches 1
assert score #packtest.on_targeted_entity bs.data matches 1

kill @e[type=minecraft:interaction,distance=..2]
fill ~-1 ~ ~-1 ~1 ~1 ~1 minecraft:air
setblock ~-1 ~ ~-1 minecraft:bookshelf
summon minecraft:interaction ~-.5 ~ ~-.5
execute store result score #packtest.on_targeted_block bs.data run scoreboard players set #packtest.on_targeted_entity bs.data 0
execute positioned ~.5 ~ ~.5 facing ~-.51 ~.99 ~-1.49 run function #bs.raycast:run {with:{blocks:true,entities:true,piercing:1,on_targeted_block:"scoreboard players add #packtest.on_targeted_block bs.data 1",on_targeted_entity:"scoreboard players add #packtest.on_targeted_entity bs.data 1"}}
assert score #packtest.on_targeted_block bs.data matches 1
assert score #packtest.on_targeted_entity bs.data matches 1
execute store result score #packtest.on_targeted_block bs.data run scoreboard players set #packtest.on_targeted_entity bs.data 0
execute positioned ~.5 ~ ~.5 facing ~-1.49 ~.99 ~-.51 run function #bs.raycast:run {with:{blocks:true,entities:true,piercing:1,on_targeted_block:"scoreboard players add #packtest.on_targeted_block bs.data 1",on_targeted_entity:"scoreboard players add #packtest.on_targeted_entity bs.data 1"}}
assert score #packtest.on_targeted_block bs.data matches 1
assert score #packtest.on_targeted_entity bs.data matches 1

kill @e[type=minecraft:interaction,distance=..2]
fill ~-1 ~ ~-1 ~1 ~1 ~1 minecraft:air
setblock ~-1 ~ ~1 minecraft:bookshelf
summon minecraft:interaction ~-.5 ~ ~1.5
execute store result score #packtest.on_targeted_block bs.data run scoreboard players set #packtest.on_targeted_entity bs.data 0
execute positioned ~.5 ~ ~.5 facing ~-.51 ~.99 ~1.49 run function #bs.raycast:run {with:{blocks:true,entities:true,piercing:1,on_targeted_block:"scoreboard players add #packtest.on_targeted_block bs.data 1",on_targeted_entity:"scoreboard players add #packtest.on_targeted_entity bs.data 1"}}
assert score #packtest.on_targeted_block bs.data matches 1
assert score #packtest.on_targeted_entity bs.data matches 1
execute store result score #packtest.on_targeted_block bs.data run scoreboard players set #packtest.on_targeted_entity bs.data 0
execute positioned ~.5 ~ ~.5 facing ~-1.49 ~.99 ~.51 run function #bs.raycast:run {with:{blocks:true,entities:true,piercing:1,on_targeted_block:"scoreboard players add #packtest.on_targeted_block bs.data 1",on_targeted_entity:"scoreboard players add #packtest.on_targeted_entity bs.data 1"}}
assert score #packtest.on_targeted_block bs.data matches 1
assert score #packtest.on_targeted_entity bs.data matches 1

kill @e[type=minecraft:interaction,distance=..2]
fill ~-1 ~ ~-1 ~1 ~1 ~1 minecraft:air
setblock ~1 ~ ~-1 minecraft:bookshelf
summon minecraft:interaction ~1.5 ~ ~-.5
execute store result score #packtest.on_targeted_block bs.data run scoreboard players set #packtest.on_targeted_entity bs.data 0
execute positioned ~.5 ~ ~.5 facing ~.51 ~.99 ~-1.49 run function #bs.raycast:run {with:{blocks:true,entities:true,piercing:1,on_targeted_block:"scoreboard players add #packtest.on_targeted_block bs.data 1",on_targeted_entity:"scoreboard players add #packtest.on_targeted_entity bs.data 1"}}
assert score #packtest.on_targeted_block bs.data matches 1
assert score #packtest.on_targeted_entity bs.data matches 1
execute store result score #packtest.on_targeted_block bs.data run scoreboard players set #packtest.on_targeted_entity bs.data 0
execute positioned ~.5 ~ ~.5 facing ~1.49 ~.99 ~-.51 run function #bs.raycast:run {with:{blocks:true,entities:true,piercing:1,on_targeted_block:"scoreboard players add #packtest.on_targeted_block bs.data 1",on_targeted_entity:"scoreboard players add #packtest.on_targeted_entity bs.data 1"}}
assert score #packtest.on_targeted_block bs.data matches 1
assert score #packtest.on_targeted_entity bs.data matches 1

kill @e[type=minecraft:interaction,distance=..2]
fill ~-1 ~ ~-1 ~1 ~1 ~1 minecraft:air
setblock ~1 ~ ~1 minecraft:bookshelf
summon minecraft:interaction ~1.5 ~ ~1.5
execute store result score #packtest.on_targeted_block bs.data run scoreboard players set #packtest.on_targeted_entity bs.data 0
execute positioned ~.5 ~ ~.5 facing ~.51 ~.99 ~1.49 run function #bs.raycast:run {with:{blocks:true,entities:true,piercing:1,on_targeted_block:"scoreboard players add #packtest.on_targeted_block bs.data 1",on_targeted_entity:"scoreboard players add #packtest.on_targeted_entity bs.data 1"}}
assert score #packtest.on_targeted_block bs.data matches 1
assert score #packtest.on_targeted_entity bs.data matches 1
execute store result score #packtest.on_targeted_block bs.data run scoreboard players set #packtest.on_targeted_entity bs.data 0
execute positioned ~.5 ~ ~.5 facing ~1.49 ~.99 ~.51 run function #bs.raycast:run {with:{blocks:true,entities:true,piercing:1,on_targeted_block:"scoreboard players add #packtest.on_targeted_block bs.data 1",on_targeted_entity:"scoreboard players add #packtest.on_targeted_entity bs.data 1"}}
assert score #packtest.on_targeted_block bs.data matches 1
assert score #packtest.on_targeted_entity bs.data matches 1

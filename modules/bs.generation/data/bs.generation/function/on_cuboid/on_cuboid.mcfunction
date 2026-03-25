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

data modify storage bs:data generation append value {psr:"bs.generation:process/on_cuboid/resume"}
data modify storage bs:data generation[-1].run set from storage bs:in generation.on_cuboid.run
data modify storage bs:data generation[-1].onf set from storage bs:in generation.on_cuboid.on_finished

execute unless data storage bs:in generation.on_cuboid.direction run data modify storage bs:in generation.on_cuboid.direction set value "eus"
execute unless data storage bs:in generation.on_cuboid.limit run data modify storage bs:in generation.on_cuboid.limit set value 256
execute unless data storage bs:in generation.on_cuboid.spacing run data modify storage bs:in generation.on_cuboid.spacing set value 1
execute unless data storage bs:in generation.on_cuboid.width run data modify storage bs:in generation.on_cuboid.width set value 1
execute unless data storage bs:in generation.on_cuboid.height run data modify storage bs:in generation.on_cuboid.height set value 1
execute unless data storage bs:in generation.on_cuboid.depth run data modify storage bs:in generation.on_cuboid.depth set value 1

execute store result storage bs:data generation[-1].w int 1 store result score #generation.w bs.data run data get storage bs:in generation.on_cuboid.width
execute store result storage bs:data generation[-1].h int 1 store result score #generation.h bs.data run data get storage bs:in generation.on_cuboid.height
execute store result storage bs:data generation[-1].d int 1 store result score #generation.d bs.data run data get storage bs:in generation.on_cuboid.depth
execute store result storage bs:data generation[-1].n int 1 store result score #generation.i bs.data run data get storage bs:in generation.on_cuboid.limit
execute store result score $generation.i bs.lambda store result score $generation.j bs.lambda run scoreboard players set $generation.k bs.lambda 0

data modify storage bs:ctx _ set string storage bs:in generation.on_cuboid.direction 0 1
function bs.generation:utils/get_direction with storage bs:ctx
data modify storage bs:data generation[-1].0 set from storage bs:ctx _
data modify storage bs:ctx _ set string storage bs:in generation.on_cuboid.direction 1 2
function bs.generation:utils/get_direction with storage bs:ctx
data modify storage bs:data generation[-1].1 set from storage bs:ctx _
data modify storage bs:ctx _ set string storage bs:in generation.on_cuboid.direction 2 3
function bs.generation:utils/get_direction with storage bs:ctx
data modify storage bs:data generation[-1].2 set from storage bs:ctx _

execute align xyz summon marker run function bs.generation:on_cuboid/recurse/init with storage bs:data generation[-1]
data remove storage bs:data generation[-1]

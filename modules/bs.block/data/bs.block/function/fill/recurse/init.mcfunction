# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2024 Gunivers
#
# This file is part of the Bookshelf project (https://github.com/mcbookshelf/Bookshelf).
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

execute unless data storage bs:data block._.from[2] run function bs.block:utils/resolve_from_pos with storage bs:data block._
execute unless data storage bs:data block._.to[2] run function bs.block:utils/resolve_to_pos with storage bs:data block._

execute store result score #block.i bs.data run data get storage bs:data block._.limit
execute store result score #block.min_x bs.data run data get storage bs:data block._.from[0]
execute store result score #block.min_y bs.data run data get storage bs:data block._.from[1]
execute store result score #block.min_z bs.data run data get storage bs:data block._.from[2]
execute store result score #block.max_x bs.data run data get storage bs:data block._.to[0]
execute store result score #block.max_y bs.data run data get storage bs:data block._.to[1]
execute store result score #block.max_z bs.data run data get storage bs:data block._.to[2]
execute if score #block.min_x bs.data > #block.max_x bs.data run scoreboard players operation #block.min_x bs.data >< #block.max_x bs.data
execute if score #block.min_y bs.data > #block.max_y bs.data run scoreboard players operation #block.min_y bs.data >< #block.max_y bs.data
execute if score #block.min_z bs.data > #block.max_z bs.data run scoreboard players operation #block.min_z bs.data >< #block.max_z bs.data
execute store result storage bs:data block._.min_x int 1 store result storage bs:data block._.pos[0] double 1 store result score #block.x bs.data run scoreboard players get #block.min_x bs.data
execute store result storage bs:data block._.min_y int 1 store result storage bs:data block._.pos[1] double 1 store result score #block.y bs.data run scoreboard players get #block.min_y bs.data
execute store result storage bs:data block._.min_z int 1 store result storage bs:data block._.pos[2] double 1 store result score #block.z bs.data run scoreboard players get #block.min_z bs.data
execute store result storage bs:data block._.max_x int 1 run scoreboard players get #block.max_x bs.data
execute store result storage bs:data block._.max_y int 1 run scoreboard players get #block.max_y bs.data
execute store result storage bs:data block._.max_z int 1 run scoreboard players get #block.max_z bs.data

data modify entity @s Pos set from storage bs:data block._.pos
execute positioned as @s run function bs.block:fill/recurse/next with storage bs:data block._
kill @s

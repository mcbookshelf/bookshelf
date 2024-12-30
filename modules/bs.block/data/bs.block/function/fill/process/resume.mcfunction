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

data modify storage bs:data block._ set from storage bs:data block.fill[-1]
data remove storage bs:data block._._

data modify entity @s Pos set from storage bs:data block._.pos
data modify entity @s Rotation set from storage bs:data block._.rot

execute store result score #block.x bs.data run data get storage bs:data block._.pos[0]
execute store result score #block.y bs.data run data get storage bs:data block._.pos[1]
execute store result score #block.z bs.data run data get storage bs:data block._.pos[2]
execute store result score #block.i bs.data run data get storage bs:data block._.limit
execute store result score #block.min_x bs.data run data get storage bs:data block._.min_x
execute store result score #block.min_y bs.data run data get storage bs:data block._.min_y
execute store result score #block.min_z bs.data run data get storage bs:data block._.min_z
execute store result score #block.max_x bs.data run data get storage bs:data block._.max_x
execute store result score #block.max_y bs.data run data get storage bs:data block._.max_y
execute store result score #block.max_z bs.data run data get storage bs:data block._.max_z

$execute in $(dim) positioned as @s rotated as @s run function bs.block:fill/recurse/next with storage bs:data block._

data remove storage bs:data block.fill[-1]
execute if data storage bs:data block.fill[-1]._ \
  run return run function bs.block:fill/process/resume with storage bs:data block.fill[-1]

execute in minecraft:overworld run tp @s -30000000 0 1600

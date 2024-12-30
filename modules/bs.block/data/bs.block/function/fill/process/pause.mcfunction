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

execute store result storage bs:data block._.pos[0] double 1 run scoreboard players get #block.x bs.data
execute store result storage bs:data block._.pos[1] double 1 run scoreboard players get #block.y bs.data
execute store result storage bs:data block._.pos[2] double 1 run scoreboard players get #block.z bs.data

execute unless data storage bs:data block._.dim run function bs.block:utils/get_dimension
execute unless data storage bs:data block._.rot run data modify storage bs:data block._.rot set from entity @s Rotation

data modify storage bs:data block.fill prepend from storage bs:data block._
schedule function bs.block:fill/process/scheduled 1t replace

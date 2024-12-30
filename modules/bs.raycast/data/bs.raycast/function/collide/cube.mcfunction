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

# compute the travelled distance
scoreboard players operation #raycast.lx bs.data -= #raycast.dx bs.data
scoreboard players operation #raycast.ly bs.data -= #raycast.dy bs.data
execute store result score #raycast.distance bs.data run scoreboard players operation #raycast.lz bs.data -= #raycast.dz bs.data
scoreboard players operation #raycast.distance bs.data > #raycast.lx bs.data
scoreboard players operation #raycast.distance bs.data > #raycast.ly bs.data

# get the normal of the surface that was hit
data modify storage bs:out raycast.hit_normal set value [0,0,0]
execute if score #raycast.distance bs.data = #raycast.lx bs.data store result storage bs:out raycast.hit_normal[0] int -1 run data get storage bs:data raycast.sx
execute if score #raycast.distance bs.data = #raycast.ly bs.data store result storage bs:out raycast.hit_normal[1] int -1 run data get storage bs:data raycast.sy
execute if score #raycast.distance bs.data = #raycast.lz bs.data store result storage bs:out raycast.hit_normal[2] int -1 run data get storage bs:data raycast.sz

scoreboard players operation #raycast.lx bs.data += #raycast.dx bs.data
scoreboard players operation #raycast.ly bs.data += #raycast.dy bs.data
scoreboard players operation #raycast.lz bs.data += #raycast.dz bs.data

function bs.raycast:collide/block

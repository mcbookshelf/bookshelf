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

# stop the recursion then get the travelled distance
scoreboard players operation #raycast.distance bs.data = #raycast.tmin bs.data

# get the normal of the surface that was hit
data modify storage bs:out raycast.hit_normal set value [0,0,0]
execute if score #raycast.distance bs.data = #x bs.ctx store result storage bs:out raycast.hit_normal[0] int -1 run data get storage bs:data raycast.sx
execute if score #raycast.distance bs.data = #y bs.ctx store result storage bs:out raycast.hit_normal[1] int -1 run data get storage bs:data raycast.sy
execute if score #raycast.distance bs.data = #z bs.ctx store result storage bs:out raycast.hit_normal[2] int -1 run data get storage bs:data raycast.sz

function bs.raycast:collide/entity

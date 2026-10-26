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

data modify storage bs.animation: _ set value {k:0,r:3,i:0,t:0f}
data modify storage bs.animation: _.p0 set from storage bs.animation:attach in.points
data modify storage bs.animation: _.d0 set from storage bs.animation:attach in.duration

execute store result score #n bs.ctx run data get storage bs.animation: _.p0
execute if data storage bs.animation: _.d0[0] store result storage bs.animation: _.n int 1 run data get storage bs.animation: _.d0

execute store result storage bs.animation: _.n int 1 run return run compute default integer {type:max,inputs:[{type:min,inputs:[{type:floor_div,left:{type:sub,left:{type:score,target:{type:fixed,name:"#n"},score:"bs.ctx"},right:1},right:3},{type:storage,storage:"bs.animation:",path:"_.n",fallback:2147483647}]},0]}

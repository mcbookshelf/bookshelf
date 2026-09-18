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

data modify storage bs.animation: _ set value {k:2,r:1,i:0,t:0f}
data modify storage bs.animation: _.p0 set from storage bs.animation:attach in.points
data modify storage bs.animation: _.d0 set from storage bs.animation:attach in.duration

execute store result score #n bs.ctx run data get storage bs.animation: _.p0
execute if data storage bs.animation: _.d0[0] store result storage bs.animation: _.n int 1 run data get storage bs.animation: _.d0

data modify storage bs.animation: _.p0 prepend value []
execute if data storage bs.animation: _.p0[1][0] run data modify storage bs.animation: _.p0[0] append compute default float {type:sub,left:{type:mul,inputs:[2.0,{type:storage,storage:"bs.animation:",path:"_.p0[1][0]"}]},right:{type:storage,storage:"bs.animation:",path:"_.p0[2][0]"}}
execute if data storage bs.animation: _.p0[1][1] run data modify storage bs.animation: _.p0[0] append compute default float {type:sub,left:{type:mul,inputs:[2.0,{type:storage,storage:"bs.animation:",path:"_.p0[1][1]"}]},right:{type:storage,storage:"bs.animation:",path:"_.p0[2][1]"}}
execute if data storage bs.animation: _.p0[1][2] run data modify storage bs.animation: _.p0[0] append compute default float {type:sub,left:{type:mul,inputs:[2.0,{type:storage,storage:"bs.animation:",path:"_.p0[1][2]"}]},right:{type:storage,storage:"bs.animation:",path:"_.p0[2][2]"}}
execute if data storage bs.animation: _.p0[1][3] run data modify storage bs.animation: _.p0[0] append compute default float {type:sub,left:{type:mul,inputs:[2.0,{type:storage,storage:"bs.animation:",path:"_.p0[1][3]"}]},right:{type:storage,storage:"bs.animation:",path:"_.p0[2][3]"}}

data modify storage bs.animation: _.p0 append value []
execute if data storage bs.animation: _.p0[-2][0] run data modify storage bs.animation: _.p0[-1] append compute default float {type:sub,left:{type:mul,inputs:[2.0,{type:storage,storage:"bs.animation:",path:"_.p0[-2][0]"}]},right:{type:storage,storage:"bs.animation:",path:"_.p0[-3][0]"}}
execute if data storage bs.animation: _.p0[-2][1] run data modify storage bs.animation: _.p0[-1] append compute default float {type:sub,left:{type:mul,inputs:[2.0,{type:storage,storage:"bs.animation:",path:"_.p0[-2][1]"}]},right:{type:storage,storage:"bs.animation:",path:"_.p0[-3][1]"}}
execute if data storage bs.animation: _.p0[-2][2] run data modify storage bs.animation: _.p0[-1] append compute default float {type:sub,left:{type:mul,inputs:[2.0,{type:storage,storage:"bs.animation:",path:"_.p0[-2][2]"}]},right:{type:storage,storage:"bs.animation:",path:"_.p0[-3][2]"}}
execute if data storage bs.animation: _.p0[-2][3] run data modify storage bs.animation: _.p0[-1] append compute default float {type:sub,left:{type:mul,inputs:[2.0,{type:storage,storage:"bs.animation:",path:"_.p0[-2][3]"}]},right:{type:storage,storage:"bs.animation:",path:"_.p0[-3][3]"}}

execute store result storage bs.animation: _.n int 1 run return run compute default integer {type:max,inputs:[{type:min,inputs:[{type:sub,left:{type:score,target:{type:fixed,name:"#n"},score:"bs.ctx"},right:1},{type:storage,storage:"bs.animation:",path:"_.n",fallback:2147483647}]},0]}

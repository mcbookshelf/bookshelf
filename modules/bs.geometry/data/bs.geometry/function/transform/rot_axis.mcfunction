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

data modify storage bs:out geometry.rot_axis set value {}

#this function accept an array of 2shapes as input
execute if function bs.geometry:error/2array run return fail

#a point and a coord space
execute if function bs.geometry:error/need_point run return fail
execute if function bs.geometry:error/need_coord_space run return fail

#set output
data modify storage bs:out geometry.rot_axis set value {type:"point",coord_type:"cartesian",origin:[0,0,0]}

#compute (p-o)
data modify storage bs:ctx x set compute default float {type:"sub",left:{type:"storage",path:'geometry.shapes[{type:"point"}].origin[0]',storage:"bs:in"},right:{type:"storage",path:'geometry.shapes[{type:"coord_space"}].origin[0]',storage:"bs:in"}}
data modify storage bs:ctx y set compute default float {type:"sub",left:{type:"storage",path:'geometry.shapes[{type:"point"}].origin[1]',storage:"bs:in"},right:{type:"storage",path:'geometry.shapes[{type:"coord_space"}].origin[1]',storage:"bs:in"}}
data modify storage bs:ctx z set compute default float {type:"sub",left:{type:"storage",path:'geometry.shapes[{type:"point"}].origin[2]',storage:"bs:in"},right:{type:"storage",path:'geometry.shapes[{type:"coord_space"}].origin[2]',storage:"bs:in"}}

#compute i.(p-o)
data modify storage bs:out geometry.rot_axis.origin[0] set compute default float {\
    type:"add",\
    inputs:[\
        {type:"mul",inputs:[{type:"storage",path:'x',storage:"bs:in"},{type:"storage",path:'geometry.shapes[{type:"coord_space"}].i[0]',storage:"bs:in"}]},\
        {type:"mul",inputs:[{type:"storage",path:'y',storage:"bs:in"},{type:"storage",path:'geometry.shapes[{type:"coord_space"}].i[1]',storage:"bs:in"}]},\
        {type:"mul",inputs:[{type:"storage",path:'z',storage:"bs:in"},{type:"storage",path:'geometry.shapes[{type:"coord_space"}].i[2]',storage:"bs:in"}]}\
    ]\
}

#compute j.(p-o)
data modify storage bs:out geometry.rot_axis.origin[1] set compute default float {\
    type:"add",\
    inputs:[\
        {type:"mul",inputs:[{type:"storage",path:'x',storage:"bs:in"},{type:"storage",path:'geometry.shapes[{type:"coord_space"}].j[0]',storage:"bs:in"}]},\
        {type:"mul",inputs:[{type:"storage",path:'y',storage:"bs:in"},{type:"storage",path:'geometry.shapes[{type:"coord_space"}].j[1]',storage:"bs:in"}]},\
        {type:"mul",inputs:[{type:"storage",path:'z',storage:"bs:in"},{type:"storage",path:'geometry.shapes[{type:"coord_space"}].j[2]',storage:"bs:in"}]}\
    ]\
}

#compute k.(p-o)
data modify storage bs:out geometry.rot_axis.origin[2] set compute default float {\
    type:"add",\
    inputs:[\
        {type:"mul",inputs:[{type:"storage",path:'x',storage:"bs:in"},{type:"storage",path:'geometry.shapes[{type:"coord_space"}].k[0]',storage:"bs:in"}]},\
        {type:"mul",inputs:[{type:"storage",path:'y',storage:"bs:in"},{type:"storage",path:'geometry.shapes[{type:"coord_space"}].k[1]',storage:"bs:in"}]},\
        {type:"mul",inputs:[{type:"storage",path:'z',storage:"bs:in"},{type:"storage",path:'geometry.shapes[{type:"coord_space"}].k[2]',storage:"bs:in"}]}\
    ]\
}

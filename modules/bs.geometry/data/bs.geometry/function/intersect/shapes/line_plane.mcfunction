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

#compute dot product of the normal vector of the plane and the director vector of the line n.v

#compute n.v
data modify storage bs.geometry: ctx.a set compute default float {\
    type:"add",inputs:[\
        {type:"mul",inputs:[{type:"storage",path:'shapes[{type:"plane"}].k[0]',storage:"bs.geometry:"},{type:"storage",path:'shapes[{type:"line"}].k[0]',storage:"bs.geometry:"}]},\
        {type:"mul",inputs:[{type:"storage",path:'shapes[{type:"plane"}].k[1]',storage:"bs.geometry:"},{type:"storage",path:'shapes[{type:"line"}].k[1]',storage:"bs.geometry:"}]},\
        {type:"mul",inputs:[{type:"storage",path:'shapes[{type:"plane"}].k[2]',storage:"bs.geometry:"},{type:"storage",path:'shapes[{type:"line"}].k[2]',storage:"bs.geometry:"}]}\
    ]\
}

#compute n.(o-o')
data modify storage bs.geometry: ctx.c set compute default float {\
    type:"add",inputs:[\
        {type:"mul",inputs:[{type:"storage",path:'shapes[{type:"plane"}].k[0]',storage:"bs.geometry:"},{type:"sub",left:{type:"storage",path:'shapes[{type:"plane"}].origin[0]',storage:"bs.geometry:"},right:{type:"storage",path:'shapes[{type:"line"}].origin[0]',storage:"bs.geometry:"}}]},\
        {type:"mul",inputs:[{type:"storage",path:'shapes[{type:"plane"}].k[1]',storage:"bs.geometry:"},{type:"sub",left:{type:"storage",path:'shapes[{type:"plane"}].origin[1]',storage:"bs.geometry:"},right:{type:"storage",path:'shapes[{type:"line"}].origin[1]',storage:"bs.geometry:"}}]},\
        {type:"mul",inputs:[{type:"storage",path:'shapes[{type:"plane"}].k[2]',storage:"bs.geometry:"},{type:"sub",left:{type:"storage",path:'shapes[{type:"plane"}].origin[2]',storage:"bs.geometry:"},right:{type:"storage",path:'shapes[{type:"line"}].origin[2]',storage:"bs.geometry:"}}]}\
    ]\
}

#check if the line is included in the plane (n.v)
execute if predicate {type:"float_value_check",value:{type:"storage",storage:"bs.geometry:",path:"ctx.a"},test:{min:-0.0001,max:0.0001}} if predicate {type:"float_value_check",value:{type:"storage",storage:"bs.geometry:",path:"ctx.c"},test:{min:-0.0001,max:0.0001}} run return run data modify storage bs.geometry:intersect out append from storage bs.geometry: shapes[{type:"line"}]
#check if the line is'nt included in the plane (n.v) and colinear
execute if predicate {type:"float_value_check",value:{type:"storage",storage:"bs.geometry:",path:"ctx.a"},test:{min:-0.0001,max:0.0001}} unless predicate {type:"float_value_check",value:{type:"storage",storage:"bs.geometry:",path:"ctx.c"},test:{min:-0.0001,max:0.0001}} run return run function bs.geometry:__internal__/error/none_intersection

#Compute the value of the parameter of the axis n.(o-o')/n.v
data modify storage bs.geometry: ctx.c set compute default float {type:"div",left:{type:"storage",storage:"bs.geometry:",path:"ctx.c"},right:{type:"storage",storage:"bs.geometry:",path:"ctx.a"}}

#compute the pos of the intersection o'+v(n.(o-o')/n.v)
data modify storage bs.geometry:intersect out append value {type:"point",coord_type:"cartesian",origin:[0d,0d,0d]}
data modify storage bs.geometry:intersect out[-1].origin[0] set compute default float {\
    type:"add",inputs:[\
        {type:"storage",path:'shapes[{type:"line"}].origin[0]',storage:"bs.geometry:"},\
        {type:"mul",inputs:[{type:"storage",storage:"bs.geometry:",path:"ctx.c"},{type:"storage",path:'shapes[{type:"line"}].k[0]',storage:"bs.geometry:"}]}\
    ]\
}
data modify storage bs.geometry:intersect out[-1].origin[1] set compute default float {\
    type:"add",inputs:[\
        {type:"storage",path:'shapes[{type:"line"}].origin[1]',storage:"bs.geometry:"},\
        {type:"mul",inputs:[{type:"storage",storage:"bs.geometry:",path:"ctx.c"},{type:"storage",path:'shapes[{type:"line"}].k[1]',storage:"bs.geometry:"}]}\
    ]\
}
data modify storage bs.geometry:intersect out[-1].origin[2] set compute default float {\
    type:"add",inputs:[\
        {type:"storage",path:'shapes[{type:"line"}].origin[2]',storage:"bs.geometry:"},\
        {type:"mul",inputs:[{type:"storage",storage:"bs.geometry:",path:"ctx.c"},{type:"storage",path:'shapes[{type:"line"}].k[2]',storage:"bs.geometry:"}]}\
    ]\
}

return 1

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

# L = (c-o)
data modify storage bs.geometry: ctx.l set compute default float {type:"sub",left:{type:"storage",path:'shapes[{type:"sphere"}].origin[0]',storage:"bs.geometry:"},right:{type:"storage",path:'shapes[{type:"line"}].origin[0]',storage:"bs.geometry:"}}
data modify storage bs.geometry: ctx.m set compute default float {type:"sub",left:{type:"storage",path:'shapes[{type:"sphere"}].origin[1]',storage:"bs.geometry:"},right:{type:"storage",path:'shapes[{type:"line"}].origin[1]',storage:"bs.geometry:"}}
data modify storage bs.geometry: ctx.n set compute default float {type:"sub",left:{type:"storage",path:'shapes[{type:"sphere"}].origin[2]',storage:"bs.geometry:"},right:{type:"storage",path:'shapes[{type:"line"}].origin[2]',storage:"bs.geometry:"}}

# tca = (L.v)
data modify storage bs.geometry: ctx.a set compute default float {\
    type:"add",inputs:[\
        {type:"mul",inputs:[{type:"storage",path:"ctx.l",storage:"bs.geometry:"},{type:"storage",path:'shapes[{type:"line"}].k[0]',storage:"bs.geometry:"}]}\
        ,{type:"mul",inputs:[{type:"storage",path:"ctx.m",storage:"bs.geometry:"},{type:"storage",path:'shapes[{type:"line"}].k[1]',storage:"bs.geometry:"}]}\
        ,{type:"mul",inputs:[{type:"storage",path:"ctx.n",storage:"bs.geometry:"},{type:"storage",path:'shapes[{type:"line"}].k[2]',storage:"bs.geometry:"}]}\
    ]\
}

#d² = ||L - v*tca||²
#thc = sqrt(r²-d²)
data modify storage bs.geometry: ctx.b set compute default float {\
    type:"sqrt",\
    input:{\
        type:"sub",\
        left:{\
            type:"pow",exponent:2,\
            base:{type:"storage",path:'shapes[{type:"sphere"}].radius',storage:"bs.geometry:"}\
        },\
        right:{\
            type:"add",inputs:[\
                {type:"pow",exponent:2,base:{type:"sub",left:{type:"storage",path:"ctx.l",storage:"bs.geometry:"},right:{type:"mul",inputs:[{type:"storage",path:"ctx.a",storage:"bs.geometry:"},{type:"storage",path:'shapes[{type:"line"}].k[0]',storage:"bs.geometry:"}]}}},\
                {type:"pow",exponent:2,base:{type:"sub",left:{type:"storage",path:"ctx.m",storage:"bs.geometry:"},right:{type:"mul",inputs:[{type:"storage",path:"ctx.a",storage:"bs.geometry:"},{type:"storage",path:'shapes[{type:"line"}].k[1]',storage:"bs.geometry:"}]}}},\
                {type:"pow",exponent:2,base:{type:"sub",left:{type:"storage",path:"ctx.n",storage:"bs.geometry:"},right:{type:"mul",inputs:[{type:"storage",path:"ctx.a",storage:"bs.geometry:"},{type:"storage",path:'shapes[{type:"line"}].k[2]',storage:"bs.geometry:"}]}}}\
            ]\
        }\
    }\
}

#check if there is none intersection
execute if predicate {type:"float_value_check",test:0f,value:{type:"storage",path:"ctx.b",storage:"bs.geometry:"}} run return run function bs.geometry:__internal__/error/none_intersection

#set output
data modify storage bs.geometry:intersect out append value {type:"point",coord_type:"cartesian",origin:[0d,0d,0d]}

#line parameter tca + thc
#o + v(tca+thc)

data modify storage bs.geometry: ctx.c set compute default float {type:"add",inputs:[{type:"storage",storage:"bs.geometry:",path:"ctx.a"},{type:"storage",storage:"bs.geometry:",path:"ctx.b"}]}

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

#check if there is only one intersection
execute if predicate {type:"float_value_check",value:{type:"storage",storage:"bs.geometry:",path:"ctx.b"},test:{min:-0.0001,max:0.0001}} run return 1

#set output
data modify storage bs.geometry:intersect out append value {type:"point",coord_type:"cartesian",origin:[0d,0d,0d]}

#line parameter tca - thc
data modify storage bs.geometry: ctx.c set compute default float {type:"sub",left:{type:"storage",storage:"bs.geometry:",path:"ctx.a"},right:{type:"storage",storage:"bs.geometry:",path:"ctx.b"}}

#v(tca-thc)
#o+v(tca-thc)
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

return 2

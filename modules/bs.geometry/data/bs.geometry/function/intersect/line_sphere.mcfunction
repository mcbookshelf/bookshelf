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


#get sphere parameters

# L = (c-o)
data modify storage bs:ctx l set compute default float {type:"sub",left:{type:"storage",path:'geometry.shapes[{type:"sphere"}].origin[0]',storage:"bs:in"},right:{type:"storage",path:'geometry.shapes[{type:"line"}].origin[0]',storage:"bs:in"}}
data modify storage bs:ctx m set compute default float {type:"sub",left:{type:"storage",path:'geometry.shapes[{type:"sphere"}].origin[1]',storage:"bs:in"},right:{type:"storage",path:'geometry.shapes[{type:"line"}].origin[1]',storage:"bs:in"}}
data modify storage bs:ctx n set compute default float {type:"sub",left:{type:"storage",path:'geometry.shapes[{type:"sphere"}].origin[2]',storage:"bs:in"},right:{type:"storage",path:'geometry.shapes[{type:"line"}].origin[2]',storage:"bs:in"}}

# tca = (L.v)
data modify storage bs:ctx a set compute default float {\
    type:"add",inputs:[\
        {type:"mul",inputs:[{type:"storage",path:'l',storage:"bs:ctx"},{type:"storage",path:'geometry.shapes[{type:"line"}].k[0]',storage:"bs:in"}]}\
        ,{type:"mul",inputs:[{type:"storage",path:'m',storage:"bs:ctx"},{type:"storage",path:'geometry.shapes[{type:"line"}].k[1]',storage:"bs:in"}]}\
        ,{type:"mul",inputs:[{type:"storage",path:'n',storage:"bs:ctx"},{type:"storage",path:'geometry.shapes[{type:"line"}].k[2]',storage:"bs:in"}]}\
    ]\
}

#d² = ||L - v*tca||²
#thc = sqrt(r²-d²)
data remove storage bs:ctx b
data modify storage bs:ctx b set compute default float {\
    type:"sqrt",\
    input:{\
        type:"sub",\
        left:{\
            type:"pow",exponent:2,\
            base:{type:"storage",path:'geometry.shapes[{type:"sphere"}].parameters[0]',storage:"bs:in"}\
        },\
        right:{\
            type:"add",inputs:[\
                {type:"pow",exponent:2,base:{type:"sub",left:{type:"storage",path:'l',storage:"bs:ctx"},right:{type:"mul",inputs:[{type:"storage",path:'a',storage:"bs:ctx"},{type:"storage",path:'geometry.shapes[{type:"line"}].k[0]',storage:"bs:in"}]}}},\
                {type:"pow",exponent:2,base:{type:"sub",left:{type:"storage",path:'m',storage:"bs:ctx"},right:{type:"mul",inputs:[{type:"storage",path:'a',storage:"bs:ctx"},{type:"storage",path:'geometry.shapes[{type:"line"}].k[1]',storage:"bs:in"}]}}},\
                {type:"pow",exponent:2,base:{type:"sub",left:{type:"storage",path:'n',storage:"bs:ctx"},right:{type:"mul",inputs:[{type:"storage",path:'a',storage:"bs:ctx"},{type:"storage",path:'geometry.shapes[{type:"line"}].k[2]',storage:"bs:in"}]}}}\
            ]\
        }\
    }\
}

#check if there is none intersection
execute unless data storage bs:ctx b run return run function bs.geometry:error/none_intersection

#set output
data modify storage bs:out geometry.intersect append value {type:"point",coord_type:"cartesian",origin:[0d,0d,0d]}

#line parameter tca + thc
#o + v(tca+thc)

data modify storage bs:ctx c set compute default float {type:"add",inputs:[{type:"storage",storage:"bs:ctx",path:"a"},{type:"storage",storage:"bs:ctx",path:"b"}]}

data modify storage bs:out geometry.intersect[-1].origin[0] set compute default float {\
    type:"add",inputs:[\
        {type:"storage",path:'geometry.shapes[{type:"line"}].origin[0]',storage:"bs:in"},\
        {type:"mul",inputs:[{type:"storage",storage:"bs:ctx",path:"c"},{type:"storage",path:'geometry.shapes[{type:"line"}].k[0]',storage:"bs:in"}]}\
    ]\
}
data modify storage bs:out geometry.intersect[-1].origin[1] set compute default float {\
    type:"add",inputs:[\
        {type:"storage",path:'geometry.shapes[{type:"line"}].origin[1]',storage:"bs:in"},\
        {type:"mul",inputs:[{type:"storage",storage:"bs:ctx",path:"c"},{type:"storage",path:'geometry.shapes[{type:"line"}].k[1]',storage:"bs:in"}]}\
    ]\
}
data modify storage bs:out geometry.intersect[-1].origin[2] set compute default float {\
    type:"add",inputs:[\
        {type:"storage",path:'geometry.shapes[{type:"line"}].origin[2]',storage:"bs:in"},\
        {type:"mul",inputs:[{type:"storage",storage:"bs:ctx",path:"c"},{type:"storage",path:'geometry.shapes[{type:"line"}].k[2]',storage:"bs:in"}]}\
    ]\
}

#check if there is only one intersection
execute if predicate {type:"float_value_check",value:{type:"storage",storage:"bs:ctx",path:"b"},test:{min:-0.0001,max:0.0001}} run return 1

#set output
data modify storage bs:out geometry.intersect append value {type:"point",coord_type:"cartesian",origin:[0d,0d,0d]}

#line parameter tca - thc
data modify storage bs:ctx c set compute default float {type:"sub",left:{type:"storage",storage:"bs:ctx",path:"a"},right:{type:"storage",storage:"bs:ctx",path:"b"}}

#v(tca-thc)
#o+v(tca-thc)
data modify storage bs:out geometry.intersect[-1].origin[0] set compute default float {\
    type:"add",inputs:[\
        {type:"storage",path:'geometry.shapes[{type:"line"}].origin[0]',storage:"bs:in"},\
        {type:"mul",inputs:[{type:"storage",storage:"bs:ctx",path:"c"},{type:"storage",path:'geometry.shapes[{type:"line"}].k[0]',storage:"bs:in"}]}\
    ]\
}
data modify storage bs:out geometry.intersect[-1].origin[1] set compute default float {\
    type:"add",inputs:[\
        {type:"storage",path:'geometry.shapes[{type:"line"}].origin[1]',storage:"bs:in"},\
        {type:"mul",inputs:[{type:"storage",storage:"bs:ctx",path:"c"},{type:"storage",path:'geometry.shapes[{type:"line"}].k[1]',storage:"bs:in"}]}\
    ]\
}
data modify storage bs:out geometry.intersect[-1].origin[2] set compute default float {\
    type:"add",inputs:[\
        {type:"storage",path:'geometry.shapes[{type:"line"}].origin[2]',storage:"bs:in"},\
        {type:"mul",inputs:[{type:"storage",storage:"bs:ctx",path:"c"},{type:"storage",path:'geometry.shapes[{type:"line"}].k[2]',storage:"bs:in"}]}\
    ]\
}

return 2

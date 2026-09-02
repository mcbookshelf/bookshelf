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

data modify storage bs:out geometry.orth_proj set value {type:"point",coord_type:"cartesian",origin:[0,0,0]}

#get line parameters
#o
execute store result score #l bs.ctx run data get storage bs:in geometry.shapes[{type:"line"}].origin[0] 1000
execute store result score #m bs.ctx run data get storage bs:in geometry.shapes[{type:"line"}].origin[1] 1000
execute store result score #n bs.ctx run data get storage bs:in geometry.shapes[{type:"line"}].origin[2] 1000
#v
execute store result score #o bs.ctx run data get storage bs:in geometry.shapes[{type:"line"}].k[0] 1000
execute store result score #p bs.ctx run data get storage bs:in geometry.shapes[{type:"line"}].k[1] 1000
execute store result score #q bs.ctx run data get storage bs:in geometry.shapes[{type:"line"}].k[2] 1000

#get point parameters
#p
execute store result score #x bs.ctx run data get storage bs:in geometry.shapes[{type:"point"}].origin[0] 1000
execute store result score #y bs.ctx run data get storage bs:in geometry.shapes[{type:"point"}].origin[1] 1000
execute store result score #z bs.ctx run data get storage bs:in geometry.shapes[{type:"point"}].origin[2] 1000

#compute orthogonal projection of the point
# o-v(v.(p-o))


#compute v.(p-o)
data modify storage bs:ctx c set compute default float {\
    type:"add",\
    inputs:[\
        {\
            type:"mul",\
            inputs:[\
            {type:"storage",path:'geometry.shapes[{type:"line"}].k[0]',storage:"bs:in"},\
            {type:"sub",left:{type:"storage",path:'geometry.shapes[{type:"point"}].origin[0]',storage:"bs:in"},right:{type:"storage",path:'geometry.shapes[{type:"line"}].origin[0]',storage:"bs:in"}}\
            ]\
        },\
        {\
            type:"mul",\
            inputs:[\
            {type:"storage",path:'geometry.shapes[{type:"line"}].k[1]',storage:"bs:in"},\
            {type:"sub",left:{type:"storage",path:'geometry.shapes[{type:"point"}].origin[1]',storage:"bs:in"},right:{type:"storage",path:'geometry.shapes[{type:"line"}].origin[1]',storage:"bs:in"}}\
            ]\
        },\
        {\
            type:"mul",\
            inputs:[\
            {type:"storage",path:'geometry.shapes[{type:"line"}].k[2]',storage:"bs:in"},\
            {type:"sub",left:{type:"storage",path:'geometry.shapes[{type:"point"}].origin[2]',storage:"bs:in"},right:{type:"storage",path:'geometry.shapes[{type:"line"}].origin[2]',storage:"bs:in"}}\
            ]\
        }\
    ]\
}

#o-v(v.(p-o))
data modify storage bs:out geometry.orth_proj.origin[0] set compute default float {\
    type:"sub",\
    left:{type:"storage",path:'geometry.shapes[{type:"line"}].origin[0]',storage:"bs:in"},\
    right:{type:"mul",inputs:[{type:"storage",storage:"bs:ctx",path:"c"},{type:"storage",path:'geometry.shapes[{type:"line"}].k[0]',storage:"bs:in"}]}\
}
data modify storage bs:out geometry.orth_proj.origin[1] set compute default float {\
    type:"sub",\
    left:{type:"storage",path:'geometry.shapes[{type:"line"}].origin[1]',storage:"bs:in"},\
    right:{type:"mul",inputs:[{type:"storage",storage:"bs:ctx",path:"c"},{type:"storage",path:'geometry.shapes[{type:"line"}].k[1]',storage:"bs:in"}]}\
}
data modify storage bs:out geometry.orth_proj.origin[2] set compute default float {\
    type:"sub",\
    left:{type:"storage",path:'geometry.shapes[{type:"line"}].origin[2]',storage:"bs:in"},\
    right:{type:"mul",inputs:[{type:"storage",storage:"bs:ctx",path:"c"},{type:"storage",path:'geometry.shapes[{type:"line"}].k[2]',storage:"bs:in"}]}\
}
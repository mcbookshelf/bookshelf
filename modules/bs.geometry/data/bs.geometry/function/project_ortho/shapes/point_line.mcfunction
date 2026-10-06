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

data modify storage bs.geometry:project_ortho out set value {type:"point",coord_type:"cartesian",origin:[0,0,0]}

#compute orthogonal projection of the point o-v(v.(p-o))

#compute v.(p-o)
data modify storage bs.geometry: ctx.c set compute default float {\
    type:"add",\
    inputs:[\
        {\
            type:"mul",\
            inputs:[\
            {type:"storage",path:'shapes[{type:"line"}].k[0]',storage:"bs.geometry:"},\
            {type:"sub",left:{type:"storage",path:'shapes[{type:"point"}].origin[0]',storage:"bs.geometry:"},right:{type:"storage",path:'shapes[{type:"line"}].origin[0]',storage:"bs.geometry:"}}\
            ]\
        },\
        {\
            type:"mul",\
            inputs:[\
            {type:"storage",path:'shapes[{type:"line"}].k[1]',storage:"bs.geometry:"},\
            {type:"sub",left:{type:"storage",path:'shapes[{type:"point"}].origin[1]',storage:"bs.geometry:"},right:{type:"storage",path:'shapes[{type:"line"}].origin[1]',storage:"bs.geometry:"}}\
            ]\
        },\
        {\
            type:"mul",\
            inputs:[\
            {type:"storage",path:'shapes[{type:"line"}].k[2]',storage:"bs.geometry:"},\
            {type:"sub",left:{type:"storage",path:'shapes[{type:"point"}].origin[2]',storage:"bs.geometry:"},right:{type:"storage",path:'shapes[{type:"line"}].origin[2]',storage:"bs.geometry:"}}\
            ]\
        }\
    ]\
}

#o-v(v.(p-o))
data modify storage bs.geometry:project_ortho out.origin[0] set compute default float {\
    type:"sub",\
    left:{type:"storage",path:'shapes[{type:"line"}].origin[0]',storage:"bs.geometry:"},\
    right:{type:"mul",inputs:[{type:"storage",storage:"bs.geometry:",path:"ctx.c"},{type:"storage",path:'shapes[{type:"line"}].k[0]',storage:"bs.geometry:"}]}\
}
data modify storage bs.geometry:project_ortho out.origin[1] set compute default float {\
    type:"sub",\
    left:{type:"storage",path:'shapes[{type:"line"}].origin[1]',storage:"bs.geometry:"},\
    right:{type:"mul",inputs:[{type:"storage",storage:"bs.geometry:",path:"ctx.c"},{type:"storage",path:'shapes[{type:"line"}].k[1]',storage:"bs.geometry:"}]}\
}
data modify storage bs.geometry:project_ortho out.origin[2] set compute default float {\
    type:"sub",\
    left:{type:"storage",path:'shapes[{type:"line"}].origin[2]',storage:"bs.geometry:"},\
    right:{type:"mul",inputs:[{type:"storage",storage:"bs.geometry:",path:"ctx.c"},{type:"storage",path:'shapes[{type:"line"}].k[2]',storage:"bs.geometry:"}]}\
}
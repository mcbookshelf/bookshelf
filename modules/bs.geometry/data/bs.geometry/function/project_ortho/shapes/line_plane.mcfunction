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

#set output
data modify storage bs.geometry:project_ortho out set value {type:"line",coord_type:"cartesian",origin:[0,0,0],k:[0,0,0]}

#compute orthogonal projection of the line p-n(n.(p-o))

#compute n.(p-o)
data modify storage bs.geometry: ctx.c set compute default float {\
    type:"add",\
    inputs:[\
        {\
            type:"mul",\
            inputs:[\
            {type:"storage",path:'shapes[{type:"plane"}].k[0]',storage:"bs.geometry:"},\
            {type:"sub",left:{type:"storage",path:'shapes[{type:"line"}].origin[0]',storage:"bs.geometry:"},right:{type:"storage",path:'shapes[{type:"plane"}].origin[0]',storage:"bs.geometry:"}}\
            ]\
        },\
        {\
            type:"mul",\
            inputs:[\
            {type:"storage",path:'shapes[{type:"plane"}].k[1]',storage:"bs.geometry:"},\
            {type:"sub",left:{type:"storage",path:'shapes[{type:"line"}].origin[1]',storage:"bs.geometry:"},right:{type:"storage",path:'shapes[{type:"plane"}].origin[1]',storage:"bs.geometry:"}}\
            ]\
        },\
        {\
            type:"mul",\
            inputs:[\
            {type:"storage",path:'shapes[{type:"plane"}].k[2]',storage:"bs.geometry:"},\
            {type:"sub",left:{type:"storage",path:'shapes[{type:"line"}].origin[2]',storage:"bs.geometry:"},right:{type:"storage",path:'shapes[{type:"plane"}].origin[2]',storage:"bs.geometry:"}}\
            ]\
        }\
    ]\
}

#p-n(n.(p'-o))
data modify storage bs.geometry:project_ortho out.origin[0] set compute default float {\
    type:"sub",\
    left:{type:"storage",path:'shapes[{type:"line"}].origin[0]',storage:"bs.geometry:"},\
    right:{type:"mul",inputs:[{type:"storage",storage:"bs.geometry:",path:"ctx.c"},{type:"storage",path:'shapes[{type:"plane"}].k[0]',storage:"bs.geometry:"}]}\
}
data modify storage bs.geometry:project_ortho out.origin[1] set compute default float {\
    type:"sub",\
    left:{type:"storage",path:'shapes[{type:"line"}].origin[1]',storage:"bs.geometry:"},\
    right:{type:"mul",inputs:[{type:"storage",storage:"bs.geometry:",path:"ctx.c"},{type:"storage",path:'shapes[{type:"plane"}].k[1]',storage:"bs.geometry:"}]}\
}
data modify storage bs.geometry:project_ortho out.origin[2] set compute default float {\
    type:"sub",\
    left:{type:"storage",path:'shapes[{type:"line"}].origin[2]',storage:"bs.geometry:"},\
    right:{type:"mul",inputs:[{type:"storage",storage:"bs.geometry:",path:"ctx.c"},{type:"storage",path:'shapes[{type:"plane"}].k[2]',storage:"bs.geometry:"}]}\
}

#compute orthogonal projection of the director vector u-n(n.u)

#compute n.u
data modify storage bs.geometry: ctx.c set compute default float {\
    type:"add",\
    inputs:[\
        {\
            type:"mul",\
            inputs:[\
            {type:"storage",path:'shapes[{type:"plane"}].k[0]',storage:"bs.geometry:"},\
            {type:"storage",path:'shapes[{type:"line"}].k[0]',storage:"bs.geometry:"}\
            ]\
        },\
        {\
            type:"mul",\
            inputs:[\
            {type:"storage",path:'shapes[{type:"plane"}].k[1]',storage:"bs.geometry:"},\
            {type:"storage",path:'shapes[{type:"line"}].k[1]',storage:"bs.geometry:"}\
            ]\
        },\
        {\
            type:"mul",\
            inputs:[\
            {type:"storage",path:'shapes[{type:"plane"}].k[2]',storage:"bs.geometry:"},\
            {type:"storage",path:'shapes[{type:"line"}].k[2]',storage:"bs.geometry:"}\
            ]\
        }\
    ]\
}

#compute u' = u-n(n.u)
data modify storage bs.geometry:project_ortho out.k[0] set compute default float {\
    type:"sub",\
    left:{type:"storage",path:'shapes[{type:"line"}].k[0]',storage:"bs.geometry:"},\
    right:{type:"mul",inputs:[{type:"storage",storage:"bs.geometry:",path:"ctx.c"},{type:"storage",path:'shapes[{type:"plane"}].k[0]',storage:"bs.geometry:"}]}\
}
data modify storage bs.geometry:project_ortho out.k[1] set compute default float {\
    type:"sub",\
    left:{type:"storage",path:'shapes[{type:"line"}].k[1]',storage:"bs.geometry:"},\
    right:{type:"mul",inputs:[{type:"storage",storage:"bs.geometry:",path:"ctx.c"},{type:"storage",path:'shapes[{type:"plane"}].k[1]',storage:"bs.geometry:"}]}\
}
data modify storage bs.geometry:project_ortho out.k[2] set compute default float {\
    type:"sub",\
    left:{type:"storage",path:'shapes[{type:"line"}].k[2]',storage:"bs.geometry:"},\
    right:{type:"mul",inputs:[{type:"storage",storage:"bs.geometry:",path:"ctx.c"},{type:"storage",path:'shapes[{type:"plane"}].k[2]',storage:"bs.geometry:"}]}\
}

#normalize it

#compute ||u'||
data modify storage bs.geometry: ctx.c set compute default float {\
    type:"length",\
    inputs:[\
        {type:"storage",path:'geometry.orth_proj.k[0]',storage:"bs:out"},\
        {type:"storage",path:'geometry.orth_proj.k[1]',storage:"bs:out"},\
        {type:"storage",path:'geometry.orth_proj.k[2]',storage:"bs:out"}\
    ]\
}

#normalize it
data modify storage bs.geometry:project_ortho out.k[0] set compute default float {\
    type:"div",\
    left:{type:"storage",path:'geometry.orth_proj.k[0]',storage:"bs:out"},\
    right:{type:"storage",storage:"bs.geometry:",path:"ctx.c"}\
}
data modify storage bs.geometry:project_ortho out.k[1] set compute default float {\
    type:"div",\
    left:{type:"storage",path:'geometry.orth_proj.k[1]',storage:"bs:out"},\
    right:{type:"storage",storage:"bs.geometry:",path:"ctx.c"}\
}
data modify storage bs.geometry:project_ortho out.k[2] set compute default float {\
    type:"div",\
    left:{type:"storage",path:'geometry.orth_proj.k[2]',storage:"bs:out"},\
    right:{type:"storage",storage:"bs.geometry:",path:"ctx.c"}\
}

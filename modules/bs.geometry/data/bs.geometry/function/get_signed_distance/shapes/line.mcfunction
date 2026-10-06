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

#compute sd: ||p-o-v(v.(p-o))||

#compute v.(p-o)
data modify storage bs.geometry: ctx.a set compute default float {\
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

#compute ||p-o-v(v.(p-o))||
data modify storage bs.geometry:get_signed_distance out set compute default float {\
    type:"length",\
    inputs:[\
        {\
            type:"sub",\
            left:{type:"storage",path:'shapes[{type:"point"}].origin[0]',storage:"bs.geometry:"},\
            right:{\
                type:"add",\
                inputs:[\
                {type:"storage",path:'shapes[{type:"line"}].origin[0]',storage:"bs.geometry:"},\
                {type:"mul",inputs:[{type:"storage",path:'shapes[{type:"line"}].k[0]',storage:"bs.geometry:"},{type:"storage",path:'a',storage:"bs:ctx"}]}\
                ]\
            }\
        },\
        {\
            type:"sub",\
            left:{type:"storage",path:'shapes[{type:"point"}].origin[1]',storage:"bs.geometry:"},\
            right:{\
                type:"add",\
                inputs:[\
                {type:"storage",path:'shapes[{type:"line"}].origin[1]',storage:"bs.geometry:"},\
                {type:"mul",inputs:[{type:"storage",path:'shapes[{type:"line"}].k[1]',storage:"bs.geometry:"},{type:"storage",path:'a',storage:"bs:ctx"}]}\
                ]\
            }\
        },\
        {\
            type:"sub",\
            left:{type:"storage",path:'shapes[{type:"point"}].origin[2]',storage:"bs.geometry:"},\
            right:{\
                type:"add",\
                inputs:[\
                {type:"storage",path:'shapes[{type:"line"}].origin[2]',storage:"bs.geometry:"},\
                {type:"mul",inputs:[{type:"storage",path:'shapes[{type:"line"}].k[2]',storage:"bs.geometry:"},{type:"storage",path:'a',storage:"bs:ctx"}]}\
                ]\
            }\
        }\
    ]\
}


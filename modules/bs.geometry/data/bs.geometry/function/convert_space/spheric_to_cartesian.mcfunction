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
data modify storage bs.geometry:convert_space out set value {type:"point",coord_type:"cartesian",origin:[0d,0d,0d]}

#x = r*sin(pitch)*cos(yaw)
data modify storage bs.geometry:convert_space out.origin[0] set compute default float {\
    type:"mul",\
    inputs:[\
    {type:"storage",path:'shapes[{type:"point"}].origin[2]',storage:"bs.geometry:"},\
    {type:"cos",input:{type:"storage",path:'shapes[{type:"point"}].origin[0]',storage:"bs.geometry:"}},\
    {type:"sin",input:{type:"storage",path:'shapes[{type:"point"}].origin[1]',storage:"bs.geometry:"}}\
    ]\
}

#y = r*cos(pitch)
data modify storage bs.geometry:convert_space out.origin[0] set compute default float {\
    type:"mul",\
    inputs:[\
    {type:"storage",path:'shapes[{type:"point"}].origin[2]',storage:"bs.geometry:"},\
    {type:"cos",input:{type:"storage",path:'shapes[{type:"point"}].origin[1]',storage:"bs.geometry:"}}\
    ]\
}

#z = r*sin(pitch)*sin(yaw)
data modify storage bs.geometry:convert_space out.origin[2] set compute default float {\
    type:"mul",\
    inputs:[\
    {type:"storage",path:'shapes[{type:"point"}].origin[2]',storage:"bs.geometry:"},\
    {type:"sin",input:{type:"storage",path:'shapes[{type:"point"}].origin[0]',storage:"bs.geometry:"}},\
    {type:"sin",input:{type:"storage",path:'shapes[{type:"point"}].origin[1]',storage:"bs.geometry:"}}\
    ]\
}
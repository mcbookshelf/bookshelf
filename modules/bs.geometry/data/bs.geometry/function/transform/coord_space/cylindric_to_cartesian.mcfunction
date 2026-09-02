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
data modify storage bs:out geometry.coord_space set value {type:"point",coord_type:"cartesian",origin:[0d,0d,0d]}

#x = r*cos(yaw)
data modify storage bs:out geometry.coord_space.origin[0] set compute default float {\
    type:"mul",\
    inputs:[\
    {type:"storage",path:'geometry.shapes[{type:"point"}].origin[2]',storage:"bs:in"},\
    {type:"cos",input:{type:"storage",path:'geometry.shapes[{type:"point"}].origin[0]',storage:"bs:in"}}\
    ]\
}

#y = y
data modify storage bs:out geometry.coord_space.origin[1] set from storage bs:in geometry.shapes[{type:"point"}].origin[1]

#z = r*sin(yaw)
data modify storage bs:out geometry.coord_space.origin[2] set compute default float {\
    type:"mul",\
    inputs:[\
    {type:"storage",path:'geometry.shapes[{type:"point"}].origin[2]',storage:"bs:in"},\
    {type:"sin",input:{type:"storage",path:'geometry.shapes[{type:"point"}].origin[0]',storage:"bs:in"}}\
    ]\
}
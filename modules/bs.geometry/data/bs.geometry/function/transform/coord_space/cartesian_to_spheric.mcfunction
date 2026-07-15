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

#transform cartesian (x,y,z) into spheric (theta,phi,r)
data modify storage bs:ctx temp set value [7,0,4,0, 0,1,0,0, -4,0,7,0, 0,0,0,1]
data modify storage bs:ctx temp[0] set from storage bs:in geometry.shapes[{type:"point"}].origin[2]
data modify storage bs:ctx temp[2] set from storage bs:in geometry.shapes[{type:"point"}].origin[0]
execute store result storage bs:ctx temp[8] float -0.0001 run data get storage bs:in geometry.shapes[{type:"point"}].origin[0] 10000
data modify storage bs:ctx temp[10] set from storage bs:in geometry.shapes[{type:"point"}].origin[2]

#scale[0] = r_xy
#left_rotation[1] = sin(theta/2)
#left_rotation[3] = cos(theta/2)
data modify entity B5-0-0-0-7 transformation set from storage bs:ctx temp

data modify storage bs:out geometry.shape set value {type:"point",coord_type:"spheric",origin:[0d,0d,0d]}

execute store result score $math.asin.x bs.in run data get entity B5-0-0-0-7 transformation.left_rotation[1] 1000
execute store result storage bs:out geometry.shape.origin[0] double -0.02 run function #bs.math:asin

#get phi
data modify storage bs:ctx temp set value [4,-7,0,0, 7,4,0,0, 0,0,1,0, 0,0,0,1]
data modify storage bs:ctx temp[0] set from entity B5-0-0-0-7 transformation.scale[0]
execute store result storage bs:ctx temp[1] float -0.0001 run data get storage bs:in geometry.shapes[{type:"point"}].origin[1] 10000
data modify storage bs:ctx temp[4] set from storage bs:in geometry.shapes[{type:"point"}].origin[1]
data modify storage bs:ctx temp[5] set from entity B5-0-0-0-7 transformation.scale[0]

#scale[0] = r
#left_rotation[2] = sin(phi/2)
#left_rotation[3] = cos(phi/2)
data modify entity B5-0-0-0-7 transformation set from storage bs:ctx temp

execute store result score $math.asin.x bs.in run data get entity B5-0-0-0-7 transformation.left_rotation[2] 1000
execute store result storage bs:out geometry.shape.origin[1] double -0.02 run function #bs.math:asin
execute store result storage bs:out geometry.shape.origin[2] double 0.0001 run data get entity B5-0-0-0-7 transformation.scale[0] 10000

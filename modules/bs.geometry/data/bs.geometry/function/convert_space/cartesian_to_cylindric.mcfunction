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
data modify storage bs.geometry:convert_space out set value {type:"point",coord_type:"cylindric",origin:[0d,0d,0d]}

#transform cartesian (x,y,z) into cylindric (yaw,y,r)

#matrix manipulation
data modify storage bs.geometry ctx._ set value [7,0,4,0, 0,1,0,0, -4,0,7,0, 0,0,0,1]
data modify storage bs.geometry ctx._[0] set from storage bs.geometry: shapes[{type:"point"}].origin[2]
data modify storage bs.geometry ctx._[2] set from storage bs.geometry: shapes[{type:"point"}].origin[0]
execute store result storage bs.geometry ctx._[8] float -0.0001 run data get storage bs.geometry: shapes[{type:"point"}].origin[0] 10000
data modify storage bs.geometry ctx._[10] set from storage bs.geometry: shapes[{type:"point"}].origin[2]
data modify entity B5-0-0-0-7 transformation set from storage bs.geometry ctx._

#left_rotation[1] = sin(yaw/2) so yaw = 2*asin(left_rotation[1])
execute store result score $math.asin.x bs.in run data get entity B5-0-0-0-7 transformation.left_rotation[1] 1000
execute store result storage bs.geometry:convert_space out.origin[0] double -0.02 run function #bs.math:asin
#y = y
data modify storage bs.geometry:convert_space out.origin[1] set from storage bs.geometry: shapes[{type:"point"}].origin[1]
#scale[0] = r
data modify storage bs.geometry:convert_space out.origin[2] set from entity B5-0-0-0-7 transformation.scale[0]

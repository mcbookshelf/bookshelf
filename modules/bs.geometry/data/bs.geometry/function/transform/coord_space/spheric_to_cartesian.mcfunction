

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

data modify entity B5-0-0-0-9 Rotation[0] set from storage bs:in geometry.shapes[{type:"point"}].origin[0]
data modify entity B5-0-0-0-9 Rotation[1] set from storage bs:in geometry.shapes[{type:"point"}].origin[1]

execute positioned 0.0 0 0.0 rotated as B5-0-0-0-9 positioned ^ ^ ^1 run function bs.geometry:shape/get_pos

execute store result score #a bs.ctx run data get storage bs:out geometry.Pos[0] 1000
execute store result score #b bs.ctx run data get storage bs:out geometry.Pos[1] 1000
execute store result score #c bs.ctx run data get storage bs:out geometry.Pos[2] 1000

#r = radius
execute store result score #r bs.ctx run data get storage bs:in geometry.shapes[{type:"point"}].origin[2] 1000

#set output
data modify storage bs:out geometry.shape set value {type:"point",coord_type:"cartesian",origin:[0d,0d,0d]}

execute store result storage bs:out geometry.shape.origin[0] double 0.000001 run scoreboard players operation #a bs.ctx *= #r bs.ctx
execute store result storage bs:out geometry.shape.origin[1] double 0.000001 run scoreboard players operation #b bs.ctx *= #r bs.ctx
execute store result storage bs:out geometry.shape.origin[2] double 0.000001 run scoreboard players operation #c bs.ctx *= #r bs.ctx



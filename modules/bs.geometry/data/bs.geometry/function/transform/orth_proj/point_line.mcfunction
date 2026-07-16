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

#get plane parameters
execute store result score #l bs.ctx run data get storage bs:in geometry.shapes[{type:"line"}].origin[0] 1000
execute store result score #m bs.ctx run data get storage bs:in geometry.shapes[{type:"line"}].origin[1] 1000
execute store result score #n bs.ctx run data get storage bs:in geometry.shapes[{type:"line"}].origin[2] 1000

execute store result score #o bs.ctx run data get storage bs:in geometry.shapes[{type:"line"}].k[0] 1000
execute store result score #p bs.ctx run data get storage bs:in geometry.shapes[{type:"line"}].k[1] 1000
execute store result score #q bs.ctx run data get storage bs:in geometry.shapes[{type:"line"}].k[2] 1000

#get point parameters
execute store result score #x bs.ctx run data get storage bs:in geometry.shapes[{type:"point"}].origin[0] 1000
execute store result score #y bs.ctx run data get storage bs:in geometry.shapes[{type:"point"}].origin[1] 1000
execute store result score #z bs.ctx run data get storage bs:in geometry.shapes[{type:"point"}].origin[2] 1000

#compute orthogonal projection of the point
# o-v(v.(p-o))

scoreboard players operation #x bs.ctx -= #l bs.ctx
scoreboard players operation #y bs.ctx -= #m bs.ctx
scoreboard players operation #z bs.ctx -= #n bs.ctx

scoreboard players operation #x bs.ctx *= #o bs.ctx
scoreboard players operation #y bs.ctx *= #p bs.ctx
scoreboard players operation #z bs.ctx *= #q bs.ctx

scoreboard players operation #x bs.ctx += #y bs.ctx
scoreboard players operation #x bs.ctx += #z bs.ctx
scoreboard players operation #x bs.ctx /= 1000 bs.const

scoreboard players operation #o bs.ctx *= #x bs.ctx
scoreboard players operation #p bs.ctx *= #x bs.ctx
scoreboard players operation #q bs.ctx *= #x bs.ctx

scoreboard players operation #o bs.ctx /= 1000 bs.const
scoreboard players operation #p bs.ctx /= 1000 bs.const
scoreboard players operation #q bs.ctx /= 1000 bs.const

execute store result storage bs:out geometry.orth_proj.origin[0] double 0.001 run scoreboard players operation #l bs.ctx -= #o bs.ctx
execute store result storage bs:out geometry.orth_proj.origin[1] double 0.001 run scoreboard players operation #m bs.ctx -= #p bs.ctx
execute store result storage bs:out geometry.orth_proj.origin[2] double 0.001 run scoreboard players operation #n bs.ctx -= #q bs.ctx

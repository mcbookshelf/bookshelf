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

#get plane parameters
#o
execute store result score #l bs.ctx run data get storage bs:in geometry.shapes[{type:"plane"}].origin[0] 1000
execute store result score #m bs.ctx run data get storage bs:in geometry.shapes[{type:"plane"}].origin[1] 1000
execute store result score #n bs.ctx run data get storage bs:in geometry.shapes[{type:"plane"}].origin[2] 1000
#n
execute store result score $geometry.sdf bs.out run data get storage bs:in geometry.shapes[{type:"plane"}].k[0] 1000
execute store result score #p bs.ctx run data get storage bs:in geometry.shapes[{type:"plane"}].k[1] 1000
execute store result score #q bs.ctx run data get storage bs:in geometry.shapes[{type:"plane"}].k[2] 1000

#get point parameters
#p
execute store result score #x bs.ctx run data get storage bs:in geometry.shapes[{type:"point"}].origin[0] 1000
execute store result score #y bs.ctx run data get storage bs:in geometry.shapes[{type:"point"}].origin[1] 1000
execute store result score #z bs.ctx run data get storage bs:in geometry.shapes[{type:"point"}].origin[2] 1000


#compute n.(p-o)

#(p-o)
scoreboard players operation #x bs.ctx -= #l bs.ctx
scoreboard players operation #y bs.ctx -= #m bs.ctx
scoreboard players operation #z bs.ctx -= #n bs.ctx

#n.(p-o)
scoreboard players operation $geometry.sdf bs.out *= #x bs.ctx
scoreboard players operation #p bs.ctx *= #y bs.ctx
scoreboard players operation #q bs.ctx *= #z bs.ctx
scoreboard players operation $geometry.sdf bs.out += #p bs.ctx
scoreboard players operation $geometry.sdf bs.out += #q bs.ctx
return run scoreboard players operation $geometry.sdf bs.out /= 1000 bs.const

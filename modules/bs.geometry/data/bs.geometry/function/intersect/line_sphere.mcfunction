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


#get sphere parameters
execute store result score #l bs.ctx run data get storage bs:in geometry.shapes[{type:"sphere"}].origin[0] 1000
execute store result score #m bs.ctx run data get storage bs:in geometry.shapes[{type:"sphere"}].origin[1] 1000
execute store result score #n bs.ctx run data get storage bs:in geometry.shapes[{type:"sphere"}].origin[2] 1000

execute store result score #r bs.ctx run data get storage bs:in geometry.shapes[{type:"sphere"}].parameters[0] 1000

#get line parameters
execute store result score #x bs.ctx run data get storage bs:in geometry.shapes[{type:"line"}].origin[0] 1000
execute store result score #y bs.ctx run data get storage bs:in geometry.shapes[{type:"line"}].origin[1] 1000
execute store result score #z bs.ctx run data get storage bs:in geometry.shapes[{type:"line"}].origin[2] 1000

execute store result score #o bs.ctx run data get storage bs:in geometry.shapes[{type:"line"}].k[0] 1000
execute store result score #p bs.ctx run data get storage bs:in geometry.shapes[{type:"line"}].k[1] 1000
execute store result score #q bs.ctx run data get storage bs:in geometry.shapes[{type:"line"}].k[2] 1000

# L = (c-o) = (1,1)
scoreboard players operation #l bs.ctx -= #x bs.ctx 
scoreboard players operation #m bs.ctx -= #y bs.ctx 
scoreboard players operation #n bs.ctx -= #z bs.ctx 

# tca = (L.D) = sqrt(2)
scoreboard players operation #d bs.ctx = #l bs.ctx
scoreboard players operation #e bs.ctx = #m bs.ctx
scoreboard players operation #f bs.ctx = #n bs.ctx
scoreboard players operation #d bs.ctx *= #o bs.ctx
scoreboard players operation #e bs.ctx *= #p bs.ctx
scoreboard players operation #f bs.ctx *= #q bs.ctx
scoreboard players operation #d bs.ctx += #e bs.ctx
scoreboard players operation #d bs.ctx += #f bs.ctx
scoreboard players operation #d bs.ctx /= 1000 bs.const

#d² = ||L - D*tca||² = (1+sqrt(2),1+sqrt(2))
scoreboard players operation #g bs.ctx = #o bs.ctx
scoreboard players operation #h bs.ctx = #p bs.ctx
scoreboard players operation #i bs.ctx = #q bs.ctx
scoreboard players operation #g bs.ctx *= #d bs.ctx
scoreboard players operation #h bs.ctx *= #d bs.ctx
scoreboard players operation #i bs.ctx *= #d bs.ctx
scoreboard players operation #g bs.ctx /= 1000 bs.const
scoreboard players operation #h bs.ctx /= 1000 bs.const
scoreboard players operation #i bs.ctx /= 1000 bs.const
scoreboard players operation #g bs.ctx -= #l bs.ctx
scoreboard players operation #h bs.ctx -= #m bs.ctx
scoreboard players operation #i bs.ctx -= #n bs.ctx
scoreboard players operation #g bs.ctx *= #g bs.ctx
scoreboard players operation #h bs.ctx *= #h bs.ctx
scoreboard players operation #i bs.ctx *= #i bs.ctx
scoreboard players operation #g bs.ctx += #h bs.ctx
scoreboard players operation #g bs.ctx += #i bs.ctx

#thc = sqrt(r²-d²)
scoreboard players operation $math.isqrt.x bs.in = #r bs.ctx
scoreboard players operation $math.isqrt.x bs.in *= #r bs.ctx
scoreboard players operation $math.isqrt.x bs.in -= #g bs.ctx

#tellraw @a {score:{name:"#d0",objective:"bs.ctx"}}

execute if score $math.isqrt.x bs.in matches ..-1 run return run function bs.geometry:error/none_intersection
execute store result score #j bs.ctx run function #bs.math:isqrt

execute if score $math.isqrt.x bs.in matches 0.. run data modify storage bs:out geometry.intersect append value {type:"point",coord_type:"cartesian",origin:[0d,0d,0d]}
scoreboard players operation #k bs.ctx = #d bs.ctx
scoreboard players operation #k bs.ctx += #j bs.ctx

scoreboard players operation #a bs.ctx = #o bs.ctx
scoreboard players operation #b bs.ctx = #p bs.ctx
scoreboard players operation #c bs.ctx = #q bs.ctx
scoreboard players operation #a bs.ctx *= #k bs.ctx
scoreboard players operation #b bs.ctx *= #k bs.ctx
scoreboard players operation #c bs.ctx *= #k bs.ctx
scoreboard players operation #a bs.ctx /= 1000 bs.const
scoreboard players operation #b bs.ctx /= 1000 bs.const
scoreboard players operation #c bs.ctx /= 1000 bs.const
execute store result storage bs:out geometry.intersect[-1].origin[0] double 0.001 run scoreboard players operation #a bs.ctx += #x bs.ctx
execute store result storage bs:out geometry.intersect[-1].origin[1] double 0.001 run scoreboard players operation #b bs.ctx += #y bs.ctx
execute store result storage bs:out geometry.intersect[-1].origin[2] double 0.001 run scoreboard players operation #c bs.ctx += #z bs.ctx

execute if score $math.isqrt.x bs.in matches 0..999 run return 1

execute if score $math.isqrt.x bs.in matches 1000.. run data modify storage bs:out geometry.intersect append value {type:"point",coord_type:"cartesian",origin:[0d,0d,0d]}
scoreboard players operation #d bs.ctx -= #j bs.ctx

scoreboard players operation #o bs.ctx *= #d bs.ctx
scoreboard players operation #p bs.ctx *= #d bs.ctx
scoreboard players operation #q bs.ctx *= #d bs.ctx
scoreboard players operation #o bs.ctx /= 1000 bs.const
scoreboard players operation #p bs.ctx /= 1000 bs.const
scoreboard players operation #q bs.ctx /= 1000 bs.const
execute store result storage bs:out geometry.intersect[-1].origin[0] double 0.001 run scoreboard players operation #x bs.ctx += #o bs.ctx
execute store result storage bs:out geometry.intersect[-1].origin[1] double 0.001 run scoreboard players operation #y bs.ctx += #p bs.ctx
execute store result storage bs:out geometry.intersect[-1].origin[2] double 0.001 run scoreboard players operation #z bs.ctx += #q bs.ctx



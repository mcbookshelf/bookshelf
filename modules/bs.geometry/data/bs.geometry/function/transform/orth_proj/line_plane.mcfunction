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

data modify storage bs:out geometry.orth_proj set value {type:"line",coord_type:"cartesian",origin:[0,0,0],k:[0,0,0]}

#get plane parameters
#o
execute store result score #l bs.ctx run data get storage bs:in geometry.shapes[{type:"plane"}].origin[0] 1000
execute store result score #m bs.ctx run data get storage bs:in geometry.shapes[{type:"plane"}].origin[1] 1000
execute store result score #n bs.ctx run data get storage bs:in geometry.shapes[{type:"plane"}].origin[2] 1000
#n
execute store result score #o bs.ctx run data get storage bs:in geometry.shapes[{type:"plane"}].k[0] 1000
execute store result score #p bs.ctx run data get storage bs:in geometry.shapes[{type:"plane"}].k[1] 1000
execute store result score #q bs.ctx run data get storage bs:in geometry.shapes[{type:"plane"}].k[2] 1000

#get line origin parameters
#p
execute store result score #x bs.ctx run data get storage bs:in geometry.shapes[{type:"line"}].origin[0] 1000
execute store result score #y bs.ctx run data get storage bs:in geometry.shapes[{type:"line"}].origin[1] 1000
execute store result score #z bs.ctx run data get storage bs:in geometry.shapes[{type:"line"}].origin[2] 1000


#compute orthogonal projection of the point p-n(n.(p-o))

# p' = p
scoreboard players operation #a bs.ctx = #x bs.ctx
scoreboard players operation #b bs.ctx = #y bs.ctx
scoreboard players operation #c bs.ctx = #z bs.ctx

#p'-o
scoreboard players operation #a bs.ctx -= #l bs.ctx
scoreboard players operation #b bs.ctx -= #m bs.ctx
scoreboard players operation #c bs.ctx -= #n bs.ctx

#n.(p'-o)
scoreboard players operation #a bs.ctx *= #o bs.ctx
scoreboard players operation #b bs.ctx *= #p bs.ctx
scoreboard players operation #c bs.ctx *= #q bs.ctx
scoreboard players operation #a bs.ctx += #b bs.ctx
scoreboard players operation #a bs.ctx += #c bs.ctx
scoreboard players operation #a bs.ctx /= 1000 bs.const

#n(n.(p'-o))
scoreboard players operation #o bs.ctx *= #a bs.ctx
scoreboard players operation #p bs.ctx *= #a bs.ctx
scoreboard players operation #q bs.ctx *= #a bs.ctx
scoreboard players operation #o bs.ctx /= 1000 bs.const
scoreboard players operation #p bs.ctx /= 1000 bs.const
scoreboard players operation #q bs.ctx /= 1000 bs.const

#p-n(n.(p'-o))
execute store result storage bs:out geometry.orth_proj.origin[0] double 0.001 run scoreboard players operation #x bs.ctx -= #o bs.ctx
execute store result storage bs:out geometry.orth_proj.origin[1] double 0.001 run scoreboard players operation #y bs.ctx -= #p bs.ctx
execute store result storage bs:out geometry.orth_proj.origin[2] double 0.001 run scoreboard players operation #z bs.ctx -= #q bs.ctx

#get line director vector parameters
#u
execute store result score #x bs.ctx run data get storage bs:in geometry.shapes[{type:"line"}].k[0] 1000
execute store result score #y bs.ctx run data get storage bs:in geometry.shapes[{type:"line"}].k[1] 1000
execute store result score #z bs.ctx run data get storage bs:in geometry.shapes[{type:"line"}].k[2] 1000

#compute orthogonal projection of the director vector u-n(n.u)

#u' = u
scoreboard players operation #a bs.ctx = #x bs.ctx
scoreboard players operation #b bs.ctx = #y bs.ctx
scoreboard players operation #c bs.ctx = #z bs.ctx

#(n.u')
scoreboard players operation #a bs.ctx *= #o bs.ctx
scoreboard players operation #b bs.ctx *= #p bs.ctx
scoreboard players operation #c bs.ctx *= #q bs.ctx
scoreboard players operation #a bs.ctx += #b bs.ctx
scoreboard players operation #a bs.ctx += #c bs.ctx
scoreboard players operation #a bs.ctx /= 1000 bs.const

#n(n.u')
scoreboard players operation #o bs.ctx *= #a bs.ctx
scoreboard players operation #p bs.ctx *= #a bs.ctx
scoreboard players operation #q bs.ctx *= #a bs.ctx
scoreboard players operation #o bs.ctx /= 1000 bs.const
scoreboard players operation #p bs.ctx /= 1000 bs.const
scoreboard players operation #q bs.ctx /= 1000 bs.const

#u-n(n.u')
scoreboard players operation #x bs.ctx -= #o bs.ctx
scoreboard players operation #y bs.ctx -= #p bs.ctx
scoreboard players operation #z bs.ctx -= #q bs.ctx


#normalize u'' = u-n(n.u')

#u''.u''
scoreboard players operation $math.isqrt.x bs.in = #x bs.ctx
scoreboard players operation $math.isqrt.x bs.in *= #x bs.ctx
scoreboard players operation #d bs.ctx = #y bs.ctx
scoreboard players operation #d bs.ctx *= #y bs.ctx
scoreboard players operation $math.isqrt.x bs.in += #d bs.ctx
scoreboard players operation #d bs.ctx = #z bs.ctx
scoreboard players operation #d bs.ctx *= #z bs.ctx
scoreboard players operation $math.isqrt.x bs.in += #d bs.ctx
scoreboard players operation $math.isqrt.x bs.in /= 1000 bs.const

#sqrt(u''.u'')
execute store result score #d bs.ctx run function bs.math:isqrt

#u''/norm(u'')
execute store result storage bs:out geometry.orth_proj.k[0] double 0.0316227766017 run scoreboard players operation #x bs.ctx /= #d bs.ctx
execute store result storage bs:out geometry.orth_proj.k[1] double 0.0316227766017 run scoreboard players operation #y bs.ctx /= #d bs.ctx
execute store result storage bs:out geometry.orth_proj.k[2] double 0.0316227766017 run scoreboard players operation #z bs.ctx /= #d bs.ctx

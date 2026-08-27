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

#get line parameters
#o
execute store result score #l bs.ctx run data get storage bs:in geometry.shapes[{type:"line"}].origin[0] 1000
execute store result score #m bs.ctx run data get storage bs:in geometry.shapes[{type:"line"}].origin[1] 1000
execute store result score #n bs.ctx run data get storage bs:in geometry.shapes[{type:"line"}].origin[2] 1000
#v
execute store result score #o bs.ctx run data get storage bs:in geometry.shapes[{type:"line"}].k[0] 1000
execute store result score #p bs.ctx run data get storage bs:in geometry.shapes[{type:"line"}].k[1] 1000
execute store result score #q bs.ctx run data get storage bs:in geometry.shapes[{type:"line"}].k[2] 1000

#get point origin
#p
execute store result score $math.isqrt.x bs.in run data get storage bs:in geometry.shapes[1].origin[0] 1000
execute store result score #y bs.ctx run data get storage bs:in geometry.shapes[1].origin[1] 1000
execute store result score #z bs.ctx run data get storage bs:in geometry.shapes[1].origin[2] 1000


#compute sdf:  norm(p-o-v(v.(p-o)))

#p-o
scoreboard players operation $math.isqrt.x bs.in -= #l bs.ctx
scoreboard players operation #y bs.ctx -= #m bs.ctx
scoreboard players operation #z bs.ctx -= #n bs.ctx

#(p-o)' = (p-o)
scoreboard players operation #a bs.ctx = $math.isqrt.x bs.in
scoreboard players operation #b bs.ctx = #y bs.ctx
scoreboard players operation #c bs.ctx = #z bs.ctx

#v.(p-o)'
scoreboard players operation #a bs.ctx *= #o bs.ctx
scoreboard players operation #b bs.ctx *= #p bs.ctx
scoreboard players operation #c bs.ctx *= #q bs.ctx
scoreboard players operation #a bs.ctx += #b bs.ctx
scoreboard players operation #a bs.ctx += #c bs.ctx
scoreboard players operation #a bs.ctx /= 1000 bs.const

#v(v.(p-o)')
scoreboard players operation #o bs.ctx *= #a bs.ctx
scoreboard players operation #p bs.ctx *= #a bs.ctx
scoreboard players operation #q bs.ctx *= #a bs.ctx
scoreboard players operation #o bs.ctx /= 1000 bs.const
scoreboard players operation #p bs.ctx /= 1000 bs.const
scoreboard players operation #q bs.ctx /= 1000 bs.const

#p-o-v(v.(p-o)')
scoreboard players operation $math.isqrt.x bs.in -= #o bs.ctx
scoreboard players operation #y bs.ctx -= #p bs.ctx
scoreboard players operation #z bs.ctx -= #q bs.ctx

#norm(p-o-v(v.(p-o)'))²
scoreboard players operation $math.isqrt.x bs.in *= $math.isqrt.x bs.in
scoreboard players operation #y bs.ctx *= #y bs.ctx
scoreboard players operation #z bs.ctx *= #z bs.ctx
scoreboard players operation $math.isqrt.x bs.in += #y bs.ctx
scoreboard players operation $math.isqrt.x bs.in += #z bs.ctx

#norm(p-o-v(v.(p-o)'))
execute store result score $geometry.sdf bs.out run function #bs.math:isqrt
return run scoreboard players get $geometry.sdf bs.out

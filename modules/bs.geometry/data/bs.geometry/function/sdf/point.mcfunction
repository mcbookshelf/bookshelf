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

#get point0 origin
#p
execute store result score #l bs.ctx run data get storage bs:in geometry.shapes[0].origin[0] 1000
execute store result score #m bs.ctx run data get storage bs:in geometry.shapes[0].origin[1] 1000
execute store result score #n bs.ctx run data get storage bs:in geometry.shapes[0].origin[2] 1000

#get point1 origin
#p'
execute store result score $math.isqrt.x bs.in run data get storage bs:in geometry.shapes[1].origin[0] 1000
execute store result score #y bs.ctx run data get storage bs:in geometry.shapes[1].origin[1] 1000
execute store result score #z bs.ctx run data get storage bs:in geometry.shapes[1].origin[2] 1000

#compute dist

#p'-p
scoreboard players operation $math.isqrt.x bs.in -= #l bs.ctx
scoreboard players operation #y bs.ctx -= #m bs.ctx
scoreboard players operation #z bs.ctx -= #n bs.ctx

#norm(p'-p)²
scoreboard players operation $math.isqrt.x bs.in *= $math.isqrt.x bs.in
scoreboard players operation #y bs.ctx *= #y bs.ctx
scoreboard players operation #z bs.ctx *= #z bs.ctx
scoreboard players operation $math.isqrt.x bs.in += #y bs.ctx
scoreboard players operation $math.isqrt.x bs.in += #z bs.ctx

#norm(p'-p)
execute store result score $geometry.sdf bs.out run function #bs.math:isqrt
return run scoreboard players get $geometry.sdf bs.out

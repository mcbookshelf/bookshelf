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

scoreboard players reset $dx bs.out
scoreboard players reset $dy bs.out
scoreboard players reset $dz bs.out

scoreboard players operation #dot0 bs.ctx = #n0 bs.ctx
scoreboard players operation #dot0 bs.ctx *= #u0 bs.ctx

scoreboard players operation #dot1 bs.ctx = #n1 bs.ctx
scoreboard players operation #dot1 bs.ctx *= #u1 bs.ctx
scoreboard players operation #dot0 bs.ctx += #dot1 bs.ctx

scoreboard players operation #dot1 bs.ctx = #n2 bs.ctx
scoreboard players operation #dot1 bs.ctx *= #u2 bs.ctx
scoreboard players operation #dot0 bs.ctx += #dot1 bs.ctx
scoreboard players operation #dot0 bs.ctx /= 1000 bs.const

execute if score #dot0 bs.ctx matches 0 run return fail


#Compute the value of the parameter of the axis
scoreboard players operation #d0 bs.ctx = #o0 bs.ctx
scoreboard players operation #d1 bs.ctx = #o1 bs.ctx
scoreboard players operation #d2 bs.ctx = #o2 bs.ctx

scoreboard players operation #d0 bs.ctx -= #v0 bs.ctx
scoreboard players operation #d1 bs.ctx -= #v1 bs.ctx
scoreboard players operation #d2 bs.ctx -= #v2 bs.ctx

scoreboard players operation #t0 bs.ctx = #d0 bs.ctx
scoreboard players operation #t1 bs.ctx = #d1 bs.ctx
scoreboard players operation #t2 bs.ctx = #d2 bs.ctx

scoreboard players operation #t0 bs.ctx *= #n0 bs.ctx
scoreboard players operation #t1 bs.ctx *= #n1 bs.ctx
scoreboard players operation #t2 bs.ctx *= #n2 bs.ctx

scoreboard players operation $dz bs.out = #t0 bs.ctx
scoreboard players operation $dz bs.out += #t1 bs.ctx
scoreboard players operation $dz bs.out += #t2 bs.ctx

scoreboard players operation $dz bs.out /= #dot0 bs.ctx


#Compute the relative positon of the intersection and plane origin
scoreboard players operation #w0 bs.ctx = #u0 bs.ctx
scoreboard players operation #w1 bs.ctx = #u1 bs.ctx
scoreboard players operation #w2 bs.ctx = #u2 bs.ctx

scoreboard players operation #w0 bs.ctx *= $dz bs.out
scoreboard players operation #w1 bs.ctx *= $dz bs.out
scoreboard players operation #w2 bs.ctx *= $dz bs.out

scoreboard players operation #w0 bs.ctx /= 1000 bs.const
scoreboard players operation #w1 bs.ctx /= 1000 bs.const
scoreboard players operation #w2 bs.ctx /= 1000 bs.const

scoreboard players operation #w0 bs.ctx -= #d0 bs.ctx
scoreboard players operation #w1 bs.ctx -= #d1 bs.ctx
scoreboard players operation #w2 bs.ctx -= #d2 bs.ctx


#compute the plane coord
scoreboard players operation $dx bs.out = #w0 bs.ctx
scoreboard players operation #wp1 bs.ctx = #w1 bs.ctx
scoreboard players operation #wp2 bs.ctx = #w2 bs.ctx
scoreboard players operation $dx bs.out *= #i0 bs.ctx
scoreboard players operation #wp1 bs.ctx *= #i1 bs.ctx
scoreboard players operation #wp2 bs.ctx *= #i2 bs.ctx

scoreboard players operation $dx bs.out += #wp1 bs.ctx
scoreboard players operation $dx bs.out += #wp2 bs.ctx
scoreboard players operation $dx bs.out /= 1000 bs.ctx

scoreboard players operation $dx bs.out = #w0 bs.ctx
scoreboard players operation #wp1 bs.ctx = #w1 bs.ctx
scoreboard players operation #wp2 bs.ctx = #w2 bs.ctx
scoreboard players operation $dx bs.out *= #j0 bs.ctx
scoreboard players operation #wp1 bs.ctx *= #j1 bs.ctx
scoreboard players operation #wp2 bs.ctx *= #j2 bs.ctx

scoreboard players operation $dx bs.out += #wp1 bs.ctx
scoreboard players operation $dx bs.out += #wp2 bs.ctx
scoreboard players operation $dx bs.out /= 1000 bs.const

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

execute align xyz run summon marker ~ ~ ~ {Tags:["ward.animation.position"]}

data modify storage bs.animation:attach in set value {id:"position",run:"function #bs.animation:apply/position",type:"linear",duration:1,points:[[0,0,0],[0,0,0]]}
data modify storage bs.animation:attach in.points[1] set from entity @n[tag=ward.animation.position] Pos
execute as @n[tag=ward.animation.position] at @s run tp @s ~32 ~16 ~-32
data modify storage bs.animation:attach in.points[0] set from entity @n[tag=ward.animation.position] Pos
execute as @n[tag=ward.animation.position] run function #bs.animation:attach

data modify storage bs.animation:step in set value {id:"position",step:1}
execute as @n[tag=ward.animation.position] run function #bs.animation:step

data modify storage bs.animation:attach in.points[0] set from entity @n[tag=ward.animation.position] Pos
assert predicate {type:"float_value_check",value:{type:sub,left:{type:storage,storage:"bs.animation:attach",path:"in.points[1][0]"},right:{type:storage,storage:"bs.animation:attach",path:"in.points[0][0]"}},test:{min:-2.0,max:2.0}}
assert predicate {type:"float_value_check",value:{type:sub,left:{type:storage,storage:"bs.animation:attach",path:"in.points[1][1]"},right:{type:storage,storage:"bs.animation:attach",path:"in.points[0][1]"}},test:{min:-2.0,max:2.0}}
assert predicate {type:"float_value_check",value:{type:sub,left:{type:storage,storage:"bs.animation:attach",path:"in.points[1][2]"},right:{type:storage,storage:"bs.animation:attach",path:"in.points[0][2]"}},test:{min:-2.0,max:2.0}}

kill @n[tag=ward.animation.position]

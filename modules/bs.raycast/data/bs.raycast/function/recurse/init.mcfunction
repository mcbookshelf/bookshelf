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

data modify storage bs:ctx _ set from entity @s Pos
data modify storage bs:data raycast.x set compute default integer {type:"from_float",input:{type:"negate",input:{type:"floor",input:{type:"storage",storage:"bs:ctx",path:"_[0]"}}}}
data modify storage bs:data raycast.y set compute default integer {type:"from_float",input:{type:"negate",input:{type:"floor",input:{type:"storage",storage:"bs:ctx",path:"_[1]"}}}}
data modify storage bs:data raycast.z set compute default integer {type:"from_float",input:{type:"negate",input:{type:"floor",input:{type:"storage",storage:"bs:ctx",path:"_[2]"}}}}

# get the unit vector [ux,uy,uz]
execute positioned 0.0 0.0 0.0 run tp @s ^ ^ ^1
data modify storage bs:ctx _ set from entity @s Pos
data modify storage bs:data raycast.ux set from storage bs:ctx _[0]
data modify storage bs:data raycast.uy set from storage bs:ctx _[1]
data modify storage bs:data raycast.uz set from storage bs:ctx _[2]

# compute the delta [dx,dy,dz] (distance to advance to the next grid intersection)
execute unless predicate bs.raycast:internal/positive_ux run data modify storage bs:data raycast.sx set value -1
execute unless predicate bs.raycast:internal/positive_uy run data modify storage bs:data raycast.sy set value -1
execute unless predicate bs.raycast:internal/positive_uz run data modify storage bs:data raycast.sz set value -1
data modify storage bs:data raycast.dx set compute default float {type:"div",left:1,right:{type:"abs",input:"bs.raycast:internal/ux"}}
data modify storage bs:data raycast.dy set compute default float {type:"div",left:1,right:{type:"abs",input:"bs.raycast:internal/uy"}}
data modify storage bs:data raycast.dz set compute default float {type:"div",left:1,right:{type:"abs",input:"bs.raycast:internal/uz"}}

# compute the length [lx,ly,lz] (distance from the origin to the next grid intersection)
function bs.raycast:utils/get_relative_pos with storage bs:data raycast
data modify storage bs:data raycast.rx set compute default float {type:"negate",input:{type:"storage",storage:"bs:ctx",path:"_[0]"}}
data modify storage bs:data raycast.ry set compute default float {type:"negate",input:{type:"storage",storage:"bs:ctx",path:"_[1]"}}
data modify storage bs:data raycast.rz set compute default float {type:"negate",input:{type:"storage",storage:"bs:ctx",path:"_[2]"}}
data modify storage bs:data raycast.lx set compute default float {type:"div",left:{type:"conditional",condition:"bs.raycast:internal/positive_ux",on_false:{type:"storage",storage:"bs:data",path:"raycast.rx"},on_true:{type:"add",inputs:[1,{type:"storage",storage:"bs:data",path:"raycast.rx"}]}},right:"bs.raycast:internal/ux"}
data modify storage bs:data raycast.ly set compute default float {type:"div",left:{type:"conditional",condition:"bs.raycast:internal/positive_uy",on_false:{type:"storage",storage:"bs:data",path:"raycast.ry"},on_true:{type:"add",inputs:[1,{type:"storage",storage:"bs:data",path:"raycast.ry"}]}},right:"bs.raycast:internal/uy"}
data modify storage bs:data raycast.lz set compute default float {type:"div",left:{type:"conditional",condition:"bs.raycast:internal/positive_uz",on_false:{type:"storage",storage:"bs:data",path:"raycast.rz"},on_true:{type:"add",inputs:[1,{type:"storage",storage:"bs:data",path:"raycast.rz"}]}},right:"bs.raycast:internal/uz"}

# run the recursion loop
execute if data storage bs:data raycast{blocks:1b} run data modify storage bs:data raycast.blocks set value "function #bs.hitbox:callback/get_block_shape"
execute if data storage bs:data raycast{entities:1b} run data modify storage bs:data raycast.entities set value "!bs.raycast.checked"
$execute align xyz run function bs.raycast:recurse/$(y)/next with storage bs:data raycast
tp @s ~ -100000 ~
kill @s


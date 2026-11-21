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

execute if data storage bs.hitbox:get_block out[0] run return run function bs.raycast:cast/block/shape
execute store result score #raycast.hit bs.data store result storage bs.raycast: ray._entry double 0.00000095367431640625 run compute default integer {type:"add",inputs:[{type:"mul",inputs:[16,{type:"max",inputs:[{type:"mul",inputs:[4,{type:"max",inputs:[{type:"sub",left:{type:"score",score:"bs.data",target:{type:"fixed",name:"#raycast.lx"}},right:{type:"score",score:"bs.data",target:{type:"fixed",name:"#raycast.dx"}}},-33554432]}]},{type:"add",inputs:[1,{type:"mul",inputs:[4,{type:"max",inputs:[{type:"sub",left:{type:"score",score:"bs.data",target:{type:"fixed",name:"#raycast.ly"}},right:{type:"score",score:"bs.data",target:{type:"fixed",name:"#raycast.dy"}}},-33554432]}]}]},{type:"add",inputs:[2,{type:"mul",inputs:[4,{type:"max",inputs:[{type:"sub",left:{type:"score",score:"bs.data",target:{type:"fixed",name:"#raycast.lz"}},right:{type:"score",score:"bs.data",target:{type:"fixed",name:"#raycast.dz"}}},-33554432]}]}]},3]}]},{type:"storage",storage:"bs.hitbox:get_block",path:"out"}]}
execute if score #raycast.hit bs.data >= #raycast.entity bs.data run return fail
execute store result score #raycast.next bs.data run scoreboard players operation #raycast.block bs.data = #raycast.hit bs.data
scoreboard players operation #raycast.next bs.data /= 64 bs.const
return 1

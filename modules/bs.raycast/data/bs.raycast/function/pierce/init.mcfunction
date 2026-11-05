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

# get the origin [x,y,z], in 1/16384 of a block
data modify storage bs.raycast: pos set from entity @s Pos
execute store result score #raycast.x bs.data run data get storage bs.raycast: pos[0] 16384
execute store result score #raycast.y bs.data run data get storage bs.raycast: pos[1] 16384
execute store result score #raycast.z bs.data run data get storage bs.raycast: pos[2] 16384
execute unless score #raycast.x bs.data matches -2147483647..2147483646 run function bs.raycast:utils/shift
execute unless score #raycast.z bs.data matches -2147483647..2147483646 run function bs.raycast:utils/shift

# get the direction [ux,uy,uz], in 1/65536
execute positioned 0.0 0.0 0.0 run tp @s ^ ^ ^1
data modify storage bs.raycast: pos set from entity @s Pos
execute store result score #raycast.ux bs.data run data get storage bs.raycast: pos[0] 65536
execute store result score #raycast.uy bs.data run data get storage bs.raycast: pos[1] 65536
execute store result score #raycast.uz bs.data run data get storage bs.raycast: pos[2] 65536
tp @s ~ ~ ~ ~ ~

# compute the delta [dx,dy,dz] (length to advance to the next grid intersection)
execute store result score #raycast.dx bs.data run compute default integer {type:"floor_div",left:1073741824,right:{type:"max",inputs:[{type:"abs",input:{type:"score",score:"bs.data",target:{type:"fixed",name:"#raycast.ux"}}},1]}}
execute store result score #raycast.dy bs.data run compute default integer {type:"floor_div",left:1073741824,right:{type:"max",inputs:[{type:"abs",input:{type:"score",score:"bs.data",target:{type:"fixed",name:"#raycast.uy"}}},1]}}
execute store result score #raycast.dz bs.data run compute default integer {type:"floor_div",left:1073741824,right:{type:"max",inputs:[{type:"abs",input:{type:"score",score:"bs.data",target:{type:"fixed",name:"#raycast.uz"}}},1]}}

# compute the length [lx,ly,lz] (length from the origin to the next grid intersection)
execute store result score #raycast.lx bs.data run compute default integer {type:"floor_div",left:{type:"mul",inputs:[65536,{type:"conditional",condition:{type:"int_value_check",value:{type:"add",inputs:[{type:"mul",inputs:[16384,{type:"score",score:"bs.data",target:{type:"fixed",name:"#raycast.ux"}}]},{type:"sub",left:8191,right:{type:"floor_mod",left:{type:"score",score:"bs.data",target:{type:"fixed",name:"#raycast.x"}},right:16384}}]},test:{min:0}},on_true:{type:"sub",left:16384,right:{type:"floor_mod",left:{type:"score",score:"bs.data",target:{type:"fixed",name:"#raycast.x"}},right:16384}},on_false:{type:"floor_mod",left:{type:"score",score:"bs.data",target:{type:"fixed",name:"#raycast.x"}},right:16384}}]},right:{type:"max",inputs:[{type:"abs",input:{type:"score",score:"bs.data",target:{type:"fixed",name:"#raycast.ux"}}},1]}}
execute store result score #raycast.ly bs.data run compute default integer {type:"floor_div",left:{type:"mul",inputs:[65536,{type:"conditional",condition:{type:"int_value_check",value:{type:"add",inputs:[{type:"mul",inputs:[16384,{type:"score",score:"bs.data",target:{type:"fixed",name:"#raycast.uy"}}]},{type:"sub",left:8191,right:{type:"floor_mod",left:{type:"score",score:"bs.data",target:{type:"fixed",name:"#raycast.y"}},right:16384}}]},test:{min:0}},on_true:{type:"sub",left:16384,right:{type:"floor_mod",left:{type:"score",score:"bs.data",target:{type:"fixed",name:"#raycast.y"}},right:16384}},on_false:{type:"floor_mod",left:{type:"score",score:"bs.data",target:{type:"fixed",name:"#raycast.y"}},right:16384}}]},right:{type:"max",inputs:[{type:"abs",input:{type:"score",score:"bs.data",target:{type:"fixed",name:"#raycast.uy"}}},1]}}
execute store result score #raycast.lz bs.data run compute default integer {type:"floor_div",left:{type:"mul",inputs:[65536,{type:"conditional",condition:{type:"int_value_check",value:{type:"add",inputs:[{type:"mul",inputs:[16384,{type:"score",score:"bs.data",target:{type:"fixed",name:"#raycast.uz"}}]},{type:"sub",left:8191,right:{type:"floor_mod",left:{type:"score",score:"bs.data",target:{type:"fixed",name:"#raycast.z"}},right:16384}}]},test:{min:0}},on_true:{type:"sub",left:16384,right:{type:"floor_mod",left:{type:"score",score:"bs.data",target:{type:"fixed",name:"#raycast.z"}},right:16384}},on_false:{type:"floor_mod",left:{type:"score",score:"bs.data",target:{type:"fixed",name:"#raycast.z"}},right:16384}}]},right:{type:"max",inputs:[{type:"abs",input:{type:"score",score:"bs.data",target:{type:"fixed",name:"#raycast.uz"}}},1]}}

execute store result score #raycast.kind bs.data run scoreboard players set #raycast.pending bs.data 0
execute store result score #raycast.entity bs.data store result score #raycast.block bs.data store result score #raycast.other bs.data run scoreboard players set #raycast.next bs.data 2147483647
execute store result score #raycast.octant bs.data store result storage bs.raycast: ray._octant int 1 run compute default integer {type:"sub",left:{type:"sub",left:{type:"sub",left:1,right:{type:"floor_div",left:{type:"add",inputs:[{type:"mul",inputs:[16384,{type:"score",score:"bs.data",target:{type:"fixed",name:"#raycast.ux"}}]},{type:"sub",left:8191,right:{type:"floor_mod",left:{type:"score",score:"bs.data",target:{type:"fixed",name:"#raycast.x"}},right:16384}}]},right:1073758208}},right:{type:"mul",inputs:[2,{type:"floor_div",left:{type:"add",inputs:[{type:"mul",inputs:[16384,{type:"score",score:"bs.data",target:{type:"fixed",name:"#raycast.uy"}}]},{type:"sub",left:8191,right:{type:"floor_mod",left:{type:"score",score:"bs.data",target:{type:"fixed",name:"#raycast.y"}},right:16384}}]},right:1073758208}]}},right:{type:"mul",inputs:[4,{type:"floor_div",left:{type:"add",inputs:[{type:"mul",inputs:[16384,{type:"score",score:"bs.data",target:{type:"fixed",name:"#raycast.uz"}}]},{type:"sub",left:8191,right:{type:"floor_mod",left:{type:"score",score:"bs.data",target:{type:"fixed",name:"#raycast.z"}},right:16384}}]},right:1073758208}]}}
execute store result score #raycast.max bs.data store result storage bs.raycast: ray._middle double 0.000030517578125 run data get storage bs.raycast: ray.max_distance 16384

execute unless data storage bs.raycast: ray.entities run return run function bs.raycast:pierce/setup/block with storage bs.raycast: ray
data modify storage bs.raycast: ray._reach set compute default integer {type:"add",inputs:[{type:"floor_div",left:{type:"score",score:"bs.data",target:{type:"fixed",name:"#raycast.max"}},right:32768},17]}
data modify storage bs.raycast: ray._predicate set string storage bs.raycast: ray.entities 0 11
execute unless data storage bs.raycast: ray{_predicate:"#bs.hitbox:"} run return run function bs.raycast:pierce/setup/custom with storage bs.raycast: ray
execute unless data storage bs.raycast: ray.blocks run return run function bs.raycast:pierce/setup/entity with storage bs.raycast: ray
return run function bs.raycast:pierce/setup/both with storage bs.raycast: ray

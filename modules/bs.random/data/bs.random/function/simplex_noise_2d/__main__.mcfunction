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


# Read the coordinates as fixed point numbers of 1024 units per cell, wrapped every 2^20 cells
execute store result score #x bs.ctx run compute default integer {type:"floor_mod",left:{type:"add",inputs:[{type:"mul",inputs:[1024,{type:"floor_mod",left:{type:"floor_div",left:{type:"storage",storage:"bs.random:simplex_noise_2d",path:"in.x"},right:{type:"storage",storage:"bs.random:simplex_noise_2d",path:"in.size"}},right:1048576}]},{type:"floor_div",left:{type:"mul",inputs:[1024,{type:"floor_mod",left:{type:"storage",storage:"bs.random:simplex_noise_2d",path:"in.x"},right:{type:"storage",storage:"bs.random:simplex_noise_2d",path:"in.size"}}]},right:{type:"storage",storage:"bs.random:simplex_noise_2d",path:"in.size"}}]},right:1073741824}
execute store result score #y bs.ctx run compute default integer {type:"floor_mod",left:{type:"add",inputs:[{type:"mul",inputs:[1024,{type:"floor_mod",left:{type:"floor_div",left:{type:"storage",storage:"bs.random:simplex_noise_2d",path:"in.y"},right:{type:"storage",storage:"bs.random:simplex_noise_2d",path:"in.size"}},right:1048576}]},{type:"floor_div",left:{type:"mul",inputs:[1024,{type:"floor_mod",left:{type:"storage",storage:"bs.random:simplex_noise_2d",path:"in.y"},right:{type:"storage",storage:"bs.random:simplex_noise_2d",path:"in.size"}}]},right:{type:"storage",storage:"bs.random:simplex_noise_2d",path:"in.size"}}]},right:1073741824}
execute store result score #h bs.ctx run compute default integer {type:"floor_mod",left:{type:"storage",storage:"bs.random:simplex_noise_2d",path:"in.seed"},right:46337}

# Skew by 15/41 to find the cell, then unskew by 15/71 to get the offsets from its first corner
execute store result score #s bs.ctx run compute default integer {type:"add",inputs:[{type:"mul",inputs:[15,{type:"floor_div",left:{type:"add",inputs:[{type:"score",score:"bs.ctx",target:{type:"fixed",name:"#x"}},{type:"score",score:"bs.ctx",target:{type:"fixed",name:"#y"}}]},right:41}]},{type:"floor_div",left:{type:"mul",inputs:[15,{type:"floor_mod",left:{type:"add",inputs:[{type:"score",score:"bs.ctx",target:{type:"fixed",name:"#x"}},{type:"score",score:"bs.ctx",target:{type:"fixed",name:"#y"}}]},right:41}]},right:41}]}
scoreboard players operation #i bs.ctx = #x bs.ctx
scoreboard players operation #i bs.ctx += #s bs.ctx
scoreboard players operation #i bs.ctx /= 1024 bs.const
scoreboard players operation #j bs.ctx = #y bs.ctx
scoreboard players operation #j bs.ctx += #s bs.ctx
scoreboard players operation #j bs.ctx /= 1024 bs.const
execute store result score #s bs.ctx run compute default integer {type:"add",inputs:[{type:"mul",inputs:[15360,{type:"floor_div",left:{type:"add",inputs:[{type:"score",score:"bs.ctx",target:{type:"fixed",name:"#i"}},{type:"score",score:"bs.ctx",target:{type:"fixed",name:"#j"}}]},right:71}]},{type:"floor_div",left:{type:"mul",inputs:[15360,{type:"floor_mod",left:{type:"add",inputs:[{type:"score",score:"bs.ctx",target:{type:"fixed",name:"#i"}},{type:"score",score:"bs.ctx",target:{type:"fixed",name:"#j"}}]},right:71}]},right:71}]}
scoreboard players operation #u bs.ctx = #i bs.ctx
scoreboard players operation #u bs.ctx *= -1024 bs.const
scoreboard players operation #u bs.ctx += #x bs.ctx
scoreboard players operation #u bs.ctx += #s bs.ctx
scoreboard players operation #v bs.ctx = #j bs.ctx
scoreboard players operation #v bs.ctx *= -1024 bs.const
scoreboard players operation #v bs.ctx += #y bs.ctx
scoreboard players operation #v bs.ctx += #s bs.ctx
execute store success score #c bs.ctx if score #u bs.ctx > #v bs.ctx
# Hash of the first corner, the provider derives the other two
execute store result score #a bs.ctx run compute default integer {type:"add",inputs:[{type:"mul",inputs:[31337,{type:"floor_mod",left:{type:"score",score:"bs.ctx",target:{type:"fixed",name:"#i"}},right:46337}]},{type:"floor_mod",left:{type:"score",score:"bs.ctx",target:{type:"fixed",name:"#j"}},right:46337},{type:"score",score:"bs.ctx",target:{type:"fixed",name:"#h"}}]}

data modify storage bs.random:simplex_noise_2d out set compute default float bs.random:_simplex

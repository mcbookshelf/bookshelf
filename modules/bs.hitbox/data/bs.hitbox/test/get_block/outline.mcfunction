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

# Empty and full blocks, told by the result alone
setblock ~ ~ ~ minecraft:air strict
assert result 0 run function #bs.hitbox:get_block/outline
setblock ~ ~ ~ minecraft:stone strict
assert result 1 run function #bs.hitbox:get_block/outline
assert data storage bs.hitbox:get_block {out:1}

# Fluids are nothing without their fluid variant
setblock ~ ~ ~ minecraft:water strict
assert result 0 run function #bs.hitbox:get_block/outline
setblock ~ ~ ~ minecraft:lava strict
assert result 0 run function #bs.hitbox:get_block/outline
setblock ~ ~ ~ minecraft:air strict

# Light blocks have no shape without a light item in hand, structure voids a small one
setblock ~ ~ ~ minecraft:light strict
assert result 0 run function #bs.hitbox:get_block/outline
setblock ~ ~ ~ minecraft:structure_void strict
assert result 1 run function #bs.hitbox:get_block/outline
assert not run data modify storage bs.hitbox:get_block out set value [[.3125,.3125,.3125,.6875,.6875,.6875,1.]]

# Other blocks, whose boxes are in the storage
setblock ~ ~ ~ minecraft:cactus strict
assert result 1 run function #bs.hitbox:get_block/outline
assert not run data modify storage bs.hitbox:get_block out set value [[.0625,0.,.0625,.9375,1.,.9375,1.]]
setblock ~ ~ ~ minecraft:stone_slab[type=top,waterlogged=true] strict
assert result 1 run function #bs.hitbox:get_block/outline
assert not run data modify storage bs.hitbox:get_block out set value [[0.,.5,0.,1.,1.,1.,1.]]
setblock ~ ~ ~ minecraft:snow[layers=3] strict
assert result 1 run function #bs.hitbox:get_block/outline
assert not run data modify storage bs.hitbox:get_block out set value [[0.,0.,0.,1.,.375,1.,1.]]
setblock ~ ~ ~ minecraft:oak_stairs[facing=north,half=bottom,shape=straight] strict
assert result 1 run function #bs.hitbox:get_block/outline
assert not run data modify storage bs.hitbox:get_block out set value [[0.,0.,0.,1.,.5,1.,1.],[0.,.5,0.,1.,1.,.5,1.]]
setblock ~ ~ ~ minecraft:oak_fence_gate[facing=north,open=false] strict
assert result 1 run function #bs.hitbox:get_block/outline
assert not run data modify storage bs.hitbox:get_block out set value [[0.,0.,.375,1.,1.,.625,1.]]
setblock ~ ~ ~ minecraft:pale_moss_carpet[bottom=true] strict
assert result 1 run function #bs.hitbox:get_block/outline
assert not run data modify storage bs.hitbox:get_block out set value [[0.,0.,0.,1.,.0625,1.,1.]]
setblock ~ ~ ~ minecraft:pale_moss_carpet[bottom=false,east=low] strict
assert result 1 run function #bs.hitbox:get_block/outline
assert not run data modify storage bs.hitbox:get_block out set value [[.9375,0.,0.,1.,.625,1.,1.]]

# Blocks moved by their position, as the game does
forceload add 0 0
await loaded 0 319 0
setblock 0 319 0 minecraft:poppy strict
assert result 1 run execute positioned 0 319 0 run function #bs.hitbox:get_block/outline
assert not run data modify storage bs.hitbox:get_block out set value [[.0625,0.,.0625,.4375,.625,.4375,1.]]
setblock 5 319 11 minecraft:poppy strict
assert result 1 run execute positioned 5 319 11 run function #bs.hitbox:get_block/outline
assert not run data modify storage bs.hitbox:get_block out set value [[.3958333432674408,0.,.09583333507180214,.7708333432674408,.625,.47083333507180214,1.]]
setblock 15 319 3 minecraft:bamboo[leaves=large] strict
assert result 1 run execute positioned 15 319 3 run function #bs.hitbox:get_block/outline
assert not run data modify storage bs.hitbox:get_block out set value [[.30416667461395264,0.,.3375000059604645,.9291666746139526,1.,.9625000059604645,1.]]
setblock 5 319 11 minecraft:pointed_dripstone strict
assert result 1 run execute positioned 5 319 11 run function #bs.hitbox:get_block/outline
assert not run data modify storage bs.hitbox:get_block out set value [[.3958333432674408,0.,.1875,.7708333432674408,.6875,.5625,1.]]
setblock 0 319 0 minecraft:air strict
setblock 5 319 11 minecraft:air strict
setblock 15 319 3 minecraft:air strict

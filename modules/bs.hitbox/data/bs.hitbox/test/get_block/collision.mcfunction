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

# Empty blocks leave the storage alone, full ones store their flag, even twice in a row
setblock ~ ~ ~ minecraft:air strict
assert result 0 run function #bs.hitbox:get_block/collision
execute if function #bs.hitbox:get_block/collision run fail "an empty block passed if function"
setblock ~ ~ ~ minecraft:stone strict
assert result 1 run function #bs.hitbox:get_block/collision
assert data storage bs.hitbox:get_block {out:1}
assert result 1 run function #bs.hitbox:get_block/collision
assert data storage bs.hitbox:get_block {out:1}
execute unless function #bs.hitbox:get_block/collision run fail "a full block failed if function"

# Fluids are nothing without their fluid variant
setblock ~ ~ ~ minecraft:water strict
assert result 0 run function #bs.hitbox:get_block/collision
setblock ~ ~ ~ minecraft:lava strict
assert result 0 run function #bs.hitbox:get_block/collision
setblock ~ ~ ~ minecraft:air strict

# Light blocks have no shape without a light item in hand, structure voids a small one
setblock ~ ~ ~ minecraft:light strict
assert result 0 run function #bs.hitbox:get_block/collision
setblock ~ ~ ~ minecraft:structure_void strict
assert result 0 run function #bs.hitbox:get_block/collision

# Other blocks, whose boxes are in the storage
setblock ~ ~ ~ minecraft:cactus strict
assert result 1 run function #bs.hitbox:get_block/collision
assert not run data modify storage bs.hitbox:get_block out set value [[.0625,0.,.0625,.9375,.9375,.9375,1.]]
setblock ~ ~ ~ minecraft:stone_slab[type=top,waterlogged=true] strict
assert result 1 run function #bs.hitbox:get_block/collision
assert not run data modify storage bs.hitbox:get_block out set value [[0.,.5,0.,1.,1.,1.,1.]]
setblock ~ ~ ~ minecraft:snow[layers=3] strict
assert result 1 run function #bs.hitbox:get_block/collision
assert not run data modify storage bs.hitbox:get_block out set value [[0.,0.,0.,1.,.25,1.,1.]]
setblock ~ ~ ~ minecraft:oak_stairs[facing=north,half=bottom,shape=straight] strict
assert result 1 run function #bs.hitbox:get_block/collision
assert not run data modify storage bs.hitbox:get_block out set value [[0.,0.,0.,1.,.5,1.,1.],[0.,.5,0.,1.,1.,.5,1.]]
setblock ~ ~ ~ minecraft:oak_fence_gate[facing=north,open=false] strict
assert result 1 run function #bs.hitbox:get_block/collision
assert not run data modify storage bs.hitbox:get_block out set value [[0.,0.,.375,1.,1.5,.625,1.]]
setblock ~ ~ ~ minecraft:pale_moss_carpet[bottom=true] strict
assert result 1 run function #bs.hitbox:get_block/collision
assert not run data modify storage bs.hitbox:get_block out set value [[0.,0.,0.,1.,.0625,1.,1.]]
setblock ~ ~ ~ minecraft:pale_moss_carpet[bottom=false,east=low] strict
assert result 0 run function #bs.hitbox:get_block/collision

# Blocks with no collision
setblock ~ ~ ~ minecraft:short_grass strict
assert result 0 run function #bs.hitbox:get_block/collision
setblock ~ ~ ~ minecraft:oak_fence_gate[facing=north,open=true] strict
assert result 0 run function #bs.hitbox:get_block/collision

# Blocks moved by their position, as the game does
forceload add 0 0
await loaded 0 319 0
setblock 7 319 2 minecraft:bamboo strict
assert result 1 run execute positioned 7 319 2 run function #bs.hitbox:get_block/collision
assert not run data modify storage bs.hitbox:get_block out set value [[.18958333507180214,0.,.3895833343267441,.37708333507180214,1.,.5770833343267441,1.]]
setblock 12 319 9 minecraft:pointed_dripstone strict
assert result 1 run execute positioned 12 319 9 run function #bs.hitbox:get_block/collision
assert not run data modify storage bs.hitbox:get_block out set value [[.4375,0.,.1875,.8125,.6875,.5625,1.]]
setblock 7 319 2 minecraft:air strict
setblock 12 319 9 minecraft:air strict

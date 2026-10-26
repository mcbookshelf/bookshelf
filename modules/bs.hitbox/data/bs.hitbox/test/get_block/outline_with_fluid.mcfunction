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

# Blocks without fluid, as without it
setblock ~ ~ ~ minecraft:air strict
assert result 0 run function #bs.hitbox:get_block/outline_with_fluid
setblock ~ ~ ~ minecraft:stone strict
assert result 1 run function #bs.hitbox:get_block/outline_with_fluid
assert data storage bs.hitbox:get_block {out:1}
setblock ~ ~ ~ minecraft:cactus strict
assert result 1 run function #bs.hitbox:get_block/outline_with_fluid
assert not run data modify storage bs.hitbox:get_block out set value [[.0625,0.,.0625,.9375,1.,.9375,1.]]

# Fluids, by level
setblock ~ ~ ~ minecraft:water strict
assert result 1 run function #bs.hitbox:get_block/outline_with_fluid
assert not run data modify storage bs.hitbox:get_block out set value [[0.,0.,0.,1.,.8888888955116272,1.,2.]]
setblock ~ ~ ~ minecraft:water[level=3] strict
assert result 1 run function #bs.hitbox:get_block/outline_with_fluid
assert not run data modify storage bs.hitbox:get_block out set value [[0.,0.,0.,1.,.5555555820465088,1.,2.]]
setblock ~ ~ ~ minecraft:water[level=9] strict
assert result 1 run function #bs.hitbox:get_block/outline_with_fluid
assert not run data modify storage bs.hitbox:get_block out set value [[0.,0.,0.,1.,.8888888955116272,1.,2.]]
setblock ~ ~ ~ minecraft:lava[level=6] strict
assert result 1 run function #bs.hitbox:get_block/outline_with_fluid
assert not run data modify storage bs.hitbox:get_block out set value [[0.,0.,0.,1.,.2222222238779068,1.,2.]]

# Fluids under the same fluid are full blocks
setblock ~ ~ ~ minecraft:water strict
setblock ~ ~1 ~ minecraft:water strict
assert result 1 run function #bs.hitbox:get_block/outline_with_fluid
assert data storage bs.hitbox:get_block {out:2}
setblock ~ ~ ~ minecraft:lava strict
setblock ~ ~1 ~ minecraft:lava strict
assert result 1 run function #bs.hitbox:get_block/outline_with_fluid
assert data storage bs.hitbox:get_block {out:2}
setblock ~ ~ ~ minecraft:water[level=3] strict
setblock ~ ~1 ~ minecraft:water strict
assert result 1 run function #bs.hitbox:get_block/outline_with_fluid
assert data storage bs.hitbox:get_block {out:2}
setblock ~ ~ ~ minecraft:water strict
setblock ~ ~1 ~ minecraft:lava strict
assert result 1 run function #bs.hitbox:get_block/outline_with_fluid
assert not run data modify storage bs.hitbox:get_block out set value [[0.,0.,0.,1.,.8888888955116272,1.,2.]]
setblock ~ ~1 ~ minecraft:air strict
setblock ~ ~ ~ minecraft:lava strict
setblock ~ ~1 ~ minecraft:water strict
assert result 1 run function #bs.hitbox:get_block/outline_with_fluid
assert not run data modify storage bs.hitbox:get_block out set value [[0.,0.,0.,1.,.8888888955116272,1.,2.]]
setblock ~ ~ ~ minecraft:water strict
setblock ~ ~1 ~ minecraft:oak_slab[waterlogged=true] strict
assert result 1 run function #bs.hitbox:get_block/outline_with_fluid
assert data storage bs.hitbox:get_block {out:2}
setblock ~ ~1 ~ minecraft:air strict

# Blocks holding water
setblock ~ ~ ~ minecraft:stone_slab[waterlogged=true] strict
assert result 1 run function #bs.hitbox:get_block/outline_with_fluid
assert not run data modify storage bs.hitbox:get_block out set value [[0.,0.,0.,1.,.5,1.,1.],[0.,0.,0.,1.,.8888888955116272,1.,2.]]
setblock ~ ~ ~ minecraft:stone_slab[waterlogged=true] strict
setblock ~ ~1 ~ minecraft:water strict
assert result 1 run function #bs.hitbox:get_block/outline_with_fluid
assert not run data modify storage bs.hitbox:get_block out set value [[0.,0.,0.,1.,.5,1.,1.],[0.,0.,0.,1.,1.,1.,2.]]
setblock ~ ~1 ~ minecraft:air strict
setblock ~ ~ ~ minecraft:oak_leaves[waterlogged=true] strict
assert result 1 run function #bs.hitbox:get_block/outline_with_fluid
assert not run data modify storage bs.hitbox:get_block out set value [[0.,0.,0.,1.,1.,1.,1.],[0.,0.,0.,1.,.8888888955116272,1.,2.]]
setblock ~ ~ ~ minecraft:oak_leaves[waterlogged=true] strict
setblock ~ ~1 ~ minecraft:water strict
assert result 1 run function #bs.hitbox:get_block/outline_with_fluid
assert data storage bs.hitbox:get_block {out:3}
setblock ~ ~1 ~ minecraft:air strict
setblock ~ ~ ~ minecraft:light[level=5,waterlogged=true] strict
assert result 1 run function #bs.hitbox:get_block/outline_with_fluid
assert not run data modify storage bs.hitbox:get_block out set value [[0.,0.,0.,1.,.8888888955116272,1.,2.]]
setblock ~ ~ ~ minecraft:kelp strict
assert result 1 run function #bs.hitbox:get_block/outline_with_fluid
assert not run data modify storage bs.hitbox:get_block out set value [[0.,0.,0.,1.,.5625,1.,1.],[0.,0.,0.,1.,.8888888955116272,1.,2.]]
setblock ~ ~1 ~ minecraft:air strict

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

# Other blocks, as their shape
setblock ~ ~ ~ minecraft:air strict
assert result 0 run function #bs.hitbox:get_block/interaction_with_fluid
setblock ~ ~ ~ minecraft:stone strict
assert result 1 run function #bs.hitbox:get_block/interaction_with_fluid
assert data storage bs.hitbox:get_block {out:1}
setblock ~ ~ ~ minecraft:cactus strict
assert result 1 run function #bs.hitbox:get_block/interaction_with_fluid
assert not run data modify storage bs.hitbox:get_block out set value [[.0625,0.,.0625,.9375,1.,.9375,1.]]

# Blocks placed against more than their shape
setblock ~ ~ ~ minecraft:cauldron strict
assert result 1 run function #bs.hitbox:get_block/interaction_with_fluid
assert not run data modify storage bs.hitbox:get_block out set value [[0.,.1875,0.,1.,.25,1.,1.],[.875,.1875,0.,1.,1.,1.,1.],[0.,.1875,0.,.125,1.,1.,1.],[0.,.1875,.875,1.,1.,1.,1.],[0.,.1875,0.,1.,1.,.125,1.],[.75,0.,0.,1.,1.,.125,1.],[0.,0.,.875,.25,1.,1.,1.],[.875,0.,.75,1.,1.,1.,1.],[0.,0.,0.,.25,1.,.125,1.],[.75,0.,.875,1.,1.,1.,1.],[0.,0.,0.,.125,1.,.25,1.],[.875,0.,0.,1.,1.,.25,1.],[0.,0.,.75,.125,1.,1.,1.],[0.,.1875,0.,1.,1.,1.,4.]]
setblock ~ ~ ~ minecraft:water_cauldron[level=2] strict
assert result 1 run function #bs.hitbox:get_block/interaction_with_fluid
assert not run data modify storage bs.hitbox:get_block out set value [[0.,.1875,0.,1.,.25,1.,1.],[.875,.1875,0.,1.,1.,1.,1.],[0.,.1875,0.,.125,1.,1.,1.],[0.,.1875,.875,1.,1.,1.,1.],[0.,.1875,0.,1.,1.,.125,1.],[.75,0.,0.,1.,1.,.125,1.],[0.,0.,.875,.25,1.,1.,1.],[.875,0.,.75,1.,1.,1.,1.],[0.,0.,0.,.25,1.,.125,1.],[.75,0.,.875,1.,1.,1.,1.],[0.,0.,0.,.125,1.,.25,1.],[.875,0.,0.,1.,1.,.25,1.],[0.,0.,.75,.125,1.,1.,1.],[0.,.1875,0.,1.,1.,1.,4.]]
setblock ~ ~ ~ minecraft:hopper strict
assert result 1 run function #bs.hitbox:get_block/interaction_with_fluid
assert not run data modify storage bs.hitbox:get_block out set value [[0.,.625,0.,1.,.6875,1.,1.],[.25,.25,.25,.75,.6875,.75,1.],[0.,.625,0.,1.,1.,.125,1.],[0.,.625,.875,1.,1.,1.,1.],[.875,.625,0.,1.,1.,1.,1.],[0.,.625,0.,.125,1.,1.,1.],[.375,0.,.375,.625,.6875,.625,1.],[0.,.625,0.,1.,1.,1.,4.]]
setblock ~ ~ ~ minecraft:composter strict
assert result 1 run function #bs.hitbox:get_block/interaction_with_fluid
assert not run data modify storage bs.hitbox:get_block out set value [[0.,0.,0.,1.,.125,1.,1.],[0.,.125,0.,.125,1.,1.,1.],[.125,.125,0.,1.,1.,.125,1.],[.125,.125,.875,1.,1.,1.,1.],[.875,.125,.125,1.,1.,.875,1.],[0.,0.,0.,1.,1.,1.,4.]]
setblock ~ ~ ~ minecraft:scaffolding strict
assert result 1 run function #bs.hitbox:get_block/interaction_with_fluid
assert not run data modify storage bs.hitbox:get_block out set value [[0.,.875,0.,1.,1.,1.,1.],[0.,0.,0.,.125,1.,.125,1.],[0.,0.,.875,.125,1.,1.,1.],[.875,0.,0.,1.,1.,.125,1.],[.875,0.,.875,1.,1.,1.,1.],[0.,0.,0.,1.,1.,1.,4.]]

# Placement boxes after the fluid
setblock ~ ~ ~ minecraft:scaffolding[waterlogged=true] strict
assert result 1 run function #bs.hitbox:get_block/interaction_with_fluid
assert not run data modify storage bs.hitbox:get_block out set value [[0.,.875,0.,1.,1.,1.,1.],[0.,0.,0.,.125,1.,.125,1.],[0.,0.,.875,.125,1.,1.,1.],[.875,0.,0.,1.,1.,.125,1.],[.875,0.,.875,1.,1.,1.,1.],[0.,0.,0.,1.,.8888888955116272,1.,2.],[0.,0.,0.,1.,1.,1.,4.]]

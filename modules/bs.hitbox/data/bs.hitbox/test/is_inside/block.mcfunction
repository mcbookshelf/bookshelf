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

# Empty and full blocks answer without their boxes
data modify storage bs.hitbox:is_inside/block in.blocks set value "#bs.hitbox:get_block/collision"
setblock ~ ~ ~ minecraft:air strict
execute positioned ~.5 ~.5 ~.5 if function #bs.hitbox:is_inside/block run fail "a position in air is inside"
setblock ~ ~ ~ minecraft:stone strict
execute positioned ~.5 ~.5 ~.5 unless function #bs.hitbox:is_inside/block run fail "a position in stone is outside"
execute positioned ~.5 ~.5 ~.5 run assert result 1 run function #bs.hitbox:is_inside/block

# A box holds its lower faces, not its upper ones
setblock ~ ~ ~ minecraft:stone_slab strict
execute positioned ~.5 ~.25 ~.5 unless function #bs.hitbox:is_inside/block run fail "a position in a slab is outside"
execute positioned ~.5 ~.25 ~.5 run assert result 1 run function #bs.hitbox:is_inside/block
execute positioned ~ ~ ~ unless function #bs.hitbox:is_inside/block run fail "a lower corner of a slab is outside"
execute positioned ~.5 ~.5 ~.5 if function #bs.hitbox:is_inside/block run fail "the top of a slab is inside"
execute positioned ~.5 ~.75 ~.5 if function #bs.hitbox:is_inside/block run fail "a position above a slab is inside"

# Each block of a stair is checked
setblock ~ ~ ~ minecraft:stone_stairs[facing=east] strict
execute positioned ~.75 ~.75 ~.5 unless function #bs.hitbox:is_inside/block run fail "a position in the step of a stair is outside"
execute positioned ~.25 ~.75 ~.5 if function #bs.hitbox:is_inside/block run fail "a position above the lower part of a stair is inside"

# Providers decide the boxes: the inside of a cauldron is empty for collision, not for interaction
setblock ~ ~ ~ minecraft:cauldron strict
execute positioned ~.5 ~.5 ~.5 if function #bs.hitbox:is_inside/block run fail "the inside of a cauldron is inside its collision"
data modify storage bs.hitbox:is_inside/block in.blocks set value "#bs.hitbox:get_block/interaction"
execute positioned ~.5 ~.5 ~.5 unless function #bs.hitbox:is_inside/block run fail "the inside of a cauldron is outside its interaction"
execute positioned ~.5 ~.5 ~.5 run assert result 1 run function #bs.hitbox:is_inside/block

# Fluids count with their fluid variant, up to their height
setblock ~ ~ ~ minecraft:water strict
data modify storage bs.hitbox:is_inside/block in.blocks set value "#bs.hitbox:get_block/collision"
execute positioned ~.5 ~.5 ~.5 if function #bs.hitbox:is_inside/block run fail "a position in water is inside the collision"
data modify storage bs.hitbox:is_inside/block in.blocks set value "#bs.hitbox:get_block/collision_with_fluid"
execute positioned ~.5 ~.5 ~.5 unless function #bs.hitbox:is_inside/block run fail "a position in water is outside"
execute positioned ~.5 ~.5 ~.5 run assert result 1 run function #bs.hitbox:is_inside/block
execute positioned ~.5 ~.95 ~.5 if function #bs.hitbox:is_inside/block run fail "a position above the water surface is inside"
setblock ~ ~ ~ minecraft:air strict

# Flags combine: the solid part of a waterlogged slab is also in its water
setblock ~ ~ ~ minecraft:stone_slab[waterlogged=true] strict
execute positioned ~.5 ~.25 ~.5 run assert result 1 run function #bs.hitbox:is_inside/block
execute positioned ~.5 ~.75 ~.5 run assert result 1 run function #bs.hitbox:is_inside/block
setblock ~ ~ ~ minecraft:air strict

# Every box counts, up to 24
execute positioned ~.5 ~.5 ~.5 summon minecraft:marker run function bs.hitbox:utils/get_fract_pos
data modify storage bs.hitbox:get_block out set value [[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[0d,0d,0d,1d,1d,1d,1d]]
scoreboard players set #n bs.ctx 24
assert predicate bs.hitbox:_is_inside/block/inside
scoreboard players set #n bs.ctx 23
execute if predicate bs.hitbox:_is_inside/block/inside run fail "a box past the count of the block is checked"

# A provider is a function tag or a plain function
setblock ~ ~ ~ minecraft:stone strict
data modify storage bs.hitbox:is_inside/block in set value {blocks:"bs.hitbox:get_block/collision/__main__"}
execute positioned ~.5 ~.5 ~.5 run assert result 1 run function #bs.hitbox:is_inside/block

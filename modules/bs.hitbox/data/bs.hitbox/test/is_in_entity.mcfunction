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

# A cow is 0.9 wide and 1.4 high, from its feet
summon minecraft:cow ~ ~ ~ {Tags:["ward.hitbox.cow"],NoAI:1b,NoGravity:1b}
data modify storage bs.hitbox:is_in_entity in.entities set value "#bs.hitbox:get_entity/sized"
execute as @n[tag=ward.hitbox.cow] positioned ~ ~.7 ~ unless function #bs.hitbox:is_in_entity run fail "the middle of a cow is outside"
execute as @n[tag=ward.hitbox.cow] positioned ~ ~.7 ~ unless function bs.hitbox:is_in_entity/custom run fail "custom path: the middle of a cow is outside"
execute as @n[tag=ward.hitbox.cow] positioned ~.4 ~.1 ~.4 unless function #bs.hitbox:is_in_entity run fail "a corner of a cow is outside"
execute as @n[tag=ward.hitbox.cow] positioned ~.4 ~.1 ~.4 unless function bs.hitbox:is_in_entity/custom run fail "custom path: a corner of a cow is outside"
execute as @n[tag=ward.hitbox.cow] positioned ~-.4 ~1.3 ~-.4 unless function #bs.hitbox:is_in_entity run fail "the other corner of a cow is outside"
execute as @n[tag=ward.hitbox.cow] positioned ~-.4 ~1.3 ~-.4 unless function bs.hitbox:is_in_entity/custom run fail "custom path: the other corner of a cow is outside"
execute as @n[tag=ward.hitbox.cow] positioned ~.5 ~.7 ~ if function #bs.hitbox:is_in_entity run fail "a position beside a cow is inside"
execute as @n[tag=ward.hitbox.cow] positioned ~.5 ~.7 ~ if function bs.hitbox:is_in_entity/custom run fail "custom path: a position beside a cow is inside"
execute as @n[tag=ward.hitbox.cow] positioned ~ ~1.5 ~ if function #bs.hitbox:is_in_entity run fail "a position above a cow is inside"
execute as @n[tag=ward.hitbox.cow] positioned ~ ~1.5 ~ if function bs.hitbox:is_in_entity/custom run fail "custom path: a position above a cow is inside"
execute as @n[tag=ward.hitbox.cow] positioned ~ ~-.1 ~ if function #bs.hitbox:is_in_entity run fail "a position below a cow is inside"
execute as @n[tag=ward.hitbox.cow] positioned ~ ~-.1 ~ if function bs.hitbox:is_in_entity/custom run fail "custom path: a position below a cow is inside"

# The box follows the scale of the entity
summon minecraft:cow ~ ~ ~ {Tags:["ward.hitbox.cow.scaled"],NoAI:1b,NoGravity:1b}
attribute @n[tag=ward.hitbox.cow.scaled] minecraft:scale base set 2
await delay 1t
execute as @n[tag=ward.hitbox.cow.scaled] positioned ~.8 ~2.7 ~ unless function #bs.hitbox:is_in_entity run fail "a position in a scaled cow is outside"
execute as @n[tag=ward.hitbox.cow.scaled] positioned ~.8 ~2.7 ~ unless function bs.hitbox:is_in_entity/custom run fail "custom path: a position in a scaled cow is outside"
execute as @n[tag=ward.hitbox.cow.scaled] positioned ~ ~2.9 ~ if function #bs.hitbox:is_in_entity run fail "a position above a scaled cow is inside"
execute as @n[tag=ward.hitbox.cow.scaled] positioned ~ ~2.9 ~ if function bs.hitbox:is_in_entity/custom run fail "custom path: a position above a scaled cow is inside"

# A provider giving no box leaves the entity out
data modify storage bs.hitbox:is_in_entity in.entities set value "#bs.hitbox:get_entity/solid"
execute as @n[tag=ward.hitbox.cow] positioned ~ ~.7 ~ if function #bs.hitbox:is_in_entity run fail "a cow has a solid box"
execute as @n[tag=ward.hitbox.cow] positioned ~ ~.7 ~ if function bs.hitbox:is_in_entity/custom run fail "custom path: a cow has a solid box"

# Every box counts, up to 8
data modify storage bs.hitbox: rel set value [.5d,.5d,.5d]
data modify storage bs.hitbox:get_entity out set value [[10f,10f,10f,11f,11f,11f,1f],[10f,10f,10f,11f,11f,11f,1f],[10f,10f,10f,11f,11f,11f,1f],[10f,10f,10f,11f,11f,11f,1f],[10f,10f,10f,11f,11f,11f,1f],[10f,10f,10f,11f,11f,11f,1f],[10f,10f,10f,11f,11f,11f,1f],[0f,0f,0f,1f,1f,1f,1f]]
scoreboard players set #m bs.ctx 8
assert predicate bs.hitbox:_is_in_entity/inside
scoreboard players set #m bs.ctx 7
execute if predicate bs.hitbox:_is_in_entity/inside run fail "a box past the count of the entity is checked"

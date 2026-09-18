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

summon marker ~ ~ ~ {Tags:["ward.animation.play"],Rotation:[0f,0f]}
data modify storage bs.animation:attach in set value {id:"play",run:"function #bs.animation:apply/rotation",type:"linear",duration:4,points:[[0,0],[40,0]]}
execute as @n[tag=ward.animation.play] run function #bs.animation:attach
data modify storage bs.animation:attach in set value {id:"play",run:"data modify storage ward:animation play append value 1b",type:"linear",duration:4,points:[[0],[1]]}
execute as @n[tag=ward.animation.play] run function #bs.animation:attach
data modify storage bs.animation:attach in set value {id:"other",run:"",type:"linear",duration:4,points:[[0],[1]]}
execute as @n[tag=ward.animation.play] run function #bs.animation:attach

# unknown id: fails, nothing scheduled
data modify storage bs.animation:play in set value {id:"missing"}
assert not run execute as @n[tag=ward.animation.play] run function #bs.animation:play
assert not data entity @n[tag=ward.animation.play] data."bs.animation"[{id:"play"}].w

# loop:1b sets l on both tracks sharing the id, not on the other one; both callbacks ran once
data modify storage ward:animation play set value []
data modify storage bs.animation:play in set value {id:"play",loop:1b}
assert run execute as @n[tag=ward.animation.play] run function #bs.animation:play
assert result 2 run execute if data entity @n[tag=ward.animation.play] data."bs.animation"[{id:"play",l:1b}]
assert not data entity @n[tag=ward.animation.play] data."bs.animation"[{id:"other"}].l
assert not data entity @n[tag=ward.animation.play] data."bs.animation"[{id:"other"}].w
assert result 1 run data get storage ward:animation play

# loop absent: l untouched; loop:0b: l removed on both
data modify storage bs.animation:play in set value {id:"play"}
assert run execute as @n[tag=ward.animation.play] run function #bs.animation:play
assert result 2 run execute if data entity @n[tag=ward.animation.play] data."bs.animation"[{id:"play",l:1b}]
data modify storage bs.animation:play in set value {id:"play",loop:0b}
assert run execute as @n[tag=ward.animation.play] run function #bs.animation:play
assert not data entity @n[tag=ward.animation.play] data."bs.animation"[{id:"play"}].l

# the process steps both tracks each tick
data modify storage ward:animation play set value []
await delay 2t
assert result 20 run data get entity @n[tag=ward.animation.play] Rotation[0]
assert result 2 run data get storage ward:animation play

# no loop: both halt at the end
await delay 2t
assert result 40 run data get entity @n[tag=ward.animation.play] Rotation[0]
assert not data entity @n[tag=ward.animation.play] data."bs.animation"[{id:"play"}].w

data remove storage ward:animation play
kill @n[tag=ward.animation.play]

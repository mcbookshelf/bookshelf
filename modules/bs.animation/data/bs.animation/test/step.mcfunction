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

kill @e[tag=ward.animation.step]
summon marker ~ ~ ~ {Tags:["ward.animation.step"],Rotation:[0f,0f]}
data modify storage ward:animation step.calls set value []

data modify storage bs.animation:attach in set value {id:"step",run:"function #bs.animation:apply/rotation",type:"linear",duration:4,points:[[0,0],[40,0]]}
assert run execute as @n[tag=ward.animation.step] run function #bs.animation:attach
data modify storage bs.animation:attach in set value {id:"step",run:"data modify storage ward:animation step.calls append value 1b",type:"linear",duration:4,points:[[0],[1]]}
assert run execute as @n[tag=ward.animation.step] run function #bs.animation:attach

# unknown id: fails, nothing moves
data modify storage bs.animation:step in set value {id:"missing"}
assert not run execute as @n[tag=ward.animation.step] run function #bs.animation:step
assert result 0 run data get entity @n[tag=ward.animation.step] Rotation[0]

# no step field: advances one tick without any play, both tracks, callbacks once each
data modify storage bs.animation:step in set value {id:"step"}
assert run execute as @n[tag=ward.animation.step] run function #bs.animation:step
assert result 10 run data get entity @n[tag=ward.animation.step] Rotation[0]
assert result 250 run data get entity @n[tag=ward.animation.step] data."bs.animation"[{id:"step",run:"function #bs.animation:apply/rotation"}].t 1000
assert result 1 run data get storage ward:animation step.calls

# step override: two ticks at once
data modify storage bs.animation:step in set value {id:"step",step:2}
assert run execute as @n[tag=ward.animation.step] run function #bs.animation:step
assert result 30 run data get entity @n[tag=ward.animation.step] Rotation[0]
assert result 2 run data get storage ward:animation step.calls

# negative override: back one tick
data modify storage bs.animation:step in set value {id:"step",step:-1}
assert run execute as @n[tag=ward.animation.step] run function #bs.animation:step
assert result 20 run data get entity @n[tag=ward.animation.step] Rotation[0]

# fractional override
data modify storage bs.animation:step in set value {id:"step",step:0.5}
assert run execute as @n[tag=ward.animation.step] run function #bs.animation:step
assert result 25 run data get entity @n[tag=ward.animation.step] Rotation[0]

# the override never touches s: play afterwards runs at the track's own speed
data modify storage bs.animation:play in set value {id:"step",step:1}
assert run execute as @n[tag=ward.animation.step] run function #bs.animation:play
await delay 1t
assert result 35 run data get entity @n[tag=ward.animation.step] Rotation[0]

data remove storage ward:animation step
kill @e[tag=ward.animation.step]

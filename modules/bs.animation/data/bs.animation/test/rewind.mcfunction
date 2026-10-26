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

summon marker ~ ~ ~ {Tags:["ward.animation.rewind"],Rotation:[0f,0f]}
data modify storage ward:animation rewind.calls set value []

data modify storage bs.animation:attach in set value {id:"rewind",run:"function #bs.animation:apply/rotation",type:"linear",duration:[4,4],points:[[0,0],[40,0],[80,0]]}
assert run execute as @n[tag=ward.animation.rewind] run function #bs.animation:attach
data modify storage bs.animation:attach in set value {id:"rewind",run:"data modify storage ward:animation rewind.calls append value 1b",type:"linear",duration:8,points:[[0],[1]]}
assert run execute as @n[tag=ward.animation.rewind] run function #bs.animation:attach
data modify storage bs.animation:attach in set value {id:"other",run:"scoreboard players get #s bs.ctx",type:"linear",duration:8,points:[[0],[1]]}
assert run execute as @n[tag=ward.animation.rewind] run function #bs.animation:attach

# unknown id fails
data modify storage bs.animation:rewind in set value {id:"missing"}
assert not run execute as @n[tag=ward.animation.rewind] run function #bs.animation:rewind

# rewind while playing: back to frame 0, keeps playing
data modify storage bs.animation:play in set value {id:"rewind",step:1,loop:1b,interval:2}
assert run execute as @n[tag=ward.animation.rewind] run function #bs.animation:play
data modify storage bs.animation:step in set value {id:"other",step:4}
assert run execute as @n[tag=ward.animation.rewind] run function #bs.animation:step
await delay 6t
assert result 60 run data get entity @n[tag=ward.animation.rewind] Rotation[0]
assert result 1 run data get entity @n[tag=ward.animation.rewind] data."bs.animation"[{id:"rewind",run:"function #bs.animation:apply/rotation"}].i
assert result 750 run data get entity @n[tag=ward.animation.rewind] data."bs.animation"[{id:"rewind",run:"data modify storage ward:animation rewind.calls append value 1b"}].t 1000

data modify storage ward:animation rewind.calls set value []
data modify storage bs.animation:rewind in set value {id:"rewind"}
assert run execute as @n[tag=ward.animation.rewind] run function #bs.animation:rewind
assert result 0 run data get entity @n[tag=ward.animation.rewind] Rotation[0]
assert result 2 run execute if data entity @n[tag=ward.animation.rewind] data."bs.animation"[{id:"rewind",i:0,t:0.0f,v:2,l:1b}]
assert result 2 run execute if data entity @n[tag=ward.animation.rewind] data."bs.animation"[{id:"rewind",s:1}]
assert result 1 run data get storage ward:animation rewind.calls
assert data entity @n[tag=ward.animation.rewind] data."bs.animation"[{id:"rewind"}].w
assert result 0 run data get entity @n[tag=ward.animation.rewind] data."bs.animation"[{id:"rewind",run:"function #bs.animation:apply/rotation"}].p[0][0]
assert result 4 run data get entity @n[tag=ward.animation.rewind] data."bs.animation"[{id:"rewind",run:"function #bs.animation:apply/rotation"}].d[0]
assert result 500 run data get entity @n[tag=ward.animation.rewind] data."bs.animation"[{id:"other"}].t 1000
await delay 2t
assert result 20 run data get entity @n[tag=ward.animation.rewind] Rotation[0]
assert result 2 run data get storage ward:animation rewind.calls

# rewind while paused: back to frame 0, stays paused
data modify storage bs.animation:pause in set value {id:"rewind"}
assert run execute as @n[tag=ward.animation.rewind] run function #bs.animation:pause
data modify storage bs.animation:rewind in set value {id:"rewind"}
assert run execute as @n[tag=ward.animation.rewind] run function #bs.animation:rewind
assert result 0 run data get entity @n[tag=ward.animation.rewind] Rotation[0]
assert not data entity @n[tag=ward.animation.rewind] data."bs.animation"[{id:"rewind"}].w
await delay 2t
assert result 0 run data get entity @n[tag=ward.animation.rewind] Rotation[0]

data remove storage ward:animation rewind
kill @e[tag=ward.animation.rewind]

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

kill @e[tag=ward.animation.rel_position]
execute align xyz run summon marker ~ ~ ~ {Tags:["ward.animation.rel_position"]}
data modify storage ward:animation rel_position.anchor set from entity @n[tag=ward.animation.rel_position] Pos

data modify storage bs.animation:attach in set value {id:"rel",run:"function #bs.animation:apply/rel_position",type:"linear",duration:4,points:[[0,0,0],[32,0,0]]}
assert run execute as @n[tag=ward.animation.rel_position] run function #bs.animation:attach

# play anchors at the current position, frame 0 is the anchor itself
data modify storage bs.animation:play in set value {id:"rel"}
assert run execute as @n[tag=ward.animation.rel_position] run function #bs.animation:play
assert data entity @n[tag=ward.animation.rel_position] data."bs.animation"[{id:"rel"}]._
data modify storage ward:animation rel_position.pos set from entity @n[tag=ward.animation.rel_position] Pos
assert predicate {type:"float_value_check",value:{type:sub,left:{type:storage,storage:"ward:animation",path:"rel_position.pos[0]"},right:{type:storage,storage:"ward:animation",path:"rel_position.anchor[0]"}},test:{min:-2.0,max:2.0}}

# two ticks later: anchor + 16 along x
await delay 2t
data modify storage ward:animation rel_position.pos set from entity @n[tag=ward.animation.rel_position] Pos
assert predicate {type:"float_value_check",value:{type:sub,left:{type:storage,storage:"ward:animation",path:"rel_position.pos[0]"},right:{type:storage,storage:"ward:animation",path:"rel_position.anchor[0]"}},test:{min:14.0,max:18.0}}

# moved away mid-play: the next frame snaps back onto the anchored path
execute as @n[tag=ward.animation.rel_position] at @s run tp @s ~ ~64 ~
await delay 1t
data modify storage ward:animation rel_position.pos set from entity @n[tag=ward.animation.rel_position] Pos
assert predicate {type:"float_value_check",value:{type:sub,left:{type:storage,storage:"ward:animation",path:"rel_position.pos[0]"},right:{type:storage,storage:"ward:animation",path:"rel_position.anchor[0]"}},test:{min:22.0,max:26.0}}
assert predicate {type:"float_value_check",value:{type:sub,left:{type:storage,storage:"ward:animation",path:"rel_position.pos[1]"},right:{type:storage,storage:"ward:animation",path:"rel_position.anchor[1]"}},test:{min:-2.0,max:2.0}}

# rewind keeps the anchor: back on the origin, then keeps playing from there
data modify storage bs.animation:rewind in set value {id:"rel"}
assert run execute as @n[tag=ward.animation.rel_position] run function #bs.animation:rewind
assert data entity @n[tag=ward.animation.rel_position] data."bs.animation"[{id:"rel"}]._
data modify storage ward:animation rel_position.pos set from entity @n[tag=ward.animation.rel_position] Pos
assert predicate {type:"float_value_check",value:{type:sub,left:{type:storage,storage:"ward:animation",path:"rel_position.pos[0]"},right:{type:storage,storage:"ward:animation",path:"rel_position.anchor[0]"}},test:{min:-2.0,max:2.0}}
await delay 1t
data modify storage ward:animation rel_position.pos set from entity @n[tag=ward.animation.rel_position] Pos
assert predicate {type:"float_value_check",value:{type:sub,left:{type:storage,storage:"ward:animation",path:"rel_position.pos[0]"},right:{type:storage,storage:"ward:animation",path:"rel_position.anchor[0]"}},test:{min:6.0,max:10.0}}

# reset places the entity on the origin, then frees it
data modify storage bs.animation:reset in set value {id:"rel"}
assert run execute as @n[tag=ward.animation.rel_position] run function #bs.animation:reset
assert not data entity @n[tag=ward.animation.rel_position] data."bs.animation"[{id:"rel"}]._
data modify storage ward:animation rel_position.pos set from entity @n[tag=ward.animation.rel_position] Pos
assert predicate {type:"float_value_check",value:{type:sub,left:{type:storage,storage:"ward:animation",path:"rel_position.pos[0]"},right:{type:storage,storage:"ward:animation",path:"rel_position.anchor[0]"}},test:{min:-2.0,max:2.0}}
execute as @n[tag=ward.animation.rel_position] at @s run tp @s ~ ~64 ~
await delay 2t
data modify storage ward:animation rel_position.pos set from entity @n[tag=ward.animation.rel_position] Pos
assert predicate {type:"float_value_check",value:{type:sub,left:{type:storage,storage:"ward:animation",path:"rel_position.pos[1]"},right:{type:storage,storage:"ward:animation",path:"rel_position.anchor[1]"}},test:{min:62.0,max:66.0}}

# replay anchors at the new origin
data modify storage ward:animation rel_position.anchor set from entity @n[tag=ward.animation.rel_position] Pos
data modify storage bs.animation:play in set value {id:"rel"}
assert run execute as @n[tag=ward.animation.rel_position] run function #bs.animation:play
await delay 2t
data modify storage ward:animation rel_position.pos set from entity @n[tag=ward.animation.rel_position] Pos
assert predicate {type:"float_value_check",value:{type:sub,left:{type:storage,storage:"ward:animation",path:"rel_position.pos[0]"},right:{type:storage,storage:"ward:animation",path:"rel_position.anchor[0]"}},test:{min:14.0,max:18.0}}
assert predicate {type:"float_value_check",value:{type:sub,left:{type:storage,storage:"ward:animation",path:"rel_position.pos[1]"},right:{type:storage,storage:"ward:animation",path:"rel_position.anchor[1]"}},test:{min:-2.0,max:2.0}}

data remove storage ward:animation rel_position
kill @e[tag=ward.animation.rel_position]

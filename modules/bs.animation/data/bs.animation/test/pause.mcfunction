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

summon marker ~ ~ ~ {Tags:["ward.animation.pause"],Rotation:[0f,0f]}
data modify storage bs.animation:attach in set value {id:"pause",run:"function #bs.animation:apply/rotation",type:"linear",duration:4,points:[[0,0],[40,0]]}
execute as @n[tag=ward.animation.pause] run function #bs.animation:attach
data modify storage bs.animation:play in set value {id:"pause"}
execute as @n[tag=ward.animation.pause] run function #bs.animation:play

await delay 2t
data modify storage bs.animation:pause in set value {id:"pause"}
assert run execute as @n[tag=ward.animation.pause] run function #bs.animation:pause
assert not data entity @n[tag=ward.animation.pause] data."bs.animation"[{id:"pause"}].w
assert not run execute as @n[tag=ward.animation.pause] run function #bs.animation:pause
assert result 20 run data get entity @n[tag=ward.animation.pause] Rotation[0]

await delay 2t
assert result 20 run data get entity @n[tag=ward.animation.pause] Rotation[0]

data modify storage bs.animation:play in set value {id:"pause"}
execute as @n[tag=ward.animation.pause] run function #bs.animation:play
await delay 2t
assert result 40 run data get entity @n[tag=ward.animation.pause] Rotation[0]

kill @n[tag=ward.animation.pause]

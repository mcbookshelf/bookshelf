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

summon marker ~ ~ ~ {Tags:["ward.animation.rotation"],Rotation:[0f,0f]}

data modify storage bs.animation:attach in set value {id:"rotation",run:"function #bs.animation:apply/rotation",type:"linear",duration:1,points:[[0,0],[90,45]]}
execute as @n[tag=ward.animation.rotation] run function #bs.animation:attach

data modify storage bs.animation:step in set value {id:"rotation",step:1}
execute as @n[tag=ward.animation.rotation] run function #bs.animation:step

assert result 90 run data get entity @n[tag=ward.animation.rotation] Rotation[0]
assert result 45 run data get entity @n[tag=ward.animation.rotation] Rotation[1]

kill @n[tag=ward.animation.rotation]

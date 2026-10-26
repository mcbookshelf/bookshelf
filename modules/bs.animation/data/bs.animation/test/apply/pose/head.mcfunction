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

summon armor_stand ~ ~ ~ {Tags:["ward.animation.pose.head"],NoGravity:1b,Invisible:1b}

data modify storage bs.animation:attach in set value {id:"head",run:"function #bs.animation:apply/pose/head",type:"linear",duration:1,points:[[0,0,0],[10,20,30]]}
execute as @n[tag=ward.animation.pose.head] run function #bs.animation:attach

data modify storage bs.animation:step in set value {id:"head",step:1}
execute as @n[tag=ward.animation.pose.head] run function #bs.animation:step

assert result 10 run data get entity @n[tag=ward.animation.pose.head] Pose.Head[0]
assert result 20 run data get entity @n[tag=ward.animation.pose.head] Pose.Head[1]
assert result 30 run data get entity @n[tag=ward.animation.pose.head] Pose.Head[2]

kill @n[tag=ward.animation.pose.head]

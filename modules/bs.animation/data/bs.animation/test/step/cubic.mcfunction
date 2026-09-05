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

summon marker ~ ~ ~ {Tags:["bs.ward.animation.step.cubic"]}

# two animations under one id: the assert must live IN the callback,
# otherwise only the last animation's lambda survives to be checked
data modify storage bs:ward animation.step.cubic_many set value [{run:"assert score $animation.x bs.lambda matches 1500",basis:"bezier",duration:100,points:[[0d],[1d],[2d],[3d]]},{run:"assert score $animation.x bs.lambda matches 1625",basis:"bezier",duration:100,points:[[0d],[1d],[2d],[4d]]}]
execute as @n[tag=bs.ward.animation.step.cubic] run function #bs.animation:create {id:"many",uses:"bs:ward animation.step.cubic_many"}
execute as @n[tag=bs.ward.animation.step.cubic] run function #bs.animation:step {id:"many",with:{step:50}}

# with:{} must default to step 1  ->  t=1, lambda=10
data modify storage bs:ward animation.step.cubic_def set value {run:"assert score $animation.x bs.lambda matches 30",basis:"bezier",duration:100,points:[[0d],[1d],[2d],[3d]]}
execute as @n[tag=bs.ward.animation.step.cubic] run function #bs.animation:create {id:"def",uses:"bs:ward animation.step.cubic_def"}
execute as @n[tag=bs.ward.animation.step.cubic] run function #bs.animation:step {id:"def",with:{}}

# stepping twice must equal t=2  ->  lambda=20
data modify storage bs:ward animation.step.cubic_twice set value {run:"execute if score @s bs.ctx matches 0",basis:"bezier",duration:100,points:[[0d],[1d],[2d],[3d]]}
execute as @n[tag=bs.ward.animation.step.cubic] run function #bs.animation:create {id:"twice",uses:"bs:ward animation.step.cubic_twice"}
execute as @n[tag=bs.ward.animation.step.cubic] run function #bs.animation:step {id:"twice",with:{}}
execute as @n[tag=bs.ward.animation.step.cubic] run function #bs.animation:step {id:"twice",with:{}}
assert score $animation.x bs.lambda matches 60

# 2d / 3d: several outputs per evaluation, so dummy callback + check after
data modify storage bs:ward animation.step.cubic_2d set value {run:"execute if score @s bs.ctx matches 0",basis:"bezier",duration:100,points:[[0d,0d],[1d,2d],[2d,4d],[4d,8d]]}
execute as @n[tag=bs.ward.animation.step.cubic] run function #bs.animation:create {id:"twod",uses:"bs:ward animation.step.cubic_2d"}
execute as @n[tag=bs.ward.animation.step.cubic] run function #bs.animation:step {id:"twod",with:{step:50}}
assert score $animation.x bs.lambda matches 1625
assert score $animation.y bs.lambda matches 3250

data modify storage bs:ward animation.step.cubic_3d set value {run:"execute if score @s bs.ctx matches 0",basis:"bezier",duration:100,points:[[0d,0d,0d],[1d,2d,-1d],[2d,4d,-2d],[4d,8d,-4d]]}
execute as @n[tag=bs.ward.animation.step.cubic] run function #bs.animation:create {id:"threed",uses:"bs:ward animation.step.cubic_3d"}
execute as @n[tag=bs.ward.animation.step.cubic] run function #bs.animation:step {id:"threed",with:{step:50}}
assert score $animation.x bs.lambda matches 1625
assert score $animation.y bs.lambda matches 3250
assert score $animation.z bs.lambda matches -1625

# --- segment rollover -------------------------------------------------------
# 8 points duration 500 -> 5 segments of 100 ticks.
# seg0 at u=1 and seg1 at u=0 are both 3250 -> connected.
data modify storage bs:ward animation.step.roll_edge set value {run:"execute if score @s bs.ctx matches 0",basis:"catmull_rom",duration:500,points:[[0d],[2.5d],[3.25d],[-1.75d],[4d],[6.5d],[5.25d],[1d]]}
execute as @n[tag=bs.ward.animation.step.cubic] run function #bs.animation:create {id:"edge",uses:"bs:ward animation.step.roll_edge"}
execute as @n[tag=bs.ward.animation.step.cubic] run function #bs.animation:step {id:"edge",with:{step:100}}
assert score $animation.x bs.lambda matches 3250
execute as @n[tag=bs.ward.animation.step.cubic] run function #bs.animation:step {id:"edge",with:{step:150}}
assert score $animation.x bs.lambda matches 656

# crossing a boundary in ONE step: the remainder must carry over
data modify storage bs:ward animation.step.roll_jump set value {run:"execute if score @s bs.ctx matches 0",basis:"catmull_rom",duration:500,points:[[0d],[2.5d],[3.25d],[-1.75d],[4d],[6.5d],[5.25d],[1d]]}
execute as @n[tag=bs.ward.animation.step.cubic] run function #bs.animation:create {id:"jump",uses:"bs:ward animation.step.roll_jump"}
execute as @n[tag=bs.ward.animation.step.cubic] run function #bs.animation:step {id:"jump",with:{step:250}}
assert score $animation.x bs.lambda matches 656

# over-stepping past the end
data modify storage bs:ward animation.step.roll_over set value {run:"execute if score @s bs.ctx matches 0",basis:"catmull_rom",duration:500,points:[[0d],[2.5d],[3.25d],[-1.75d],[4d],[6.5d],[5.25d],[1d]]}
execute as @n[tag=bs.ward.animation.step.cubic] run function #bs.animation:create {id:"over",uses:"bs:ward animation.step.roll_over"}
execute as @n[tag=bs.ward.animation.step.cubic] run function #bs.animation:step {id:"over",with:{step:50}}
assert score $animation.x bs.lambda matches 3344
execute as @n[tag=bs.ward.animation.step.cubic] run function #bs.animation:step {id:"over",with:{step:9999}}
assert score $animation.x bs.lambda matches 5250

kill @n[tag=bs.ward.animation.step.cubic]

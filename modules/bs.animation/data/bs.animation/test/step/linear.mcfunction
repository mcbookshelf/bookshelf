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

summon marker ~ ~ ~ {Tags:["bs.ward.animation.step.linear"]}

# two animations under one id: assert inside each callback
data modify storage bs:ward animation.step.linear_many set value [{run:"assert score $animation.x bs.lambda matches 5000",basis:"linear",duration:100,points:[[0d],[10d]]},{run:"assert score $animation.x bs.lambda matches 2000",basis:"linear",duration:100,points:[[0d],[4d]]}]
execute as @n[tag=bs.ward.animation.step.linear] run function #bs.animation:create {id:"many",uses:"bs:ward animation.step.linear_many"}
execute as @n[tag=bs.ward.animation.step.linear] run function #bs.animation:step {id:"many",with:{step:50}}

# with:{} defaults to step 1  ->  lambda=10
data modify storage bs:ward animation.step.linear_def set value {run:"assert score $animation.x bs.lambda matches 100",basis:"linear",duration:100,points:[[0d],[10d]]}
execute as @n[tag=bs.ward.animation.step.linear] run function #bs.animation:create {id:"def",uses:"bs:ward animation.step.linear_def"}
execute as @n[tag=bs.ward.animation.step.linear] run function #bs.animation:step {id:"def",with:{}}

# two steps  ->  lambda=20
data modify storage bs:ward animation.step.linear_twice set value {run:"execute if score @s bs.ctx matches 0",basis:"linear",duration:100,points:[[0d],[10d]]}
execute as @n[tag=bs.ward.animation.step.linear] run function #bs.animation:create {id:"twice",uses:"bs:ward animation.step.linear_twice"}
execute as @n[tag=bs.ward.animation.step.linear] run function #bs.animation:step {id:"twice",with:{}}
execute as @n[tag=bs.ward.animation.step.linear] run function #bs.animation:step {id:"twice",with:{}}
assert score $animation.x bs.lambda matches 200

# 2d / 3d
data modify storage bs:ward animation.step.linear_2d set value {run:"execute if score @s bs.ctx matches 0",basis:"linear",duration:100,points:[[0d,0d],[10d,20d]]}
execute as @n[tag=bs.ward.animation.step.linear] run function #bs.animation:create {id:"twod",uses:"bs:ward animation.step.linear_2d"}
execute as @n[tag=bs.ward.animation.step.linear] run function #bs.animation:step {id:"twod",with:{step:50}}
assert score $animation.x bs.lambda matches 5000
assert score $animation.y bs.lambda matches 10000

data modify storage bs:ward animation.step.linear_3d set value {run:"execute if score @s bs.ctx matches 0",basis:"linear",duration:100,points:[[0d,0d,0d],[10d,20d,-5d]]}
execute as @n[tag=bs.ward.animation.step.linear] run function #bs.animation:create {id:"threed",uses:"bs:ward animation.step.linear_3d"}
execute as @n[tag=bs.ward.animation.step.linear] run function #bs.animation:step {id:"threed",with:{step:50}}
assert score $animation.x bs.lambda matches 5000
assert score $animation.y bs.lambda matches 10000
assert score $animation.z bs.lambda matches -2500

# --- segment rollover -------------------------------------------------------
# points [0,10,30] duration 200 -> 2 segments of 100 ticks.
# seg0 p=[0,10000] ends at 10000; seg1 p=[10000,20000] starts at 10000 -> connected.
data modify storage bs:ward animation.step.roll_edge set value {run:"execute if score @s bs.ctx matches 0",basis:"linear",duration:200,points:[[0d],[10d],[30d]]}
execute as @n[tag=bs.ward.animation.step.linear] run function #bs.animation:create {id:"edge",uses:"bs:ward animation.step.roll_edge"}
execute as @n[tag=bs.ward.animation.step.linear] run function #bs.animation:step {id:"edge",with:{step:50}}
assert score $animation.x bs.lambda matches 5000
execute as @n[tag=bs.ward.animation.step.linear] run function #bs.animation:step {id:"edge",with:{step:50}}
assert score $animation.x bs.lambda matches 10000
execute as @n[tag=bs.ward.animation.step.linear] run function #bs.animation:step {id:"edge",with:{step:50}}
assert score $animation.x bs.lambda matches 20000

# crossing a boundary in ONE step: the remainder must carry over
data modify storage bs:ward animation.step.roll_jump set value {run:"execute if score @s bs.ctx matches 0",basis:"linear",duration:200,points:[[0d],[10d],[30d]]}
execute as @n[tag=bs.ward.animation.step.linear] run function #bs.animation:create {id:"jump",uses:"bs:ward animation.step.roll_jump"}
execute as @n[tag=bs.ward.animation.step.linear] run function #bs.animation:step {id:"jump",with:{step:150}}
assert score $animation.x bs.lambda matches 20000

# over-stepping past the end
data modify storage bs:ward animation.step.roll_over set value {run:"execute if score @s bs.ctx matches 0",basis:"linear",duration:200,points:[[0d],[10d],[30d]]}
execute as @n[tag=bs.ward.animation.step.linear] run function #bs.animation:create {id:"over",uses:"bs:ward animation.step.roll_over"}
execute as @n[tag=bs.ward.animation.step.linear] run function #bs.animation:step {id:"over",with:{step:50}}
assert score $animation.x bs.lambda matches 5000
execute as @n[tag=bs.ward.animation.step.linear] run function #bs.animation:step {id:"over",with:{step:9999}}
assert score $animation.x bs.lambda matches 30000

kill @n[tag=bs.ward.animation.step.linear]

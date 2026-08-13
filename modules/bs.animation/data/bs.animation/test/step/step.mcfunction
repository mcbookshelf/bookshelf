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

summon marker ~ ~ ~ {Tags:["bs.ward.animation.step.step"]}

# step evaluates to p[0] regardless of lambda, so these asserts hold
# whatever the t/d scaling turns out to be -- useful as a control:
# if cubic/linear fail but these pass, lambda is the problem, not dispatch
data modify storage bs:ward animation.step.step_many set value [{run:"assert score $animation.x bs.lambda matches 2500",basis:"step",duration:200,points:[[2.5d],[5d]]},{run:"assert score $animation.x bs.lambda matches 1000",basis:"step",duration:200,points:[[1d],[2d]]}]
execute as @n[tag=bs.ward.animation.step.step] run function #bs.animation:create {id:"many",uses:"bs:ward animation.step.step_many"}
execute as @n[tag=bs.ward.animation.step.step] run function #bs.animation:step {id:"many",with:{step:50}}

# with:{} defaults to step 1
data modify storage bs:ward animation.step.step_def set value {run:"assert score $animation.x bs.lambda matches 2500",basis:"step",duration:200,points:[[2.5d],[5d]]}
execute as @n[tag=bs.ward.animation.step.step] run function #bs.animation:create {id:"def",uses:"bs:ward animation.step.step_def"}
execute as @n[tag=bs.ward.animation.step.step] run function #bs.animation:step {id:"def",with:{}}

# two steps, still inside segment 0 (duration 200 -> 100 per segment)
data modify storage bs:ward animation.step.step_twice set value {run:"execute if score @s bs.ctx matches 0",basis:"step",duration:200,points:[[2.5d],[5d]]}
execute as @n[tag=bs.ward.animation.step.step] run function #bs.animation:create {id:"twice",uses:"bs:ward animation.step.step_twice"}
execute as @n[tag=bs.ward.animation.step.step] run function #bs.animation:step {id:"twice",with:{}}
execute as @n[tag=bs.ward.animation.step.step] run function #bs.animation:step {id:"twice",with:{}}
assert score $animation.x bs.lambda matches 2500

# 2d / 3d
data modify storage bs:ward animation.step.step_2d set value {run:"execute if score @s bs.ctx matches 0",basis:"step",duration:200,points:[[2.5d,5d],[5d,10d]]}
execute as @n[tag=bs.ward.animation.step.step] run function #bs.animation:create {id:"twod",uses:"bs:ward animation.step.step_2d"}
execute as @n[tag=bs.ward.animation.step.step] run function #bs.animation:step {id:"twod",with:{step:50}}
assert score $animation.x bs.lambda matches 2500
assert score $animation.y bs.lambda matches 5000

data modify storage bs:ward animation.step.step_3d set value {run:"execute if score @s bs.ctx matches 0",basis:"step",duration:200,points:[[2.5d,5d,-1.5d],[5d,10d,-3d]]}
execute as @n[tag=bs.ward.animation.step.step] run function #bs.animation:create {id:"threed",uses:"bs:ward animation.step.step_3d"}
execute as @n[tag=bs.ward.animation.step.step] run function #bs.animation:step {id:"threed",with:{step:50}}
assert score $animation.x bs.lambda matches 2500
assert score $animation.y bs.lambda matches 5000
assert score $animation.z bs.lambda matches -1500

# --- segment rollover -------------------------------------------------------
# points [2.5,5,7.5] duration 300 -> 3 segments of 100 ticks.
# step segments are NOT connected: each is constant, so a rollover is a
# deliberate jump 2500 -> 5000 -> 7500.
data modify storage bs:ward animation.step.roll_edge set value {run:"execute if score @s bs.ctx matches 0",basis:"step",duration:300,points:[[2.5d],[5d],[7.5d]]}
execute as @n[tag=bs.ward.animation.step.step] run function #bs.animation:create {id:"edge",uses:"bs:ward animation.step.roll_edge"}
execute as @n[tag=bs.ward.animation.step.step] run function #bs.animation:step {id:"edge",with:{step:50}}
assert score $animation.x bs.lambda matches 2500
execute as @n[tag=bs.ward.animation.step.step] run function #bs.animation:step {id:"edge",with:{step:50}}
assert score $animation.x bs.lambda matches 5000
execute as @n[tag=bs.ward.animation.step.step] run function #bs.animation:step {id:"edge",with:{step:150}}
assert score $animation.x bs.lambda matches 7500

# crossing a boundary in ONE step: the remainder must carry over
data modify storage bs:ward animation.step.roll_jump set value {run:"execute if score @s bs.ctx matches 0",basis:"step",duration:300,points:[[2.5d],[5d],[7.5d]]}
execute as @n[tag=bs.ward.animation.step.step] run function #bs.animation:create {id:"jump",uses:"bs:ward animation.step.roll_jump"}
execute as @n[tag=bs.ward.animation.step.step] run function #bs.animation:step {id:"jump",with:{step:150}}
assert score $animation.x bs.lambda matches 5000

# over-stepping past the end
data modify storage bs:ward animation.step.roll_over set value {run:"execute if score @s bs.ctx matches 0",basis:"step",duration:300,points:[[2.5d],[5d],[7.5d]]}
execute as @n[tag=bs.ward.animation.step.step] run function #bs.animation:create {id:"over",uses:"bs:ward animation.step.roll_over"}
execute as @n[tag=bs.ward.animation.step.step] run function #bs.animation:step {id:"over",with:{step:50}}
assert score $animation.x bs.lambda matches 2500
execute as @n[tag=bs.ward.animation.step.step] run function #bs.animation:step {id:"over",with:{step:9999}}
assert score $animation.x bs.lambda matches 7500

kill @n[tag=bs.ward.animation.step.step]

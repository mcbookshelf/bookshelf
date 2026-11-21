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

execute store result score #generation.skip bs.data run compute default integer bs.generation:_on_ellipse_outline/skip
execute store result score #generation.length bs.data run compute default integer bs.generation:_on_ellipse_outline/length
scoreboard players operation #generation.end bs.data = #generation.skip bs.data
scoreboard players operation #generation.end bs.data += #generation.length bs.data
execute if score #generation.part bs.data matches 1 run scoreboard players operation #generation.end bs.data = #generation.ni bs.data
execute if score #generation.part bs.data matches 1 run scoreboard players operation #generation.end bs.data -= #generation.skip bs.data
execute store result storage bs.generation: tasks[0].rewind_i int 1 run compute default integer {type:"sub",left:{type:"score",score:"bs.data",target:{type:"fixed",name:"#generation.end"}},right:{type:"score",score:"bs.data",target:{type:"fixed",name:"#generation.i"}}}
execute store result storage bs.generation: tasks[0].jump_far int 1 run compute default integer {type:"max",inputs:[{type:"sub",left:{type:"sub",left:{type:"sub",left:{type:"add",inputs:[{type:"score",score:"bs.data",target:{type:"fixed",name:"#generation.ni"}},{type:"score",score:"bs.data",target:{type:"fixed",name:"#generation.i"}}]},right:{type:"score",score:"bs.data",target:{type:"fixed",name:"#generation.end"}}},right:{type:"score",score:"bs.data",target:{type:"fixed",name:"#generation.skip"}}},right:{type:"score",score:"bs.data",target:{type:"fixed",name:"#generation.length"}}},0]}
function bs.generation:on_ellipse_outline/step
execute if score #generation.paused bs.data matches 1 run return fail
function bs.generation:on_ellipse_outline/rewind with storage bs.generation: tasks[0]

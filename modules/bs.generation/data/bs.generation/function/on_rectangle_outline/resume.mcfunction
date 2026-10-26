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

execute store result storage bs.generation: tasks[0].rewind_i int 1 run compute default integer {type:"sub",left:{type:"score",score:"bs.data",target:{type:"fixed",name:"#generation.ni"}},right:{type:"score",score:"bs.data",target:{type:"fixed",name:"#generation.i"}}}
execute store result storage bs.generation: tasks[0].rewind_j int 1 run compute default integer {type:"sub",left:{type:"score",score:"bs.data",target:{type:"fixed",name:"#generation.nj"}},right:{type:"score",score:"bs.data",target:{type:"fixed",name:"#generation.j"}}}
execute if score #generation.part bs.data matches 2..3 run function bs.generation:on_rectangle_outline/step_j
execute unless score #generation.part bs.data matches 2..3 run function bs.generation:on_rectangle_outline/step_i
execute if score #generation.paused bs.data matches 1 run return fail
function bs.generation:on_rectangle_outline/rewind with storage bs.generation: tasks[0]

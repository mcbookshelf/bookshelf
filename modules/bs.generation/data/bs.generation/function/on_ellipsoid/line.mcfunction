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

execute store result score #generation.end bs.data store result score #generation.i bs.data run compute default integer bs.generation:_on_ellipsoid/end
scoreboard players operation #generation.i bs.data += #generation.end bs.data
scoreboard players operation #generation.i bs.data -= #generation.ni bs.data
execute if score #generation.i bs.data matches ..0 run return run function bs.generation:on_ellipsoid/next with storage bs.generation: tasks[0]
execute store result storage bs.generation: tasks[0].jump int 1 run compute default integer {type:"sub",left:{type:"score",score:"bs.data",target:{type:"fixed",name:"#generation.ni"}},right:{type:"score",score:"bs.data",target:{type:"fixed",name:"#generation.end"}}}
function bs.generation:on_ellipsoid/jump with storage bs.generation: tasks[0]
execute if score #generation.paused bs.data matches 1 run return fail
scoreboard players remove #generation.j bs.data 1
scoreboard players remove #generation.mid_j bs.data 2
$execute if score #generation.j bs.data matches 1.. positioned $(to_next_line) run return run function bs.generation:on_ellipsoid/line with storage bs.generation: tasks[0]
scoreboard players operation #generation.j bs.data = #generation.nj bs.data
scoreboard players operation #generation.mid_j bs.data = #generation.last_j bs.data
scoreboard players remove #generation.k bs.data 1
scoreboard players remove #generation.mid_k bs.data 2
$execute if score #generation.k bs.data matches 1.. positioned $(to_next_slice) run return run function bs.generation:on_ellipsoid/line with storage bs.generation: tasks[0]

execute if data storage bs.generation: tasks[0].on_finished run function bs.generation:utils/finish with storage bs.generation: tasks[0]

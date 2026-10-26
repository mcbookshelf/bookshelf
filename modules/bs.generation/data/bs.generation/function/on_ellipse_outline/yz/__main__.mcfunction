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

data modify storage bs.generation: task set value {batch:256,jump_far:0,load:"bs.generation:on_ellipse_outline/load",step:"bs.generation:on_ellipse_outline/line",resume:"bs.generation:on_ellipse_outline/resume",i_pre:"~ ~",i_post:" ~",i_back:"~ ~-",j_pre:"~ ~ ~",j_post:"",j_back:"~ ~ ~-"}
data modify storage bs.generation: task merge from storage bs.generation:on_ellipse_outline in
data modify storage bs.generation: task.batch set compute default integer {type:"max",inputs:[{type:"storage",storage:"bs.generation:",path:"task.batch"},1]}
execute store result score #generation.t bs.data run data get storage bs.generation: task.size[0]
execute if score #generation.t bs.data matches ..-1 run data modify storage bs.generation: task merge value {i_pre:"~ ~-",i_back:"~ ~"}
execute store result storage bs.generation: task.ni int 1 store result storage bs.generation: task.left_i int 1 run compute default integer {type:"max",inputs:[{type:"abs",input:{type:"storage",storage:"bs.generation:",path:"task.size[0]",fallback:1}},1]}
execute store result score #generation.t bs.data run data get storage bs.generation: task.size[1]
execute if score #generation.t bs.data matches ..-1 run data modify storage bs.generation: task merge value {j_pre:"~ ~ ~-",j_back:"~ ~ ~"}
execute store result storage bs.generation: task.nj int 1 store result storage bs.generation: task.left_j int 1 run compute default integer {type:"max",inputs:[{type:"abs",input:{type:"storage",storage:"bs.generation:",path:"task.size[1]",fallback:1}},1]}
execute store result storage bs.generation: task.last_i int 1 run compute default integer {type:"sub",left:{type:"storage",storage:"bs.generation:",path:"task.ni"},right:1}
function bs.generation:on_ellipse_outline/setup with storage bs.generation: task
execute store result score #generation.now bs.data run time query gametime
execute if score #generation.now bs.data = #generation.tick bs.data if data storage bs.generation: tasks[0] align xyz run return run function bs.generation:runner/defer

scoreboard players operation #generation.tick bs.data = #generation.now bs.data
data remove storage bs.generation: tasks
data modify storage bs.generation: tasks append from storage bs.generation: task
function bs.generation:on_ellipse_outline/load
execute align xyz run function bs.generation:on_ellipse_outline/line with storage bs.generation: tasks[0]
data remove storage bs.generation: tasks[0]

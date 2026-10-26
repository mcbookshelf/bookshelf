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

scoreboard players set #generation.paused bs.data 1
execute store result storage bs.generation: tasks[0].left_i int 1 run scoreboard players get #generation.i bs.data
execute store result storage bs.generation: tasks[0].left_j int 1 run scoreboard players get #generation.j bs.data
execute store result storage bs.generation: tasks[0].part int 1 run scoreboard players get #generation.part bs.data
data modify storage bs.generation: task set from storage bs.generation: tasks[0]
execute unless data storage bs.generation: task.dim run function bs.generation:utils/dimension
execute in minecraft:overworld as B5-0-0-0-1 run function bs.generation:utils/position
data modify storage bs.generation: queue append from storage bs.generation: task
schedule function bs.generation:runner/tick 1t replace

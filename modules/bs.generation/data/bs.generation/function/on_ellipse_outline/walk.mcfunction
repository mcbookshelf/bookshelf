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

scoreboard players operation #generation.t bs.data = #generation.skip bs.data
scoreboard players operation #generation.t bs.data += #generation.length bs.data
execute if score #generation.length bs.data matches 2..4 if score #generation.t bs.data < #generation.skip_empty bs.data if score #generation.batch bs.data matches 8.. run return run function bs.generation:on_ellipse_outline/short_runs with storage bs.generation: tasks[0]
scoreboard players operation #generation.end bs.data = #generation.ni bs.data
scoreboard players operation #generation.end bs.data -= #generation.skip bs.data
scoreboard players operation #generation.i bs.data = #generation.end bs.data
scoreboard players operation #generation.i bs.data -= #generation.skip bs.data
scoreboard players set #generation.part bs.data 1
execute store result storage bs.generation: tasks[0].jump int 1 run scoreboard players get #generation.skip bs.data
scoreboard players operation #generation.t bs.data = #generation.i bs.data
scoreboard players operation #generation.t bs.data -= #generation.length bs.data
scoreboard players operation #generation.t bs.data -= #generation.length bs.data
execute if score #generation.t bs.data matches 1.. run function bs.generation:on_ellipse_outline/split
function bs.generation:on_ellipse_outline/jump with storage bs.generation: tasks[0]
execute if score #generation.paused bs.data matches 1 run return fail
scoreboard players remove #generation.j bs.data 1
scoreboard players remove #generation.mid_j bs.data 2
$execute if score #generation.j bs.data matches 1.. positioned $(to_next_line) run return run function bs.generation:on_ellipse_outline/line with storage bs.generation: tasks[0]

execute if data storage bs.generation: tasks[0].on_finished run function bs.generation:utils/finish with storage bs.generation: tasks[0]

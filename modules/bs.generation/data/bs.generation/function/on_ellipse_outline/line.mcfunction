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
execute if score #generation.skip bs.data >= #generation.skip_empty bs.data run return run function bs.generation:on_ellipse_outline/next with storage bs.generation: tasks[0]
execute store result score #generation.length bs.data run compute default integer bs.generation:_on_ellipse_outline/length
execute unless score #generation.length bs.data matches 1 run return run function bs.generation:on_ellipse_outline/walk with storage bs.generation: tasks[0]
execute if score #generation.skip bs.data > #generation.skip_pair bs.data run return run function bs.generation:on_ellipse_outline/walk with storage bs.generation: tasks[0]
execute if score #generation.batch bs.data matches ..1 run return run function bs.generation:on_ellipse_outline/walk with storage bs.generation: tasks[0]

execute store result storage bs.generation: tasks[0].jump int 1 run scoreboard players get #generation.skip bs.data
scoreboard players operation #generation.end bs.data = #generation.skip bs.data
scoreboard players set #generation.i bs.data 0
function bs.generation:on_ellipse_outline/ends/1 with storage bs.generation: tasks[0]
scoreboard players remove #generation.batch bs.data 2
scoreboard players remove #generation.j bs.data 1
scoreboard players remove #generation.mid_j bs.data 2
$execute positioned $(to_next_line) run return run function bs.generation:on_ellipse_outline/line with storage bs.generation: tasks[0]

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

execute if score #generation.part bs.data matches 1 run function bs.generation:on_rectangle_outline/edge/1
execute if score #generation.paused bs.data matches 1 run return fail
$execute if score #generation.part bs.data matches ..2 positioned $(j_pre)1$(j_post) run function bs.generation:on_rectangle_outline/edge/2
execute if score #generation.paused bs.data matches 1 run return fail
$execute if score #generation.part bs.data matches ..3 unless score #generation.ni bs.data matches 1 positioned $(to_edge_3) run function bs.generation:on_rectangle_outline/edge/3
execute if score #generation.paused bs.data matches 1 run return fail
$execute if score #generation.part bs.data matches ..4 unless score #generation.nj bs.data matches 1 positioned $(to_edge_4) run function bs.generation:on_rectangle_outline/edge/4
execute if score #generation.paused bs.data matches 1 run return fail

execute if data storage bs.generation: tasks[0].on_finished run function bs.generation:utils/finish with storage bs.generation: tasks[0]

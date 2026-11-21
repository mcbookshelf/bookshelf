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

scoreboard players operation #generation.i bs.data = #generation.ni bs.data
scoreboard players remove #generation.j bs.data 1
$execute if score #generation.j bs.data matches 1.. if score #generation.batch bs.data >= #generation.ni bs.data positioned $(to_next_line) run return run function $(line) with storage bs.generation: tasks[0]
$execute if score #generation.j bs.data matches 1.. positioned $(to_next_line) run return run function bs.generation:on_rectangle/step

execute if data storage bs.generation: tasks[0].on_finished run function bs.generation:utils/finish with storage bs.generation: tasks[0]

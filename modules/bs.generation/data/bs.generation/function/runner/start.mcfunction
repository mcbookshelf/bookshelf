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

data modify storage bs.generation: tasks append from storage bs.generation: pending[0]
data remove storage bs.generation: pending[0]
scoreboard players remove #generation.pending bs.data 1
$function $(load)
$execute in minecraft:overworld positioned $(x) $(y) $(z) in $(dim) run function $(step) with storage bs.generation: tasks[0]
data remove storage bs.generation: tasks[0]
execute if score #generation.pending bs.data matches 1.. run function bs.generation:runner/start with storage bs.generation: pending[0]

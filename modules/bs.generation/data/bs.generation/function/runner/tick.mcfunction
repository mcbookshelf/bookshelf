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

execute store result score #generation.tick bs.data run time query gametime
scoreboard players set #generation.pending bs.data 0
execute store result score #generation.pending bs.data run data get storage bs.generation: pending
data remove storage bs.generation: tasks
data modify storage bs.generation: tasks set from storage bs.generation: queue
data remove storage bs.generation: queue
execute if data storage bs.generation: tasks[0] run function bs.generation:runner/resume with storage bs.generation: tasks[0]
execute if score #generation.pending bs.data matches 1.. run function bs.generation:runner/start with storage bs.generation: pending[0]

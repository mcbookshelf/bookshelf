# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2024 Gunivers
#
# This file is part of the Bookshelf project (https://github.com/mcbookshelf/Bookshelf).
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

execute store success score #s bs.ctx run scoreboard players remove @e[scores={bs.ttl=1..}] bs.ttl 1
execute if score #s bs.ctx matches 1 as @e[scores={bs.ttl=0}] run function bs.health:time_to_live/time_out with entity @s
execute if score #s bs.ctx matches 1 run schedule function bs.health:time_to_live/next_tick 1t

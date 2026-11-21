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

execute store result score #generation.ni bs.data run data get storage bs.generation: tasks[0].ni
execute store result score #generation.nj bs.data run data get storage bs.generation: tasks[0].nj
execute store result score #generation.nk bs.data run data get storage bs.generation: tasks[0].nk
execute store result score #generation.i bs.data run data get storage bs.generation: tasks[0].left_i
execute store result score #generation.j bs.data run data get storage bs.generation: tasks[0].left_j
execute store result score #generation.k bs.data run data get storage bs.generation: tasks[0].left_k
execute store result score #generation.batch bs.data run data get storage bs.generation: tasks[0].batch
execute store result score #generation.part bs.data run data get storage bs.generation: tasks[0].part
scoreboard players operation #generation.last_i bs.data = #generation.ni bs.data
scoreboard players remove #generation.last_i bs.data 1
execute store result score #generation.skip_pair bs.data run data get storage bs.generation: tasks[0].ni 0.5
scoreboard players operation #generation.skip_empty bs.data = #generation.ni bs.data
scoreboard players operation #generation.skip_empty bs.data -= #generation.skip_pair bs.data
scoreboard players operation #generation.skip_pair bs.data = #generation.skip_empty bs.data
scoreboard players remove #generation.skip_pair bs.data 2
scoreboard players set #generation.paused bs.data 0
scoreboard players operation #generation.mid_j bs.data = #generation.j bs.data
scoreboard players operation #generation.mid_j bs.data += #generation.j bs.data
scoreboard players operation #generation.mid_j bs.data -= #generation.nj bs.data
scoreboard players remove #generation.mid_j bs.data 1
scoreboard players operation #generation.mid_k bs.data = #generation.k bs.data
scoreboard players operation #generation.mid_k bs.data += #generation.k bs.data
scoreboard players operation #generation.mid_k bs.data -= #generation.nk bs.data
scoreboard players remove #generation.mid_k bs.data 1
scoreboard players operation #generation.last_j bs.data = #generation.nj bs.data
scoreboard players remove #generation.last_j bs.data 1

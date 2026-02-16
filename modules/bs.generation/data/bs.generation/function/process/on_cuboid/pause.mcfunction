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

execute store result storage bs:data generation[-1].i int 1 run scoreboard players get $generation.i bs.lambda
execute store result storage bs:data generation[-1].j int 1 run scoreboard players get $generation.j bs.lambda
execute store result storage bs:data generation[-1].k int 1 run scoreboard players get $generation.k bs.lambda

execute unless data storage bs:data generation[-1].dim run function bs.generation:utils/get_dimension
execute in minecraft:overworld as B5-0-0-0-1 run function bs.generation:utils/get_position

data modify storage bs:data generation prepend from storage bs:data generation[-1]
schedule function bs.generation:process/tick 1t replace

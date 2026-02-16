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

execute if score #generation.i bs.data matches 0 run return run function bs.generation:process/on_cuboid/pause
$$(run)
scoreboard players remove #generation.i bs.data 1

scoreboard players add $generation.i bs.lambda 1
$execute if score $generation.i bs.lambda < #generation.w bs.data positioned ~$(x) ~ ~ run return run function bs.generation:on_cuboid/recurse/xzy with storage bs:data generation[-1]
scoreboard players set $generation.i bs.lambda 0
scoreboard players add $generation.j bs.lambda 1
$execute if score $generation.j bs.lambda < #generation.d bs.data positioned $(sx) ~ ~$(z) run return run function bs.generation:on_cuboid/recurse/xzy with storage bs:data generation[-1]
scoreboard players set $generation.j bs.lambda 0
scoreboard players add $generation.k bs.lambda 1
$execute if score $generation.k bs.lambda < #generation.h bs.data positioned $(sx) ~$(y) $(sz) run return run function bs.generation:on_cuboid/recurse/xzy with storage bs:data generation[-1]

execute if data storage bs:data generation[-1].onf run function bs.generation:utils/on_finished with storage bs:data generation[-1]

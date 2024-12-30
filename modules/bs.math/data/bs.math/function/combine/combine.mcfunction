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

# Note: the larger bs.in must be smaller than 46342

# keep n, k > 0 & n <= k
execute store result score #n bs.ctx run scoreboard players set #k bs.ctx 0
execute if score $math.combine.n bs.in matches 0.. run scoreboard players operation #n bs.ctx = $math.combine.n bs.in
execute if score $math.combine.k bs.in matches 0.. run scoreboard players operation #k bs.ctx = $math.combine.k bs.in
execute if score #n bs.ctx > #k bs.ctx run scoreboard players operation #n bs.ctx >< #k bs.ctx

# get smaller n
scoreboard players operation #t bs.ctx = #k bs.ctx
scoreboard players operation #t bs.ctx -= #n bs.ctx
scoreboard players operation #n bs.ctx < #t bs.ctx

# break if n is special
execute if score #n bs.ctx matches 0 run return run scoreboard players set $math.combine bs.out 1
execute if score #n bs.ctx matches 1 run return run scoreboard players operation $math.combine bs.out = #k bs.ctx
execute if score #n bs.ctx matches 2.. run return run function bs.math:combine/recurse/init

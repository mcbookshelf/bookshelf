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

# Note: Warning, this function does not work properly if the input is greater than 12 (because the result is greater than 2^31, the limit value of scoreboards)

execute if score $math.factorial.n bs.in matches 0 run return run scoreboard players set $math.factorial bs.out 1
execute if score $math.factorial.n bs.in matches 1 run return run scoreboard players set $math.factorial bs.out 1
execute if score $math.factorial.n bs.in matches 2 run return run scoreboard players set $math.factorial bs.out 2
execute if score $math.factorial.n bs.in matches 3 run return run scoreboard players set $math.factorial bs.out 6
execute if score $math.factorial.n bs.in matches 4 run return run scoreboard players set $math.factorial bs.out 24
execute if score $math.factorial.n bs.in matches 5 run return run scoreboard players set $math.factorial bs.out 120
execute if score $math.factorial.n bs.in matches 6 run return run scoreboard players set $math.factorial bs.out 720
execute if score $math.factorial.n bs.in matches 7 run return run scoreboard players set $math.factorial bs.out 5040
execute if score $math.factorial.n bs.in matches 8 run return run scoreboard players set $math.factorial bs.out 40320
execute if score $math.factorial.n bs.in matches 9 run return run scoreboard players set $math.factorial bs.out 362880
execute if score $math.factorial.n bs.in matches 10 run return run scoreboard players set $math.factorial bs.out 3628800
execute if score $math.factorial.n bs.in matches 11 run return run scoreboard players set $math.factorial bs.out 39916800
execute if score $math.factorial.n bs.in matches 12 run return run scoreboard players set $math.factorial bs.out 479001600

execute store result score #i bs.ctx run scoreboard players operation $math.factorial bs.out = $math.factorial.n bs.in
function bs.math:factorial/loop
return run scoreboard players get $math.factorial bs.out

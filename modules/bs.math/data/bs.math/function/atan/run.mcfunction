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

execute store result entity @s Pos[0] double 0.001 run scoreboard players get $math.atan.x bs.in
data modify entity @s Pos[2] set value 1.0
execute positioned 0.0 0.0 0.0 facing entity @s feet rotated ~ 0.0 run tp @s -30000000 0 1600 ~ ~
execute store result score $math.atan bs.out run data get entity @s Rotation[0] -100
execute if score $math.atan bs.out matches ..-18000 run scoreboard players add $math.atan bs.out 36000
execute if score $math.atan bs.out matches 18001.. run scoreboard players remove $math.atan bs.out 36000
return run scoreboard players get $math.atan bs.out

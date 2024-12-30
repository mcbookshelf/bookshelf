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

execute store result entity @s Pos[0] double 0.00000001 run scoreboard players get $vector.normalize.0 bs.in
execute store result entity @s Pos[1] double 0.00000001 run scoreboard players get $vector.normalize.1 bs.in
execute store result entity @s Pos[2] double 0.00000001 run scoreboard players get $vector.normalize.2 bs.in
execute positioned 0.0 0.0 0.0 facing entity @s feet run tp @s ^ ^ ^1
data modify storage bs:ctx _ set from entity @s Pos
tp @s -30000000 0 1600 ~ ~

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

$execute store result entity @s Rotation[0] float $(y) run scoreboard players get $vector.basis_rot_3d.rot.0 bs.in
execute at @s positioned 0.0 0.0 0.0 rotated ~ 0.0 run tp @s ^ ^ ^10.0
execute store result score #i bs.ctx run data get entity @s Pos[2] 100
execute store result score #j bs.ctx run data get entity @s Pos[0] -100
$execute store result entity @s Rotation[0] float $(y) run scoreboard players get $vector.basis_rot_3d.rot.1 bs.in
execute at @s positioned 0.0 0.0 0.0 rotated ~ 0.0 run tp @s ^ ^ ^10.0
execute store result score #k bs.ctx run data get entity @s Pos[2] 100
execute store result score #l bs.ctx run data get entity @s Pos[0] -100
tp @s -30000000 0 1600

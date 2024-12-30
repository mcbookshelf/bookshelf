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

$scoreboard players set #s bs.ctx $(scaling)
scoreboard players set #t bs.ctx 1000000000
execute store result storage bs:ctx y double .000000001 run scoreboard players operation #t bs.ctx /= #s bs.ctx

# sincos(h: Phi) & sincos(v: Theta)
execute in minecraft:overworld as B5-0-0-0-1 run function bs.vector:convert/basis_rot_3d/sincos with storage bs:ctx

# X' = Z * sin(h) + X * cos(h)
scoreboard players operation $vector.basis_rot_3d.0 bs.out = $vector.basis_rot_3d.pos.2 bs.in
scoreboard players operation $vector.basis_rot_3d.0 bs.out *= #j bs.ctx
scoreboard players operation #t bs.ctx = $vector.basis_rot_3d.pos.0 bs.in
scoreboard players operation #t bs.ctx *= #i bs.ctx
scoreboard players operation $vector.basis_rot_3d.0 bs.out += #t bs.ctx
scoreboard players operation $vector.basis_rot_3d.0 bs.out /= 1000 bs.const

# Y' = (z * cos(h) - x * sin(h)) * sin(v) + y * cos(v)
scoreboard players operation $vector.basis_rot_3d.1 bs.out = $vector.basis_rot_3d.pos.2 bs.in
scoreboard players operation $vector.basis_rot_3d.1 bs.out *= #i bs.ctx
scoreboard players operation #t bs.ctx = $vector.basis_rot_3d.pos.0 bs.in
scoreboard players operation #t bs.ctx *= #j bs.ctx
scoreboard players operation $vector.basis_rot_3d.1 bs.out -= #t bs.ctx
execute store result score $vector.basis_rot_3d.2 bs.out run scoreboard players operation $vector.basis_rot_3d.1 bs.out /= 1000 bs.const
scoreboard players operation $vector.basis_rot_3d.1 bs.out *= #l bs.ctx
scoreboard players operation #t bs.ctx = $vector.basis_rot_3d.pos.1 bs.in
scoreboard players operation #t bs.ctx *= #k bs.ctx
scoreboard players operation $vector.basis_rot_3d.1 bs.out += #t bs.ctx
scoreboard players operation $vector.basis_rot_3d.1 bs.out /= 1000 bs.const

# Z' = (z * cos(h) - x * sin(h)) * cos(v) - y * sin(v)
scoreboard players operation $vector.basis_rot_3d.2 bs.out *= #k bs.ctx
scoreboard players operation #t bs.ctx = $vector.basis_rot_3d.pos.1 bs.in
scoreboard players operation #t bs.ctx *= #l bs.ctx
scoreboard players operation $vector.basis_rot_3d.2 bs.out -= #t bs.ctx
scoreboard players operation $vector.basis_rot_3d.2 bs.out /= 1000 bs.const

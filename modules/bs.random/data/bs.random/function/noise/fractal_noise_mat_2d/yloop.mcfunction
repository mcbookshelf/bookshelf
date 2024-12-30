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

execute store result score $random.fractal_noise_2d.x bs.in run scoreboard players set #x bs.ctx 0
data modify storage bs:out random.fractal_noise_mat_2d append value []
function bs.random:noise/fractal_noise_mat_2d/xloop with storage bs:ctx _

execute store result score $random.fractal_noise_2d.y bs.in run scoreboard players add #y bs.ctx 1
scoreboard players operation $random.fractal_noise_2d.y bs.in *= #k bs.ctx
execute if score #y bs.ctx < #h bs.ctx run function bs.random:noise/fractal_noise_mat_2d/yloop

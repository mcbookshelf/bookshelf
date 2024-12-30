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

scoreboard players set #m bs.ctx 0
scoreboard players set #a bs.ctx 1000
scoreboard players set #f bs.ctx 1000
scoreboard players set $random.fractal_noise_2d bs.out 0

scoreboard players operation #o bs.ctx = $random.fractal_noise_2d.octaves bs.in
scoreboard players operation $random.simplex_noise_2d.seed bs.in = $random.fractal_noise_2d.seed bs.in

execute if score #o bs.ctx matches 1.. run function bs.random:noise/fractal_noise_2d/loop
return run scoreboard players operation $random.fractal_noise_2d bs.out /= #m bs.ctx

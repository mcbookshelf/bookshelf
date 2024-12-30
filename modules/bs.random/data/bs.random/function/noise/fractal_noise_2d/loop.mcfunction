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

# Generate noise at the current frequency
scoreboard players operation $random.simplex_noise_2d.x bs.in = $random.fractal_noise_2d.x bs.in
scoreboard players operation $random.simplex_noise_2d.y bs.in = $random.fractal_noise_2d.y bs.in
scoreboard players operation $random.simplex_noise_2d.x bs.in *= #f bs.ctx
scoreboard players operation $random.simplex_noise_2d.y bs.in *= #f bs.ctx
scoreboard players operation $random.simplex_noise_2d.x bs.in /= 1000 bs.const
scoreboard players operation $random.simplex_noise_2d.y bs.in /= 1000 bs.const
function bs.random:noise/simplex_noise_2d/simplex_noise_2d

scoreboard players operation $random.simplex_noise_2d bs.out *= #a bs.ctx
scoreboard players operation $random.fractal_noise_2d bs.out += $random.simplex_noise_2d bs.out

# Update maximum possible amplitude for normalization
scoreboard players operation #m bs.ctx += #a bs.ctx

# Update amplitude and frequency for the next octave
scoreboard players operation #a bs.ctx *= $random.fractal_noise_2d.persistence bs.in
scoreboard players operation #a bs.ctx /= 1000 bs.const
scoreboard players operation #f bs.ctx *= $random.fractal_noise_2d.lacunarity bs.in
scoreboard players operation #f bs.ctx /= 1000 bs.const

scoreboard players remove #o bs.ctx 1
execute if score #o bs.ctx matches 1.. run function bs.random:noise/fractal_noise_2d/loop

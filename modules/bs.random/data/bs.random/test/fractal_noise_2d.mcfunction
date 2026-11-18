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


# The noise matches the reference values
data modify storage bs.random:fractal_noise_2d in set value {x:28656,y:1203,size:16,seed:5865932,octaves:4,persistence:0.5,lacunarity:2.0}
function #bs.random:fractal_noise_2d
execute store result score #n bs.ctx run data get storage bs.random:fractal_noise_2d out 1000
assert score #n bs.ctx matches -201..-195
data modify storage bs.random:fractal_noise_2d in set value {x:15589,y:812,size:8,seed:57678,octaves:2,persistence:0.7,lacunarity:1.5}
function #bs.random:fractal_noise_2d
execute store result score #n bs.ctx run data get storage bs.random:fractal_noise_2d out 1000
assert score #n bs.ctx matches -804..-798
data modify storage bs.random:fractal_noise_2d in set value {x:-420,y:5123,size:32,seed:1,octaves:6,persistence:0.2,lacunarity:2.5}
function #bs.random:fractal_noise_2d
execute store result score #n bs.ctx run data get storage bs.random:fractal_noise_2d out 1000
assert score #n bs.ctx matches 438..444
data modify storage bs.random:fractal_noise_2d in set value {x:1000,y:-1000,size:64,seed:123456789,octaves:16,persistence:0.5,lacunarity:2.0}
function #bs.random:fractal_noise_2d
execute store result score #n bs.ctx run data get storage bs.random:fractal_noise_2d out 1000
assert score #n bs.ctx matches 31..37

# A single octave is the simplex noise
data modify storage bs.random:fractal_noise_2d in set value {x:77,y:77,size:16,seed:3,octaves:1,persistence:0.5,lacunarity:2.0}
function #bs.random:fractal_noise_2d
data modify storage bs.random:simplex_noise_2d in set value {x:77,y:77,size:16,seed:3}
function #bs.random:simplex_noise_2d
execute store result score #f bs.ctx run data get storage bs.random:fractal_noise_2d out 1000000
execute store result score #s bs.ctx run data get storage bs.random:simplex_noise_2d out 1000000
scoreboard players operation #f bs.ctx -= #s bs.ctx
assert score #f bs.ctx matches -1..1

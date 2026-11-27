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
data modify storage bs.random:fractal_noise in set value {pos:[28656,1203,77],size:16,seed:5865932,octaves:4,persistence:0.5,lacunarity:2.0}
function #bs.random:fractal_noise/3d
assert result -225..-219 run data get storage bs.random:fractal_noise out 1000
data modify storage bs.random:fractal_noise in set value {pos:[-420,5123,-77],size:32,seed:1,octaves:6,persistence:0.2,lacunarity:2.5}
function #bs.random:fractal_noise/3d
assert result -351..-345 run data get storage bs.random:fractal_noise out 1000
data modify storage bs.random:fractal_noise in set value {pos:[1000,-1000,500],size:64,seed:123456789,octaves:16,persistence:0.5,lacunarity:2.0}
function #bs.random:fractal_noise/3d
assert result 168..174 run data get storage bs.random:fractal_noise out 1000

# A persistence of 1 weighs every octave the same
data modify storage bs.random:fractal_noise in set value {pos:[1000,-1000,500],size:64,seed:123456789,octaves:5,persistence:1.0,lacunarity:2.0}
function #bs.random:fractal_noise/3d
assert result -49..-43 run data get storage bs.random:fractal_noise out 1000

# A single octave is the simplex noise
data modify storage bs.random:fractal_noise in set value {pos:[77,77,77],size:16,seed:3,octaves:1,persistence:0.5,lacunarity:2.0}
function #bs.random:fractal_noise/3d
data modify storage bs.random:simplex_noise in set value {pos:[77,77,77],size:16,seed:3}
function #bs.random:simplex_noise/3d
execute store result score #f bs.ctx run data get storage bs.random:fractal_noise out 1000000
execute store result score #s bs.ctx run data get storage bs.random:simplex_noise out 1000000
scoreboard players operation #f bs.ctx -= #s bs.ctx
assert score #f bs.ctx matches -1..1

# Two neighbouring blocks stay close on each side of the origin, on each axis
data modify storage bs.random:fractal_noise in set value {pos:[-1,1000,37],size:256,seed:5,octaves:4,persistence:0.5,lacunarity:2.0}
function #bs.random:fractal_noise/3d
execute store result score #f bs.ctx run data get storage bs.random:fractal_noise out 1000
data modify storage bs.random:fractal_noise in set value {pos:[0,1000,37],size:256,seed:5,octaves:4,persistence:0.5,lacunarity:2.0}
function #bs.random:fractal_noise/3d
execute store result score #s bs.ctx run data get storage bs.random:fractal_noise out 1000
scoreboard players operation #f bs.ctx -= #s bs.ctx
assert score #f bs.ctx matches -60..60
data modify storage bs.random:fractal_noise in set value {pos:[1000,-1,37],size:256,seed:5,octaves:4,persistence:0.5,lacunarity:2.0}
function #bs.random:fractal_noise/3d
execute store result score #f bs.ctx run data get storage bs.random:fractal_noise out 1000
data modify storage bs.random:fractal_noise in set value {pos:[1000,0,37],size:256,seed:5,octaves:4,persistence:0.5,lacunarity:2.0}
function #bs.random:fractal_noise/3d
execute store result score #s bs.ctx run data get storage bs.random:fractal_noise out 1000
scoreboard players operation #f bs.ctx -= #s bs.ctx
assert score #f bs.ctx matches -60..60
data modify storage bs.random:fractal_noise in set value {pos:[1000,37,-1],size:256,seed:5,octaves:4,persistence:0.5,lacunarity:2.0}
function #bs.random:fractal_noise/3d
execute store result score #f bs.ctx run data get storage bs.random:fractal_noise out 1000
data modify storage bs.random:fractal_noise in set value {pos:[1000,37,0],size:256,seed:5,octaves:4,persistence:0.5,lacunarity:2.0}
function #bs.random:fractal_noise/3d
execute store result score #s bs.ctx run data get storage bs.random:fractal_noise out 1000
scoreboard players operation #f bs.ctx -= #s bs.ctx
assert score #f bs.ctx matches -60..60

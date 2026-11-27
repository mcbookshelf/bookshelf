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

# The noise matches the reference values, in each of the 6 shapes a cell is cut in
data modify storage bs.random:simplex_noise in set value {pos:[28656,1203,77],size:16,seed:5865932}
function #bs.random:simplex_noise/3d
assert result -453..-447 run data get storage bs.random:simplex_noise out 1000
data modify storage bs.random:simplex_noise in set value {pos:[28656,77,1203],size:16,seed:5865932}
function #bs.random:simplex_noise/3d
assert result 257..263 run data get storage bs.random:simplex_noise out 1000
data modify storage bs.random:simplex_noise in set value {pos:[1203,28656,77],size:16,seed:5865932}
function #bs.random:simplex_noise/3d
assert result 78..84 run data get storage bs.random:simplex_noise out 1000
data modify storage bs.random:simplex_noise in set value {pos:[1203,77,28656],size:16,seed:5865932}
function #bs.random:simplex_noise/3d
assert result 565..571 run data get storage bs.random:simplex_noise out 1000
data modify storage bs.random:simplex_noise in set value {pos:[77,28656,1203],size:16,seed:5865932}
function #bs.random:simplex_noise/3d
assert result 444..450 run data get storage bs.random:simplex_noise out 1000
data modify storage bs.random:simplex_noise in set value {pos:[77,1203,28656],size:16,seed:5865932}
function #bs.random:simplex_noise/3d
assert result 241..247 run data get storage bs.random:simplex_noise out 1000

# Far from the origin, and with negative coordinates
data modify storage bs.random:simplex_noise in set value {pos:[-420,5123,-77],size:32,seed:1}
function #bs.random:simplex_noise/3d
assert result -498..-492 run data get storage bs.random:simplex_noise out 1000
data modify storage bs.random:simplex_noise in set value {pos:[1000,-1000,500],size:1,seed:123456789}
function #bs.random:simplex_noise/3d
assert result 200..206 run data get storage bs.random:simplex_noise out 1000
data modify storage bs.random:simplex_noise in set value {pos:[-29999984,319,29999984],size:16,seed:-7}
function #bs.random:simplex_noise/3d
assert result 776..782 run data get storage bs.random:simplex_noise out 1000

# The largest seeds
data modify storage bs.random:simplex_noise in set value {pos:[4321,-8765,99],size:24,seed:2147483647}
function #bs.random:simplex_noise/3d
assert result 228..234 run data get storage bs.random:simplex_noise out 1000
data modify storage bs.random:simplex_noise in set value {pos:[4321,-8765,99],size:24,seed:-2147483648}
function #bs.random:simplex_noise/3d
assert result -372..-366 run data get storage bs.random:simplex_noise out 1000

# Two neighbouring blocks stay close on each side of the origin, on each axis
data modify storage bs.random:simplex_noise in set value {pos:[-1,1000,37],size:256,seed:5}
function #bs.random:simplex_noise/3d
execute store result score #f bs.ctx run data get storage bs.random:simplex_noise out 1000
data modify storage bs.random:simplex_noise in set value {pos:[0,1000,37],size:256,seed:5}
function #bs.random:simplex_noise/3d
execute store result score #s bs.ctx run data get storage bs.random:simplex_noise out 1000
scoreboard players operation #f bs.ctx -= #s bs.ctx
assert score #f bs.ctx matches -60..60
data modify storage bs.random:simplex_noise in set value {pos:[1000,-1,37],size:256,seed:5}
function #bs.random:simplex_noise/3d
execute store result score #f bs.ctx run data get storage bs.random:simplex_noise out 1000
data modify storage bs.random:simplex_noise in set value {pos:[1000,0,37],size:256,seed:5}
function #bs.random:simplex_noise/3d
execute store result score #s bs.ctx run data get storage bs.random:simplex_noise out 1000
scoreboard players operation #f bs.ctx -= #s bs.ctx
assert score #f bs.ctx matches -60..60
data modify storage bs.random:simplex_noise in set value {pos:[1000,37,-1],size:256,seed:5}
function #bs.random:simplex_noise/3d
execute store result score #f bs.ctx run data get storage bs.random:simplex_noise out 1000
data modify storage bs.random:simplex_noise in set value {pos:[1000,37,0],size:256,seed:5}
function #bs.random:simplex_noise/3d
execute store result score #s bs.ctx run data get storage bs.random:simplex_noise out 1000
scoreboard players operation #f bs.ctx -= #s bs.ctx
assert score #f bs.ctx matches -60..60

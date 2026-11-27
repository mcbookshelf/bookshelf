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
data modify storage bs.random:simplex_noise in set value {pos:[28656,1203],size:16,seed:5865932}
function #bs.random:simplex_noise/2d
assert result -627..-621 run data get storage bs.random:simplex_noise out 1000
data modify storage bs.random:simplex_noise in set value {pos:[15589,812],size:8,seed:57678}
function #bs.random:simplex_noise/2d
assert result -288..-282 run data get storage bs.random:simplex_noise out 1000
data modify storage bs.random:simplex_noise in set value {pos:[1000,-1003],size:1,seed:123456789}
function #bs.random:simplex_noise/2d
assert result -398..-392 run data get storage bs.random:simplex_noise out 1000

# Far from the origin, and with negative coordinates
data modify storage bs.random:simplex_noise in set value {pos:[-420,5123],size:32,seed:1}
function #bs.random:simplex_noise/2d
assert result 322..328 run data get storage bs.random:simplex_noise out 1000
data modify storage bs.random:simplex_noise in set value {pos:[-29999984,29999991],size:16,seed:-7}
function #bs.random:simplex_noise/2d
assert result -681..-675 run data get storage bs.random:simplex_noise out 1000

# Every seed has its own noise, up to the largest ones
data modify storage bs.random:simplex_noise in set value {pos:[1000,2000],size:71,seed:5}
function #bs.random:simplex_noise/2d
assert result 420..426 run data get storage bs.random:simplex_noise out 1000
data modify storage bs.random:simplex_noise in set value {pos:[1000,2000],size:71,seed:6}
function #bs.random:simplex_noise/2d
assert result 461..467 run data get storage bs.random:simplex_noise out 1000
data modify storage bs.random:simplex_noise in set value {pos:[1000,2000],size:71,seed:46342}
function #bs.random:simplex_noise/2d
assert result 280..286 run data get storage bs.random:simplex_noise out 1000
data modify storage bs.random:simplex_noise in set value {pos:[4321,-8765],size:24,seed:2147483647}
function #bs.random:simplex_noise/2d
assert result 568..574 run data get storage bs.random:simplex_noise out 1000
data modify storage bs.random:simplex_noise in set value {pos:[4321,-8765],size:24,seed:-2147483648}
function #bs.random:simplex_noise/2d
assert result 455..461 run data get storage bs.random:simplex_noise out 1000

# The noise does not come back a few hundred cells away
data modify storage bs.random:simplex_noise in set value {pos:[8768,6573],size:71,seed:5}
function #bs.random:simplex_noise/2d
assert result 756..762 run data get storage bs.random:simplex_noise out 1000

# Two neighbouring blocks stay close on each side of the origin, on each axis
data modify storage bs.random:simplex_noise in set value {pos:[-1,1000],size:64,seed:5}
function #bs.random:simplex_noise/2d
execute store result score #f bs.ctx run data get storage bs.random:simplex_noise out 1000
data modify storage bs.random:simplex_noise in set value {pos:[0,1000],size:64,seed:5}
function #bs.random:simplex_noise/2d
execute store result score #s bs.ctx run data get storage bs.random:simplex_noise out 1000
scoreboard players operation #f bs.ctx -= #s bs.ctx
assert score #f bs.ctx matches -60..60
data modify storage bs.random:simplex_noise in set value {pos:[1000,-1],size:64,seed:5}
function #bs.random:simplex_noise/2d
execute store result score #f bs.ctx run data get storage bs.random:simplex_noise out 1000
data modify storage bs.random:simplex_noise in set value {pos:[1000,0],size:64,seed:5}
function #bs.random:simplex_noise/2d
execute store result score #s bs.ctx run data get storage bs.random:simplex_noise out 1000
scoreboard players operation #f bs.ctx -= #s bs.ctx
assert score #f bs.ctx matches -60..60

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
data modify storage bs.random:simplex_noise in set value {pos:[28661],size:16,seed:5865932}
function #bs.random:simplex_noise/1d
assert result -521..-515 run data get storage bs.random:simplex_noise out 1000
data modify storage bs.random:simplex_noise in set value {pos:[1003],size:7,seed:123456789}
function #bs.random:simplex_noise/1d
assert result 715..721 run data get storage bs.random:simplex_noise out 1000

# Far from the origin, and with negative coordinates
data modify storage bs.random:simplex_noise in set value {pos:[-421],size:32,seed:1}
function #bs.random:simplex_noise/1d
assert result 71..77 run data get storage bs.random:simplex_noise out 1000
data modify storage bs.random:simplex_noise in set value {pos:[-29999977],size:16,seed:-7}
function #bs.random:simplex_noise/1d
assert result -83..-77 run data get storage bs.random:simplex_noise out 1000

# The largest seeds
data modify storage bs.random:simplex_noise in set value {pos:[4330],size:24,seed:2147483647}
function #bs.random:simplex_noise/1d
assert result -332..-326 run data get storage bs.random:simplex_noise out 1000
data modify storage bs.random:simplex_noise in set value {pos:[4330],size:24,seed:-2147483648}
function #bs.random:simplex_noise/1d
assert result -271..-265 run data get storage bs.random:simplex_noise out 1000

# Two neighbouring blocks stay close on each side of the origin
data modify storage bs.random:simplex_noise in set value {pos:[-1],size:64,seed:5}
function #bs.random:simplex_noise/1d
execute store result score #f bs.ctx run data get storage bs.random:simplex_noise out 1000
data modify storage bs.random:simplex_noise in set value {pos:[0],size:64,seed:5}
function #bs.random:simplex_noise/1d
execute store result score #s bs.ctx run data get storage bs.random:simplex_noise out 1000
scoreboard players operation #f bs.ctx -= #s bs.ctx
assert score #f bs.ctx matches -60..60

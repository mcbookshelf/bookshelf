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
data modify storage bs.random:simplex_noise_2d in set value {x:28656,y:1203,size:16,seed:5865932}
function #bs.random:simplex_noise_2d
execute store result score #n bs.ctx run data get storage bs.random:simplex_noise_2d out 1000
assert score #n bs.ctx matches -362..-356
data modify storage bs.random:simplex_noise_2d in set value {x:15589,y:812,size:8,seed:57678}
function #bs.random:simplex_noise_2d
execute store result score #n bs.ctx run data get storage bs.random:simplex_noise_2d out 1000
assert score #n bs.ctx matches -880..-874
data modify storage bs.random:simplex_noise_2d in set value {x:-420,y:5123,size:32,seed:1}
function #bs.random:simplex_noise_2d
execute store result score #n bs.ctx run data get storage bs.random:simplex_noise_2d out 1000
assert score #n bs.ctx matches 345..351
data modify storage bs.random:simplex_noise_2d in set value {x:1000,y:-1000,size:1,seed:123456789}
function #bs.random:simplex_noise_2d
execute store result score #n bs.ctx run data get storage bs.random:simplex_noise_2d out 1000
assert score #n bs.ctx matches 68..74
data modify storage bs.random:simplex_noise_2d in set value {x:-29999984,y:29999984,size:16,seed:-7}
function #bs.random:simplex_noise_2d
execute store result score #n bs.ctx run data get storage bs.random:simplex_noise_2d out 1000
assert score #n bs.ctx matches -661..-655

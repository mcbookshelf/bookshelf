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


# The index matches the value chosen
function #bs.random:weighted_choice.in {options:[0,1,2,3,4],weights:[1,1,1,1,1]}
execute store result score #i bs.ctx run function #bs.random:weighted_choice
execute store result score #v bs.ctx run data get storage bs.random:weighted_choice out
assert score #i bs.ctx = #v bs.ctx
assert score #i bs.ctx matches 0..4

# A value of weight 0 is never chosen
function #bs.random:weighted_choice.in {options:[0,0,42,0,0,0,0],weights:[0,0,1,0,0,0,0]}
assert result 2 run function #bs.random:weighted_choice
assert data storage bs.random:weighted_choice {out:42}

# Any value can be chosen
function #bs.random:weighted_choice.in {options:[{id:"minecraft:stone"},"text"],weights:[1,0]}
assert result 0 run function #bs.random:weighted_choice
assert data storage bs.random:weighted_choice {out:{id:"minecraft:stone"}}

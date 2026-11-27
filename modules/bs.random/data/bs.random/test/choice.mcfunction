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
function #bs.random:choice.in {options:[0,1,2,3,4]}
execute store result score #i bs.ctx run function #bs.random:choice
execute store result score #v bs.ctx run data get storage bs.random:choice out
assert score #i bs.ctx = #v bs.ctx
assert score #i bs.ctx matches 0..4

# Any value can be chosen
function #bs.random:choice.in {options:[{id:"minecraft:stone"}]}
assert data storage bs.random:choice {out:{id:"minecraft:stone"}}

# It does not choose the same index each time
data modify storage bs.random:choice in.options set value [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50]
execute store result score #0 bs.ctx run function #bs.random:choice
execute store result score #1 bs.ctx run function #bs.random:choice
execute store result score #2 bs.ctx run function #bs.random:choice
execute store result score #3 bs.ctx run function #bs.random:choice
execute store result score #4 bs.ctx run function #bs.random:choice
execute if score #0 bs.ctx = #1 bs.ctx if score #1 bs.ctx = #2 bs.ctx if score #2 bs.ctx = #3 bs.ctx if score #3 bs.ctx = #4 bs.ctx run fail "choice should not always choose the same index"

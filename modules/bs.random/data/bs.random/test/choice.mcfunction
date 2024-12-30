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

# return a value that match the index
data modify storage bs:in random.choice.options set value [0,1,2,3,4]
execute store result score #i bs.ctx run function #bs.random:choice
execute if score #i bs.ctx matches 0 run assert data storage bs:out random{choice:0}
execute if score #i bs.ctx matches 1 run assert data storage bs:out random{choice:1}
execute if score #i bs.ctx matches 2 run assert data storage bs:out random{choice:2}
execute if score #i bs.ctx matches 3 run assert data storage bs:out random{choice:3}
execute if score #i bs.ctx matches 4 run assert data storage bs:out random{choice:4}

# it does not return the same index each time (using a large dataset)
data modify storage bs:in random.choice.options set value [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50]
execute store result score #0 bs.ctx run function #bs.random:choice
execute store result score #1 bs.ctx run function #bs.random:choice
execute store result score #2 bs.ctx run function #bs.random:choice
execute store result score #3 bs.ctx run function #bs.random:choice
execute store result score #4 bs.ctx run function #bs.random:choice
execute if score #0 bs.ctx = #1 bs.ctx if score #1 bs.ctx = #2 bs.ctx if score #2 bs.ctx = #3 bs.ctx if score #3 bs.ctx = #4 bs.ctx run fail "Choice must return a random index each time"

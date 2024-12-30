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
data modify storage bs:in random.weighted_choice.options set value [0,1,2,3,4]
execute store result score #i bs.ctx run function #bs.random:weighted_choice
execute if score #i bs.ctx matches 0 run assert data storage bs:out random{weighted_choice:0}
execute if score #i bs.ctx matches 1 run assert data storage bs:out random{weighted_choice:1}
execute if score #i bs.ctx matches 2 run assert data storage bs:out random{weighted_choice:2}
execute if score #i bs.ctx matches 3 run assert data storage bs:out random{weighted_choice:3}
execute if score #i bs.ctx matches 4 run assert data storage bs:out random{weighted_choice:4}

# the weight has an impact on the returned value
data modify storage bs:in random.weighted_choice.options set value [0,42,0,0,0,0]
data modify storage bs:in random.weighted_choice.weights set value [0,1,0,0,0,0]
execute store result score #i bs.ctx run function #bs.random:weighted_choice
assert data storage bs:out random{weighted_choice:42}
assert score #i bs.ctx matches 1

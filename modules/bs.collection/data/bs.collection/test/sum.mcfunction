# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Gunivers
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
# @dummy

# Sum of 1,2,3,4,5 = 15 - check return channel (at scale 1000 = 15000)
data modify storage bs:out collection set value [1, 2, 3, 4, 5]
execute store result score #r bs.ctx run function #bs.collection:sum
assert score #r bs.ctx matches 15000

# Sum of 1,2,3,4,5 - check storage output
data modify storage bs:out collection set value [1, 2, 3, 4, 5]
function #bs.collection:sum
assert data storage bs:out {collection: 15.0d}

# Sum of single element
data modify storage bs:out collection set value [42]
execute store result score #r bs.ctx run function #bs.collection:sum
assert score #r bs.ctx matches 42000

# Sum of single element - check storage output
data modify storage bs:out collection set value [42]
function #bs.collection:sum
assert data storage bs:out {collection: 42.0d}

# Sum with decimals (1.5, 2.5, 3.0 -> 1500, 2500, 3000 at scale 1000 -> sum = 7000)
data modify storage bs:out collection set value [1.5d, 2.5d, 3.0d]
execute store result score #r bs.ctx run function #bs.collection:sum
assert score #r bs.ctx matches 7000

# Sum with decimals - check storage output
data modify storage bs:out collection set value [1.5d, 2.5d, 3.0d]
function #bs.collection:sum
assert data storage bs:out {collection: 7.0d}

# Sum with negative numbers
data modify storage bs:out collection set value [-10, 5, 10]
execute store result score #r bs.ctx run function #bs.collection:sum
assert score #r bs.ctx matches 5000

# Sum with negative numbers - check storage output
data modify storage bs:out collection set value [-10, 5, 10]
function #bs.collection:sum
assert data storage bs:out {collection: 5.0d}

# Sum of empty collection - check return channel
data modify storage bs:out collection set value []
execute store result score #r bs.ctx run function #bs.collection:sum
assert score #r bs.ctx matches 0

# Sum of empty collection - check storage output
data modify storage bs:out collection set value []
function #bs.collection:sum
assert data storage bs:out {collection: 0.0d}

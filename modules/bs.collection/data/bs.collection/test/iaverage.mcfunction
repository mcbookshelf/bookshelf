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

# Average of 1,2,3,4,5 = 15/5 = 3 - check return channel (at scale 1000 = 3000)
data modify storage bs:out collection.value set value [1, 2, 3, 4, 5]
execute store result score #r bs.ctx run function #bs.collection:iaverage {scale: 1000}
assert score #r bs.ctx matches 3000

# Average of 1,2,3,4,5 - check storage output
data modify storage bs:out collection.value set value [1, 2, 3, 4, 5]
function #bs.collection:iaverage {scale: 1000}
assert data storage bs:out {collection: {value: 3.0d}}

# Average of 1,2 - check storage output
data modify storage bs:out collection.value set value [1, 2]
execute store result score #r bs.ctx run function #bs.collection:iaverage {scale: 1000}
assert score #r bs.ctx matches 1500
assert data storage bs:out {collection: {value: 1.5d}}

# Average of single element
data modify storage bs:out collection.value set value [42]
execute store result score #r bs.ctx run function #bs.collection:iaverage {scale: 1000}
assert score #r bs.ctx matches 42000

# Average of single element - check storage output
data modify storage bs:out collection.value set value [42]
function #bs.collection:iaverage {scale: 1000}
assert data storage bs:out {collection: {value: 42.0d}}

# Average with negative numbers
data modify storage bs:out collection.value set value [-10, 0, 10]
execute store result score #r bs.ctx run function #bs.collection:iaverage {scale: 1000}
assert score #r bs.ctx matches 0

# Average with negative numbers - check storage output
data modify storage bs:out collection.value set value [-10, 0, 10]
function #bs.collection:iaverage {scale: 1000}
assert data storage bs:out {collection: {value: 0.0d}}

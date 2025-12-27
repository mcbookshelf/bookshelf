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

# Minimum of positive numbers with scale 1 - check return channel
data modify storage bs:out collection.value set value [5, 2, 8, 1, 9]
execute store result score #r bs.ctx run function #bs.collection:min {scale: 1}
assert score #r bs.ctx matches 1

# Minimum of positive numbers with scale 1 - check storage output
data modify storage bs:out collection.value set value [5, 2, 8, 1, 9]
function #bs.collection:min {scale: 1}
assert data storage bs:out {collection: {value: 1}}

# Minimum with negative numbers with scale 1 - check return channel
data modify storage bs:out collection.value set value [5, -3, 8, 1, -10]
execute store result score #r bs.ctx run function #bs.collection:min {scale: 1}
assert score #r bs.ctx matches -10

# Minimum with negative numbers with scale 1 - check storage output
data modify storage bs:out collection.value set value [5, -3, 8, 1, -10]
function #bs.collection:min {scale: 1}
assert data storage bs:out {collection: {value: -10}}

# Minimum with scale 10 - check return channel (3.2, 1.5, 4.8 -> 32, 15, 48 at scale 10)
data modify storage bs:out collection.value set value [3.2d, 1.5d, 4.8d]
execute store result score #r bs.ctx run function #bs.collection:min {scale: 10}
assert score #r bs.ctx matches 15

# Minimum with scale 10 - check storage output (should return 1.5)
data modify storage bs:out collection.value set value [3.2d, 1.5d, 4.8d]
function #bs.collection:min {scale: 10}
assert data storage bs:out {collection: {value: 1.5d}}

# Minimum of single element with scale 100
data modify storage bs:out collection.value set value [0.42d]
execute store result score #r bs.ctx run function #bs.collection:min {scale: 100}
assert score #r bs.ctx matches 42

# Minimum of single element with scale 100 - check storage output
data modify storage bs:out collection.value set value [0.42d]
function #bs.collection:min {scale: 100}
assert data storage bs:out {collection: {value: 0.42d}}

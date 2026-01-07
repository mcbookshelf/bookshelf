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

# Slice 1 to 3 of [0, 1, 2, 3, 4] -> [1, 2]
data modify storage bs:out collection.value set value [0, 1, 2, 3, 4]
function #bs.collection:slice {min: 1, max: 3}
assert data storage bs:out {collection: {value: [1, 2]}}

# Slice 0 to 2 -> [0, 1]
data modify storage bs:out collection.value set value [0, 1, 2, 3, 4]
function #bs.collection:slice {min: 0, max: 2}
assert data storage bs:out {collection: {value: [0, 1]}}

# Slice with max > size -> Error
data modify storage bs:out collection.value set value [0, 1, 2]
execute store success score #success bs.ctx run function #bs.collection:slice {min: 1, max: 5}
assert score #success bs.ctx matches 0
assert data storage bs:out {collection: {value: [0, 1, 2]}}

# Slice with min > size -> Error
data modify storage bs:out collection.value set value [0, 1, 2]
execute store success score #success bs.ctx run function #bs.collection:slice {min: 5, max: 6}
assert score #success bs.ctx matches 0
assert data storage bs:out {collection: {value: [0, 1, 2]}}

# Slice with min >= max -> Error (Min must be lower than max)
data modify storage bs:out collection.value set value [0, 1, 2]
execute store success score #success bs.ctx run function #bs.collection:slice {min: 2, max: 1}
assert score #success bs.ctx matches 0
assert data storage bs:out {collection: {value: [0, 1, 2]}}

# Slice with negative min (-2) -> last 2 elements -> [3, 4] (if size 5, -2 => 3. slice 3 to 5)
data modify storage bs:out collection.value set value [0, 1, 2, 3, 4]
function #bs.collection:slice {min: -2, max: 5}
assert data storage bs:out {collection: {value: [3, 4]}}

# Slice with negative max (-1) -> exclude last element -> [0, 1, 2, 3] (if size 5, -1 => 4. slice 0 to 4)
data modify storage bs:out collection.value set value [0, 1, 2, 3, 4]
function #bs.collection:slice {min: 0, max: -1}
assert data storage bs:out {collection: {value: [0, 1, 2, 3]}}

# Slice with both negative (-3, -1) -> [2, 3] (if size 5, -3=>2, -1=>4. slice 2 to 4)
data modify storage bs:out collection.value set value [0, 1, 2, 3, 4]
function #bs.collection:slice {min: -3, max: -1}
assert data storage bs:out {collection: {value: [2, 3]}}

# Slice with min < -size -> Error
data modify storage bs:out collection.value set value [0, 1, 2]
execute store success score #success bs.ctx run function #bs.collection:slice {min: -10, max: 2}
assert score #success bs.ctx matches 0
assert data storage bs:out {collection: {value: [0, 1, 2]}}

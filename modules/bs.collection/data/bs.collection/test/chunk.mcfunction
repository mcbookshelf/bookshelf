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

# Chunk size 2 exact division
data modify storage bs:out collection.value set value [1, 2, 3, 4]
function bs.collection:chunk/chunk {size: 2}
assert data storage bs:out {collection: {value: [[1, 2], [3, 4]]}}

# Chunk size 2 with remainder
data modify storage bs:out collection.value set value [1, 2, 3, 4, 5]
function bs.collection:chunk/chunk {size: 2}
assert data storage bs:out {collection: {value: [[1, 2], [3, 4], [5]]}}

# Chunk size 1
data modify storage bs:out collection.value set value [1, 2, 3]
function bs.collection:chunk/chunk {size: 1}
assert data storage bs:out {collection: {value: [[1], [2], [3]]}}

# Chunk size larger than collection
data modify storage bs:out collection.value set value [1, 2]
function bs.collection:chunk/chunk {size: 5}
assert data storage bs:out {collection: {value: [[1, 2]]}}

# Empty collection
data modify storage bs:out collection.value set value []
function bs.collection:chunk/chunk {size: 2}
assert data storage bs:out {collection: {value: []}}

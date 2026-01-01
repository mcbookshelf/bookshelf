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

# Concat array of integers
data modify storage bs:out collection.value set value [[1, 2], [3], [4, 5]]
function #bs.collection:concat
assert data storage bs:out {collection: {value: [1, 2, 3, 4, 5]}}

# Concat array of objects
data modify storage bs:out collection.value set value [[{a:1}], [{b:2}], [{c:3}]]
function #bs.collection:concat
assert data storage bs:out {collection: {value: [{a:1}, {b:2}, {c:3}]}}

# Concat with empty arrays
data modify storage bs:out collection.value set value [[1], [], [2]]
function #bs.collection:concat
assert data storage bs:out {collection: {value: [1, 2]}}

# Concat single array
data modify storage bs:out collection.value set value [[1, 2, 3]]
function #bs.collection:concat
assert data storage bs:out {collection: {value: [1, 2, 3]}}

# Concat empty input
data modify storage bs:out collection.value set value []
function #bs.collection:concat
assert data storage bs:out {collection: {value: []}}

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

# Find last index of element with value 3 - last 3 is at index 4
data modify storage bs:out collection.value set value [1, 2, 3, 4, 3, 5]
assert run function #bs.collection:last_index_of {run: "execute if data storage bs:lambda collection{value: 3}"}
assert data storage bs:out {collection: {value: 4}}

# Find last index of element with value 5 - 5 is at index 5
data modify storage bs:out collection.value set value [1, 2, 3, 4, 3, 5]
assert run function #bs.collection:last_index_of {run: "execute if data storage bs:lambda collection{value: 5}"}
assert data storage bs:out {collection: {value: 5}}

# Find last index in collection where no element matches
data modify storage bs:out collection.value set value [1, 2, 3]
function #bs.collection:last_index_of {run: "execute if data storage bs:lambda collection{value: 10}"}
assert data storage bs:out {collection: {value: -1}}

# Find last index in empty collection - should fail
data modify storage bs:out collection.value set value []
function #bs.collection:last_index_of {run: "execute if data storage bs:lambda collection{value: 1}"}
assert data storage bs:out {collection: {value: -1}}

# Find last index of string matching - last "b" is at index 3
data modify storage bs:out collection.value set value ["a", "b", "c", "b", "d"]
assert run function #bs.collection:last_index_of {run: "execute if data storage bs:lambda collection{value: 'b'}"}
assert data storage bs:out {collection: {value: 3}}

# Find last index with single element that matches - element is at index 0
data modify storage bs:out collection.value set value [42]
assert run function #bs.collection:last_index_of {run: "execute if data storage bs:lambda collection{value: 42}"}
assert data storage bs:out {collection: {value: 0}}

# Find last index with single element that doesn't match
data modify storage bs:out collection.value set value [42]
function #bs.collection:last_index_of {run: "execute if data storage bs:lambda collection{value: 10}"}
assert data storage bs:out {collection: {value: -1}}

# Find last index when first element matches - element is at index 0
data modify storage bs:out collection.value set value [3, 1, 2]
assert run function #bs.collection:last_index_of {run: "execute if data storage bs:lambda collection{value: 3}"}
assert data storage bs:out {collection: {value: 0}}

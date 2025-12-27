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

# Reverse a list of integers
data modify storage bs:out collection.value set value [1, 2, 3, 4, 5]
function #bs.collection:reverse
assert data storage bs:out {collection: {value: [5, 4, 3, 2, 1]}}

# Reverse a list of strings
data modify storage bs:out collection.value set value ["a", "b", "c"]
function #bs.collection:reverse
assert data storage bs:out {collection: {value: ["c", "b", "a"]}}

# Reverse a list of doubles
data modify storage bs:out collection.value set value [1.5d, 2.5d, 3.5d]
function #bs.collection:reverse
assert data storage bs:out {collection: {value: [3.5d, 2.5d, 1.5d]}}

# Reverse a single element - should return same element
data modify storage bs:out collection.value set value [42]
function #bs.collection:reverse
assert data storage bs:out {collection: {value: [42]}}

# Reverse an empty collection - should return empty collection
data modify storage bs:out collection.value set value []
function #bs.collection:reverse
assert data storage bs:out {collection: {value: []}}

# Reverse a list of mixed types
data modify storage bs:out collection.value set value [1, "a", 2.5d, true]
function #bs.collection:reverse
assert data storage bs:out {collection: {value: [true, 2.5d, "a", 1]}}

# Reverse a list with duplicate elements
data modify storage bs:out collection.value set value [1, 2, 1, 2, 1]
function #bs.collection:reverse
assert data storage bs:out {collection: {value: [1, 2, 1, 2, 1]}}

# Reverse a nested list (elements are lists)
data modify storage bs:out collection.value set value [[1, 2], [3, 4], [5, 6]]
function #bs.collection:reverse
assert data storage bs:out {collection: {value: [[5, 6], [3, 4], [1, 2]]}}

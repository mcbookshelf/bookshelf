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

# Find element at index 2
data modify storage bs:out collection.value set value [1, 2, 3, 4, 5]
function #bs.collection:find {run: "execute if data storage bs:lambda collection{index: 2}"}
assert data storage bs:out {collection: {value: 3}}
assert data storage bs:out {collection: {index: 2}}

# No matching element (index 10 doesn't exist)
data modify storage bs:out collection.value set value [1, 2, 4, 5]
function #bs.collection:find {run: "execute if data storage bs:lambda collection{index: 10}"}
assert not data storage bs:out collection.value
assert data storage bs:out {collection: {index: -1}}

# Empty collection
data modify storage bs:out collection.value set value []
function #bs.collection:find {run: "execute if data storage bs:lambda collection{index: 0}"}
assert not data storage bs:out collection.value
assert data storage bs:out {collection: {index: -1}}

# Find first element (index 0)
data modify storage bs:out collection.value set value [3, 1, 2]
function #bs.collection:find {run: "execute if data storage bs:lambda collection{index: 0}"}
assert data storage bs:out {collection: {value: 3}}
assert data storage bs:out {collection: {index: 0}}

# Find last element (index 2 in 3-element collection)
data modify storage bs:out collection.value set value [1, 2, 3]
function #bs.collection:find {run: "execute if data storage bs:lambda collection{index: 2}"}
assert data storage bs:out {collection: {value: 3}}
assert data storage bs:out {collection: {index: 2}}

# Find using value check - "b" is at index 1
data modify storage bs:out collection.value set value ["a", "b", "c"]
function #bs.collection:find {run: "execute if data storage bs:lambda collection{value: 'b'}"}
assert data storage bs:out {collection: {value: "b"}}
assert data storage bs:out {collection: {index: 1}}

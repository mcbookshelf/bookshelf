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

# Find last element equal to 3 - last 3 is at index 4
data modify storage bs:out collection.value set value [1, 2, 3, 4, 3, 5]
execute store success score #r bs.ctx run function #bs.collection:find_last {run: "execute if data storage bs:lambda collection{value: 3}"}
assert score #r bs.ctx matches 1
assert data storage bs:out {collection: {value: 3}}
assert data storage bs:out {collection: {index: 4}}

# Find last element equal to 5 - 5 is at index 4
data modify storage bs:out collection.value set value [1, 2, 3, 4, 5]
execute store success score #r bs.ctx run function #bs.collection:find_last {run: "execute if data storage bs:lambda collection{value: 5}"}
assert score #r bs.ctx matches 1
assert data storage bs:out {collection: {value: 5}}
assert data storage bs:out {collection: {index: 4}}

# Find last in collection where no element matches
data modify storage bs:out collection.value set value [1, 2, 3]
execute store success score #r bs.ctx run function #bs.collection:find_last {run: "execute if data storage bs:lambda collection{value: 10}"}
assert score #r bs.ctx matches 0
assert data storage bs:out {collection: {index: -1}}

# Find last in empty collection - should fail
data modify storage bs:out collection.value set value []
execute store success score #r bs.ctx run function #bs.collection:find_last {run: "execute if data storage bs:lambda collection{value: 1}"}
assert score #r bs.ctx matches 0
assert data storage bs:out {collection: {index: -1}}

# Find last string matching - last "b" is at index 3
data modify storage bs:out collection.value set value ["a", "b", "c", "b", "d"]
execute store success score #r bs.ctx run function #bs.collection:find_last {run: "execute if data storage bs:lambda collection{value: 'b'}"}
assert score #r bs.ctx matches 1
assert data storage bs:out {collection: {value: "b"}}
assert data storage bs:out {collection: {index: 3}}

# Find last with single element that matches - 42 is at index 0
data modify storage bs:out collection.value set value [42]
execute store success score #r bs.ctx run function #bs.collection:find_last {run: "execute if data storage bs:lambda collection{value: 42}"}
assert score #r bs.ctx matches 1
assert data storage bs:out {collection: {value: 42}}
assert data storage bs:out {collection: {index: 0}}

# Find last with single element that doesn't match
data modify storage bs:out collection.value set value [42]
execute store success score #r bs.ctx run function #bs.collection:find_last {run: "execute if data storage bs:lambda collection{value: 10}"}
assert score #r bs.ctx matches 0
assert data storage bs:out {collection: {index: -1}}

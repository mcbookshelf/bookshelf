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

# SymDiff [1, 2, 3] ^ [2, 3, 4] -> [1, 4]
data modify storage bs:out collection.value set value [1, 2, 3]
data modify storage bs:in collection set value [2, 3, 4]
function #bs.collection:symmetric_difference
assert data storage bs:out {collection: {value: [1, 4]}}

# SymDiff distincts: [1, 1, 2] ^ [2, 3, 3] -> [1, 3]
data modify storage bs:out collection.value set value [1, 1, 2]
data modify storage bs:in collection set value [2, 3, 3]
function #bs.collection:symmetric_difference
assert data storage bs:out {collection: {value: [1, 3]}}

# SymDiff disjoint -> [1, 2, 3, 4]
data modify storage bs:out collection.value set value [1, 2]
data modify storage bs:in collection set value [3, 4]
function #bs.collection:symmetric_difference
assert data storage bs:out {collection: {value: [1, 2, 3, 4]}}

# SymDiff empty -> [1]
data modify storage bs:out collection.value set value []
data modify storage bs:in collection set value [1]
function #bs.collection:symmetric_difference
assert data storage bs:out {collection: {value: [1]}}

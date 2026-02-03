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

# Drop first 2 elements (indices 0, 1)
data modify storage bs:out collection.value set value [1, 2, 3, 4, 5]
function #bs.collection:drop_while {run: "execute if score #i bs.ctx matches ..1"}
assert data storage bs:out {collection: {value: [3, 4, 5]}}

# Drop all
data modify storage bs:out collection.value set value [1, 2, 3]
function #bs.collection:drop_while {run: "return 1"}
assert data storage bs:out {collection: {value: []}}

# Drop none
data modify storage bs:out collection.value set value [1, 2, 3]
function #bs.collection:drop_while {run: "return fail"}
assert data storage bs:out {collection: {value: [1, 2, 3]}}

# Drop until value is 3
data modify storage bs:out collection.value set value [1, 2, 3, 4, 5]
function #bs.collection:drop_while {run: "execute unless data storage bs:lambda {collection: {value: 3}}"}
assert data storage bs:out {collection: {value: [3, 4, 5]}}

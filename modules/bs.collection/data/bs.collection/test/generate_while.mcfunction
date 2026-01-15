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

# Generate sequence based on index (0, 1, 2) while value != 3
function #bs.collection:generate_while {run: "data modify storage bs:lambda collection.result set from storage bs:lambda collection.index", predicate: "execute unless data storage bs:lambda {collection: {result: 3}}"}
assert data storage bs:out {collection: {value: [0, 1, 2]}}

# Simplified predicate for test (assume execute if score or data)
# Generate 0..5 while value < 3
function #bs.collection:generate_while {run: "data modify storage bs:lambda collection.result set from storage bs:lambda collection.index", predicate: "execute if score #i bs.ctx matches ..2"}
assert data storage bs:out {collection: {value: [0, 1, 2]}}

# Generate while always false -> empty
function #bs.collection:generate_while {run: "data modify storage bs:lambda collection.result set value 1", predicate: "return fail"}
assert data storage bs:out {collection: {value: []}}

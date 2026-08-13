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

# Keep only elements that match the predicate
data modify storage bs:out collection.value set value [1, 3, 2, 3, 4]
function #bs.collection:filter {run: "execute if data storage bs:lambda collection{value: 3}"}
assert data storage bs:out {collection: {value: [3, 3]}}

# Keep all elements
data modify storage bs:out collection.value set value [1, 3, 2, 3, 4]
function #bs.collection:filter {run: "return 1"}
assert data storage bs:out {collection: {value: [1, 3, 2, 3, 4]}}

# Keep no elements
data modify storage bs:out collection.value set value [1, 3, 2, 3, 4]
function #bs.collection:filter {run: "return fail"}
assert data storage bs:out {collection: {value: []}}

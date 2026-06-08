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

# Partition based on index (index < 2)
# Indices: 0(true), 1(true), 2(false), 3(false)
data modify storage bs:out collection.value set value [1, 2, 3, 4]
function #bs.collection:partition {run: "return run execute if score #i bs.ctx matches ..1"}
assert data storage bs:out {collection: {value: [[1, 2], [3, 4]]}}

# All true
data modify storage bs:out collection.value set value [1, 2, 3]
function #bs.collection:partition {run: "return 1"}
assert data storage bs:out {collection: {value: [[1, 2, 3], []]}}

# All false
data modify storage bs:out collection.value set value [1, 2, 3]
function #bs.collection:partition {run: "return 0"}
assert data storage bs:out {collection: {value: [[], [1, 2, 3]]}}

# Empty
data modify storage bs:out collection.value set value []
function #bs.collection:partition {run: "return 1"}
assert data storage bs:out {collection: {value: [[], []]}}

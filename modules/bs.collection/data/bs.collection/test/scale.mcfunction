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

# Scale list of integers
data modify storage bs:out collection.value set value [1, 2, 3]
function #bs.collection:scale {scale: 2}
assert data storage bs:out {collection: {value: [2.0d, 4.0d, 6.0d]}}

# Scale list of doubles (truncates input to int before scaling)
data modify storage bs:out collection.value set value [1.0d, 2.0d]
function #bs.collection:scale {scale: 10}
assert data storage bs:out {collection: {value: [10.0d, 20.0d]}}

# Scale empty list
data modify storage bs:out collection.value set value []
function #bs.collection:scale {scale: 2}
assert data storage bs:out {collection: {value: []}}

# Scale by 0
data modify storage bs:out collection.value set value [1, 2, 3]
function #bs.collection:scale {scale: 0}
assert data storage bs:out {collection: {value: [0.0d, 0.0d, 0.0d]}}

# Scale by float (0.1)
data modify storage bs:out collection.value set value [10, 20, 30]
function #bs.collection:scale {scale: 0.1}
assert data storage bs:out {collection: {value: [1.0d, 2.0d, 3.0d]}}

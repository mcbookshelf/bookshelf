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

# Zip same length
data modify storage bs:out collection.value set value [1, 2, 3]
data modify storage bs:in collection set value [4, 5, 6]
function #bs.collection:zip
assert data storage bs:out {collection: {value: [[1, 4], [2, 5], [3, 6]]}}

# Zip input shorter
data modify storage bs:out collection.value set value [1, 2, 3]
data modify storage bs:in collection set value [4, 5]
function #bs.collection:zip
assert data storage bs:out {collection: {value: [[1, 4], [2, 5]]}}

# Zip input longer
data modify storage bs:out collection.value set value [1, 2]
data modify storage bs:in collection set value [4, 5, 6]
function #bs.collection:zip
assert data storage bs:out {collection: {value: [[1, 4], [2, 5]]}}

# Zip first empty
data modify storage bs:out collection.value set value []
data modify storage bs:in collection set value [4, 5]
function #bs.collection:zip
assert data storage bs:out {collection: {value: []}}

# Zip second empty
data modify storage bs:out collection.value set value [1, 2]
data modify storage bs:in collection set value []
function #bs.collection:zip
assert data storage bs:out {collection: {value: []}}

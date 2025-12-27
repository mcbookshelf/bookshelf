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

# Identity
data modify storage bs:out collection set value [0, 1, 2]
function #bs.collection:map {run: "data modify storage bs:lambda collection.result set from storage bs:lambda collection.value"}
assert data storage bs:out {collection: [0, 1, 2]}

# Constant
data modify storage bs:out collection set value [0, 1, 2]
function #bs.collection:map {run: "data modify storage bs:lambda collection.result set value 'a'"}
assert data storage bs:out {collection: ["a", "a", "a"]}

# Empty
data modify storage bs:out collection set value []
function #bs.collection:map {run: "say Should not run"}
assert not chat "Should not run"
assert data storage bs:out {collection: []}

# Index
data modify storage bs:out collection set value [10, 11, 12]
function #bs.collection:map {run: "data modify storage bs:lambda collection.result set from storage bs:lambda collection.index"}
assert data storage bs:out {collection: [0, 1, 2]}

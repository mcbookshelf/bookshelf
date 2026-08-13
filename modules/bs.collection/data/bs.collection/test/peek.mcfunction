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

# Empty
data modify storage bs:ward collection.peek set value []
data modify storage bs:out collection.value set value []
function #bs.collection:peek {run: "data modify storage bs:ward collection.peek append value 1"}
assert not data storage bs:ward collection{peek: [1]}
assert data storage bs:out {collection: {value: []}}

# Print
data modify storage bs:ward collection.peek set value []
data modify storage bs:out collection.value set value [10, 11, 12, 13]
function #bs.collection:peek {run: "data modify storage bs:ward collection.peek append from storage bs:lambda collection.value"}
assert data storage bs:out {collection: {value: [10, 11, 12, 13]}}
assert data storage bs:ward collection{peek: [10, 11, 12, 13]}

# Index
data modify storage bs:ward collection.peek set value []
data modify storage bs:out collection.value set value [10, 11, 12, 13]
function #bs.collection:peek {run: "data modify storage bs:ward collection.peek append from storage bs:lambda collection.index"}
assert data storage bs:out {collection: {value: [10, 11, 12, 13]}}
assert data storage bs:ward collection{peek: [0, 1, 2, 3]}

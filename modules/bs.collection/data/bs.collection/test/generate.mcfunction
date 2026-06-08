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

# Generate sequence of 3 constant values
function #bs.collection:generate {run: "data modify storage bs:lambda collection.result set value 1", limit: 3}
assert data storage bs:out {collection: {value: [1, 1, 1]}}

# Generate sequence based on index (0, 1, 2)
function #bs.collection:generate {run: "data modify storage bs:lambda collection.result set from storage bs:lambda collection.index", limit: 3}
assert data storage bs:out {collection: {value: [0, 1, 2]}}

# Generate empty sequence (limit 0)
function #bs.collection:generate {run: "data modify storage bs:lambda collection.result set value 1", limit: 0}
assert data storage bs:out {collection: {value: []}}

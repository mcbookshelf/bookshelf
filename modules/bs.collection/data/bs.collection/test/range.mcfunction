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

# Range 0 to 5 step 1 -> [0, 1, 2, 3, 4]
function #bs.collection:range {min: 0, max: 5, step: 1}
assert data storage bs:out {collection: {value: [0, 1, 2, 3, 4]}}

# Range 0 to 5 step 2 -> [0, 2, 4]
function #bs.collection:range {min: 0, max: 5, step: 2}
assert data storage bs:out {collection: {value: [0, 2, 4]}}

# Range error: min > max
data modify storage bs:out collection.value set value ["untouched"]
execute store success score #success bs.ctx run function #bs.collection:range {min: 5, max: 0, step: -1}
assert score #success bs.ctx matches 0
assert data storage bs:out {collection: {value: ["untouched"]}}

# Range error: min == max
data modify storage bs:out collection.value set value ["untouched"]
execute store success score #success bs.ctx run function #bs.collection:range {min: 0, max: 0, step: 1}
assert score #success bs.ctx matches 0
assert data storage bs:out {collection: {value: ["untouched"]}}

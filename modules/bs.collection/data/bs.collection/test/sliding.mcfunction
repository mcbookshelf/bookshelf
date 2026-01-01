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

# Window(2,1): [[1, 2], [2, 3], [3, 4], [4, 5], [5, 6]]
data modify storage bs:out collection.value set value [1, 2, 3, 4, 5, 6]
function bs.collection:sliding/sliding {size: 2, step: 1}
assert data storage bs:out {collection: {value: [[1, 2], [2, 3], [3, 4], [4, 5], [5, 6]]}}

# Window(3,2): [[1, 2, 3], [3, 4]] (on [1, 2, 3, 4])
data modify storage bs:out collection.value set value [1, 2, 3, 4]
function bs.collection:sliding/sliding {size: 3, step: 2}
assert data storage bs:out {collection: {value: [[1, 2, 3], [3, 4]]}}

# Window(3,2) on [1, 2, 3, 4, 5, 6] -> [[1, 2, 3], [3, 4, 5], [5, 6]]
data modify storage bs:out collection.value set value [1, 2, 3, 4, 5, 6]
function bs.collection:sliding/sliding {size: 3, step: 2}
assert data storage bs:out {collection: {value: [[1, 2, 3], [3, 4, 5], [5, 6]]}}

# Window larger than list
data modify storage bs:out collection.value set value [1, 2]
function bs.collection:sliding/sliding {size: 3, step: 1}
assert data storage bs:out {collection: {value: [[1, 2]]}}

# Empty
data modify storage bs:out collection.value set value []
function bs.collection:sliding/sliding {size: 2, step: 1}
assert data storage bs:out {collection: {value: []}}

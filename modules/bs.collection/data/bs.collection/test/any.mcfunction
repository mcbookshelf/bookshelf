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

# Has matching element at index 2
data modify storage bs:out collection.value set value [1, 2, 3, 4, 5]
assert run function #bs.collection:any {run: "execute if data storage bs:lambda collection{index: 2}"}

# No matching element (index 10 doesn't exist)
data modify storage bs:out collection.value set value [1, 2, 4, 5]
assert not run function #bs.collection:any {run: "execute if data storage bs:lambda collection{index: 10}"}

# Empty collection
data modify storage bs:out collection.value set value []
assert not run function #bs.collection:any {run: "execute if data storage bs:lambda collection{index: 0}"}

# First element matches (index 0)
data modify storage bs:out collection.value set value [3, 1, 2]
assert run function #bs.collection:any {run: "execute if data storage bs:lambda collection{index: 0}"}

# Last element matches (index 2 in 3-element collection)
data modify storage bs:out collection.value set value [1, 2, 3]
assert run function #bs.collection:any {run: "execute if data storage bs:lambda collection{index: 2}"}

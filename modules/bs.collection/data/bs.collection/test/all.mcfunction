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

# All elements are string "a"
data modify storage bs:out collection.value set value ["a", "a", "a", "a"]
assert run function #bs.collection:all {run: "execute if data storage bs:lambda collection{value: 'a'}"}

# Not all elements are "a" (last one is "b")
data modify storage bs:out collection.value set value ["a", "a", "a", "b"]
assert not run function #bs.collection:all {run: "execute if data storage bs:lambda collection{value: 'a'}"}

# Empty collection (vacuous truth)
data modify storage bs:out collection.value set value []
assert run function #bs.collection:all {run: "execute if data storage bs:lambda collection{index: 999}"}

# Single element matches
data modify storage bs:out collection.value set value [5]
assert run function #bs.collection:all {run: "execute if data storage bs:lambda collection{value: 5}"}

# First element fails
data modify storage bs:out collection.value set value [99, "a", "a"]
assert not run function #bs.collection:all {run: "execute if data storage bs:lambda collection{value: 'a'}"}

# Index are 0 based
data modify storage bs:ward collection.all set value []
data modify storage bs:out collection.value set value ["i", "n", "d", "e", "x"]
function #bs.collection:all {run: "data modify storage bs:ward collection.all append from storage bs:lambda collection.index"}
assert data storage bs:ward collection{all: [0, 1, 2, 3, 4]}

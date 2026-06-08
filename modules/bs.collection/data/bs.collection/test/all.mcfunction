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

# All elements are string "a"
data modify storage bs:out collection.value set value ["a", "a", "a", "a"]
execute store success score #s bs.ctx run function #bs.collection:all {run: "execute if data storage bs:lambda collection{value: 'a'}"}
assert score #s bs.ctx matches 1

# Not all elements are "a" (last one is "b")
data modify storage bs:out collection.value set value ["a", "a", "a", "b"]
execute store success score #s bs.ctx run function #bs.collection:all {run: "execute if data storage bs:lambda collection{value: 'a'}"}
assert score #s bs.ctx matches 0

# Empty collection (vacuous truth)
data modify storage bs:out collection.value set value []
execute store success score #s bs.ctx run function #bs.collection:all {run: "execute if data storage bs:lambda collection{index: 999}"}
assert score #s bs.ctx matches 1

# Single element matches
data modify storage bs:out collection.value set value [5]
execute store success score #s bs.ctx run function #bs.collection:all {run: "execute if data storage bs:lambda collection{value: 5}"}
assert score #s bs.ctx matches 1

# First element fails
data modify storage bs:out collection.value set value [99, "a", "a"]
execute store success score #s bs.ctx run function #bs.collection:all {run: "execute if data storage bs:lambda collection{value: 'a'}"}
assert score #s bs.ctx matches 0

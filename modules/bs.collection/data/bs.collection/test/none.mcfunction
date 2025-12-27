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

# No elements have index 10
data modify storage bs:out collection.value set value [1, 2, 4, 5]
execute store success score #s bs.ctx run function #bs.collection:none {run: "execute if data storage bs:lambda collection{index: 10}"}
assert score #s bs.ctx matches 1

# One element has index 2
data modify storage bs:out collection.value set value [1, 2, 3, 4]
execute store success score #s bs.ctx run function #bs.collection:none {run: "execute if data storage bs:lambda collection{index: 2}"}
assert score #s bs.ctx matches 0

# Empty collection
data modify storage bs:out collection.value set value []
execute store success score #s bs.ctx run function #bs.collection:none {run: "execute if data storage bs:lambda collection{index: 0}"}
assert score #s bs.ctx matches 1

# No elements have value 99
data modify storage bs:out collection.value set value [3, 3, 3]
execute store success score #s bs.ctx run function #bs.collection:none {run: "execute if data storage bs:lambda collection{value: 99}"}
assert score #s bs.ctx matches 1

# First element has index 0
data modify storage bs:out collection.value set value [3, 1, 2]
execute store success score #s bs.ctx run function #bs.collection:none {run: "execute if data storage bs:lambda collection{index: 0}"}
assert score #s bs.ctx matches 0

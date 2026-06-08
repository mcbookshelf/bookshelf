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

# Contains integer value 3
data modify storage bs:out collection.value set value [1, 2, 3, 4, 5]
execute store success score #s bs.ctx run function #bs.collection:contains {searched: 3}
assert score #s bs.ctx matches 1

# Contains integer value at start
data modify storage bs:out collection.value set value [1, 2, 3, 4, 5]
execute store success score #s bs.ctx run function #bs.collection:contains {searched: 1}
assert score #s bs.ctx matches 1

# Contains integer value at end
data modify storage bs:out collection.value set value [1, 2, 3, 4, 5]
execute store success score #s bs.ctx run function #bs.collection:contains {searched: 5}
assert score #s bs.ctx matches 1

# Does not contain integer value
data modify storage bs:out collection.value set value [1, 2, 3, 4, 5]
execute store success score #s bs.ctx run function #bs.collection:contains {searched: 10}
assert score #s bs.ctx matches 0

# Contains string value
data modify storage bs:out collection.value set value ["a", "b", "c"]
execute store success score #s bs.ctx run function #bs.collection:contains {searched: "b"}
assert score #s bs.ctx matches 1

# Does not contain string value
data modify storage bs:out collection.value set value ["a", "b", "c"]
execute store success score #s bs.ctx run function #bs.collection:contains {searched: "d"}
assert score #s bs.ctx matches 0

# Contains double value
data modify storage bs:out collection.value set value [1.5d, 2.5d, 3.5d]
execute store success score #s bs.ctx run function #bs.collection:contains {searched: 2.5d}
assert score #s bs.ctx matches 1

# Empty collection contains nothing
data modify storage bs:out collection.value set value []
execute store success score #s bs.ctx run function #bs.collection:contains {searched: 1}
assert score #s bs.ctx matches 0

# Single element collection - contains
data modify storage bs:out collection.value set value [42]
execute store success score #s bs.ctx run function #bs.collection:contains {searched: 42}
assert score #s bs.ctx matches 1

# Single element collection - does not contain
data modify storage bs:out collection.value set value [42]
execute store success score #s bs.ctx run function #bs.collection:contains {searched: 10}
assert score #s bs.ctx matches 0

# Contains duplicate value
data modify storage bs:out collection.value set value [1, 2, 3, 2, 4]
execute store success score #s bs.ctx run function #bs.collection:contains {searched: 2}
assert score #s bs.ctx matches 1

# Contains negative integer
data modify storage bs:out collection.value set value [-5, -3, -1, 0, 1]
execute store success score #s bs.ctx run function #bs.collection:contains {searched: -3}
assert score #s bs.ctx matches 1

# Contains zero
data modify storage bs:out collection.value set value [-1, 0, 1]
execute store success score #s bs.ctx run function #bs.collection:contains {searched: 0}
assert score #s bs.ctx matches 1

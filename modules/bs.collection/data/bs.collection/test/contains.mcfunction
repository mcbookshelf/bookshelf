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

# Contains integer value 3
data modify storage bs:out collection.value set value [1, 2, 3, 4, 5]
assert run function #bs.collection:contains {searched: 3}

# Contains integer value at start
data modify storage bs:out collection.value set value [1, 2, 3, 4, 5]
assert run function #bs.collection:contains {searched: 1}

# Contains integer value at end
data modify storage bs:out collection.value set value [1, 2, 3, 4, 5]
assert run function #bs.collection:contains {searched: 5}

# Does not contain integer value
data modify storage bs:out collection.value set value [1, 2, 3, 4, 5]
assert not run function #bs.collection:contains {searched: 10}

# Contains string value
data modify storage bs:out collection.value set value ["a", "b", "c"]
assert run function #bs.collection:contains {searched: "b"}

# Does not contain string value
data modify storage bs:out collection.value set value ["a", "b", "c"]
assert not run function #bs.collection:contains {searched: "d"}

# Contains double value
data modify storage bs:out collection.value set value [1.5d, 2.5d, 3.5d]
assert run function #bs.collection:contains {searched: 2.5d}

# Empty collection contains nothing
data modify storage bs:out collection.value set value []
assert not run function #bs.collection:contains {searched: 1}

# Single element collection - contains
data modify storage bs:out collection.value set value [42]
assert run function #bs.collection:contains {searched: 42}

# Single element collection - does not contain
data modify storage bs:out collection.value set value [42]
assert not run function #bs.collection:contains {searched: 10}

# Contains duplicate value
data modify storage bs:out collection.value set value [1, 2, 3, 2, 4]
assert run function #bs.collection:contains {searched: 2}

# Contains negative integer
data modify storage bs:out collection.value set value [-5, -3, -1, 0, 1]
assert run function #bs.collection:contains {searched: -3}

# Contains zero
data modify storage bs:out collection.value set value [-1, 0, 1]
assert run function #bs.collection:contains {searched: 0}

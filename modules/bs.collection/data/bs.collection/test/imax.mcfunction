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

# Maximum of positive numbers - check success channel
data modify storage bs:out collection.value set value [5, 2, 8, 1, 9]
assert run function #bs.collection:imax

# Maximum of positive numbers
data modify storage bs:out collection.value set value [5, 2, 8, 1, 9]
assert result 9 run function #bs.collection:imax
assert data storage bs:out {collection: {value: 9}}

# Maximum with negative numbers
data modify storage bs:out collection.value set value [-5, -2, -7, -3, -1]
assert result -1 run function #bs.collection:imax
assert data storage bs:out {collection: {value: -1}}

# Maximum with empty collection - check success channel
data modify storage bs:out collection.value set value []
assert not run function #bs.collection:imax

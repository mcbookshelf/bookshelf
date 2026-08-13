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

# Average of 1,2,3,4,5 = 15/5 = 3
data modify storage bs:out collection.value set value [1, 2, 3, 4, 5]
assert result 3000 run function #bs.collection:iaverage {scale: 1000}
assert data storage bs:out {collection: {value: 3.0d}}

# Average of 1,2
data modify storage bs:out collection.value set value [1, 2]
assert result 1500 run function #bs.collection:iaverage {scale: 1000}
assert data storage bs:out {collection: {value: 1.5d}}

# Average of single element
data modify storage bs:out collection.value set value [42]
assert result 42000 run function #bs.collection:iaverage {scale: 1000}
assert data storage bs:out {collection: {value: 42.0d}}

# Average with negative numbers
data modify storage bs:out collection.value set value [-10, 0, 10]
assert result 0 run function #bs.collection:iaverage {scale: 1000}
assert data storage bs:out {collection: {value: 0.0d}}

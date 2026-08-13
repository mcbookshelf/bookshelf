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

# Count of 5 elements - check return channel
data modify storage bs:out collection.value set value [1, 2, 3, 4, 5]
assert result 5 run function #bs.collection:count

# Count of 5 elements - check storage output
data modify storage bs:out collection.value set value [1, 2, 3, 4, 5]
function #bs.collection:count
assert data storage bs:out {collection: {value: 5}}

# Count of empty collection - check return channel
data modify storage bs:out collection.value set value []
assert result 0 run function #bs.collection:count

# Count of empty collection - check storage output
data modify storage bs:out collection.value set value []
function #bs.collection:count
assert data storage bs:out {collection: {value: 0}}

# Count of single element - check return channel
data modify storage bs:out collection.value set value [42]
assert result 1 run function #bs.collection:count

# Count of single element - check storage output
data modify storage bs:out collection.value set value [42]
function #bs.collection:count
assert data storage bs:out {collection: {value: 1}}

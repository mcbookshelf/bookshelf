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

# Maximum of positive numbers - check success channel
data modify storage bs:out collection.value set value [5, 2, 8, 1, 9]
execute store success score #s bs.ctx run function #bs.collection:imax
assert score #s bs.ctx matches 1

# Maximum of positive numbers - check return channel
data modify storage bs:out collection.value set value [5, 2, 8, 1, 9]
execute store result score #r bs.ctx run function #bs.collection:imax
assert score #r bs.ctx matches 9

# Maximum of positive numbers - check storage output
data modify storage bs:out collection.value set value [5, 2, 8, 1, 9]
function #bs.collection:imax
assert data storage bs:out {collection: {value: 9}}

# Maximum with negative numbers - check return channel
data modify storage bs:out collection.value set value [-5, -2, -7, -3, -1]
execute store result score #r bs.ctx run function #bs.collection:imax
assert score #r bs.ctx matches -1

# Maximum with negative numbers - check storage output
data modify storage bs:out collection.value set value [-5, -2, -7, -3, -1]
function #bs.collection:imax
assert data storage bs:out {collection: {value: -1}}

# Maximum with negative numbers - check storage output
data modify storage bs:out collection.value set value []
execute store success score #s bs.ctx run function #bs.collection:imax
assert score #s bs.ctx matches 0

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

data modify storage bs:ctx _ append from storage bs:out collection.value[0]
data remove storage bs:out collection.value[0]
scoreboard players remove #n bs.ctx 1

# Recurse if there are more elements
execute if data storage bs:out collection.value[0] if score #n bs.ctx matches 1.. run function bs.collection:take/take_rec

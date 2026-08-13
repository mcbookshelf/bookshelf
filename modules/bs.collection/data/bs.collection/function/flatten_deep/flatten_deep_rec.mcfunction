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

# Take head of queue
data modify storage bs:ctx _.current set from storage bs:ctx _.value[0]

# Check if current is a list by trying to append a dummy value to a copy
execute store success score #s bs.ctx run data modify storage bs:ctx _.value[0] append value 1
data remove storage bs:ctx _.value[0]

# If it is a list (#s = 1):
# - Prepend its content to the queue.
# - If it was an empty list [], current[] is empty, nothing is added, and the empty list is effectively removed.
execute if score #s bs.ctx matches 1 run data modify storage bs:ctx _.value prepend from storage bs:ctx _.current[]

# If it is NOT a list (#s = 0):
# - It's a scalar or object, append it to the result
execute if score #s bs.ctx matches 0 run data modify storage bs:out collection.value append from storage bs:ctx _.current

execute if data storage bs:ctx _.value[0] run function bs.collection:flatten_deep/flatten_deep_rec

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

execute unless data storage bs:ctx _.flatten_deep.queue[0] run return 1

# Take head of queue
data modify storage bs:ctx _.flatten_deep.current set from storage bs:ctx _.flatten_deep.queue[0]
data remove storage bs:ctx _.flatten_deep.queue[0]

# Check if current is a list by trying to append a dummy value to a copy
data modify storage bs:ctx _.flatten_deep.check set from storage bs:ctx _.flatten_deep.current
execute store success score #is_list bs.ctx run data modify storage bs:ctx _.flatten_deep.check append value 1

# If it is a list (#is_list = 1):
# - Prepend its content to the queue. 
# - If it was an empty list [], current[] is empty, nothing is added, and the empty list is effectively removed.
execute if score #is_list bs.ctx matches 1 run data modify storage bs:ctx _.flatten_deep.queue prepend from storage bs:ctx _.flatten_deep.current[]

# If it is NOT a list (#is_list = 0):
# - It's a scalar or object, append it to the result
execute if score #is_list bs.ctx matches 0 run data modify storage bs:out collection.value append from storage bs:ctx _.flatten_deep.current

function bs.collection:flatten_deep/flatten_deep_rec

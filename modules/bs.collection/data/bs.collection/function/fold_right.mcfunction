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

# reduce<T>(collection: T[], initial: T, fn: (accumulator: T, value: T) => T): T

$data modify storage bs:data collection.stack prepend value { value: [], run: "$(run)", result: null, accumulator: "$(initial)" }

# Set the collection and accumulator to the first element of the collection
data modify storage bs:data collection.stack[0].value set from storage bs:out collection

# If the collection had at least one element, we reduce the collection
execute if data storage bs:data collection.stack[0].value[0] run function bs.collection:internal/reduce_right_rec

# Set the result to the accumulator
data modify storage bs:out collection set from storage bs:data collection.stack[0].accumulator

data remove storage bs:data collection.stack[0]
return 0

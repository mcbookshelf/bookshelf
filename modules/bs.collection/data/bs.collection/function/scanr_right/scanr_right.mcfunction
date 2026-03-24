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

execute unless data storage bs:out collection.value[0] run return fail
$data modify storage bs:data collection.stack prepend value { value: [], run: "$(run)", result: [], accumulator: null, i: -1 }

data modify storage bs:data collection.stack[0].value set from storage bs:out collection.value
data modify storage bs:data collection.stack[0].accumulator set from storage bs:out collection.value[-1]
data modify storage bs:data collection.stack[0].result append from storage bs:data collection.stack[0].accumulator
data remove storage bs:data collection.stack[0].value[-1]

execute if data storage bs:data collection.stack[0].value[0] run function bs.collection:scanr_right/scanr_right_rec

data modify storage bs:out collection.value set from storage bs:data collection.stack[0].result
data remove storage bs:data collection.stack[0]

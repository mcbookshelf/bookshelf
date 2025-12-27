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

$data modify storage bs:data collection.stack prepend value { value: [], run: "$(run)", result: 1b, consumed: [] }

data modify storage bs:data collection.stack[0].value set from storage bs:out collection.value
# If the collection is empty, the return value must be true
scoreboard players set #s bs.ctx 1
execute if data storage bs:data collection.stack[0].value[0] store success score #s bs.ctx run function bs.collection:internal/none_rec

data remove storage bs:data collection.stack[0]

return run execute if score #s bs.ctx matches 1

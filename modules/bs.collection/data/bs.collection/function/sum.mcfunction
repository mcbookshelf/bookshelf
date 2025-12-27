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

data modify storage bs:data collection.stack prepend value { value: [], scale: 1000 }

data modify storage bs:data collection.stack[0].value set from storage bs:out collection.value

# Initialize sum to 0
scoreboard players set #s bs.ctx 0
execute if data storage bs:data collection.stack[0].value[0] run function bs.collection:internal/sum_rec with storage bs:data collection.stack[0]

# Result on storage rescaled to original scale using data get for precision
execute store result storage bs:out collection.value int 1 run scoreboard players get #s bs.ctx
execute store result storage bs:out collection.value double 0.001 run data get storage bs:out collection.value

data remove storage bs:data collection.stack[0]

return run scoreboard players get #s bs.ctx

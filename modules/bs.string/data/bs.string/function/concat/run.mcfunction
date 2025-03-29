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

data modify storage bs:ctx _.1 set from storage bs:ctx _.list[-1]
data remove storage bs:ctx _.list[-1]
execute store result score #n bs.ctx if data storage bs:ctx _.list[]

# sizes below 64 are processed in a single step
execute if score #n bs.ctx matches 65.. run function bs.string:concat/dispatch/chunked

# determine which dispatch function to call
execute store result storage bs:ctx x int 1 run scoreboard players operation #c bs.ctx = #n bs.ctx
execute store result storage bs:ctx y int 1 run scoreboard players operation #c bs.ctx /= 8 bs.const
execute if score #n bs.ctx matches 1.. run function bs.string:concat/dispatch/fixed with storage bs:ctx

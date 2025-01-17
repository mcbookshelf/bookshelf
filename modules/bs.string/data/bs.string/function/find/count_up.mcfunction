# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Gunivers
#
# This file is part of the Bookshelf project (https://github.com/mcbookshelf/Bookshelf).
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

data modify storage bs:out string.find append from storage bs:ctx x
scoreboard players add #c bs.ctx 1
execute if score #c bs.ctx = #bs.string.occurrence bs.data run return 0

execute if score #l bs.ctx = #i bs.ctx run return run data get storage bs:out string.find

execute store result storage bs:ctx x int 1 run scoreboard players add #i bs.ctx 1
data modify storage bs:ctx _.str set string storage bs:ctx _.str 1

function bs.string:find/count_search with storage bs:ctx

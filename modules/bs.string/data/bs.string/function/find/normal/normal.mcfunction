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

$data modify storage bs:ctx _.test set string storage bs:ctx _.str 0 $(y)
data modify storage bs:ctx _.ltr set string storage bs:ctx _.test -1
execute store success score #t bs.ctx run data modify storage bs:ctx _.test set from storage bs:in string.find.needle

execute if score #t bs.ctx matches 0 run data modify storage bs:out string.find append value 0
execute if score #t bs.ctx matches 0 store result storage bs:out string.find[-1] int 1 run scoreboard players get #i bs.ctx 

data modify storage bs:ctx z set from storage bs:ctx y
function bs.string:find/match_pattern with storage bs:ctx _

function bs.string:find/normal/skip with storage bs:ctx

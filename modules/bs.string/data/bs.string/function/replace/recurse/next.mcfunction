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

$data modify storage bs:ctx _.test set string storage bs:ctx _.str 0 $(y)
data modify storage bs:ctx _.ltr set string storage bs:ctx _.test -1
execute store success score #t bs.ctx run data modify storage bs:ctx _.test set from storage bs:ctx _.old

execute if score #t bs.ctx matches 0 store result storage bs:ctx x int 1 run scoreboard players get #d bs.ctx
execute if score #t bs.ctx matches 0 run return run function bs.string:replace/recurse/found with storage bs:ctx

function bs.string:utils/skip_table/match with storage bs:ctx _

scoreboard players operation #l bs.ctx -= #z bs.ctx
scoreboard players operation #d bs.ctx += #z bs.ctx

execute if score #l bs.ctx matches ..-1 run return run data modify storage bs:ctx _.list append from storage bs:ctx _.ret
function bs.string:replace/recurse/substr with storage bs:ctx
function bs.string:replace/recurse/next with storage bs:ctx

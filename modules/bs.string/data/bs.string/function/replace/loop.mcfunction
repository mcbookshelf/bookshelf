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

execute if score #l bs.ctx <= #i bs.ctx run return run function bs.string:replace/last with storage bs:ctx

$data modify storage bs:ctx _.test set string storage bs:ctx _.str 0 $(y)
execute store success score #t bs.ctx run data modify storage bs:ctx _.test set from storage bs:in string.replace.old
execute if score #t bs.ctx matches 0 run return run function bs.string:replace/cut with storage bs:ctx


execute store result storage bs:ctx x int 1 run scoreboard players add #i bs.ctx 1
data modify storage bs:ctx _.str set string storage bs:ctx _.str 1

function bs.string:replace/loop with storage bs:ctx

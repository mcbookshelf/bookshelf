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

$data modify storage bs:out string.split append string storage bs:in string.split.str $(z) $(x)
execute store result storage bs:ctx x int 1 store result storage bs:ctx z int 1 run scoreboard players operation #i bs.ctx += #p bs.ctx
scoreboard players add #c bs.ctx 1

$data modify storage bs:ctx _.str set string storage bs:ctx _.str $(y)

execute if score #c bs.ctx >= #bs.string.maxsplit bs.data run return run data modify storage bs:out string.split append from storage bs:ctx _.str

function bs.string:split/count/loop with storage bs:ctx

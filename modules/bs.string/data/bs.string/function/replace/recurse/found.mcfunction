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

$data modify storage bs:ctx _.list append string storage bs:ctx _.ret 0 $(x)
data modify storage bs:ctx _.list append from storage bs:ctx _.new
$data modify storage bs:ctx _.str set string storage bs:ctx _.str $(y)
data modify storage bs:ctx _.ret set from storage bs:ctx _.str

# count operations
scoreboard players add #c bs.ctx 1
scoreboard players set #d bs.ctx 0
scoreboard players operation #l bs.ctx -= #y bs.ctx

execute if score #l bs.ctx matches ..-1 run return run data modify storage bs:ctx _.list append from storage bs:ctx _.ret
execute unless score #o bs.ctx matches ..-1 if score #c bs.ctx = #o bs.ctx run return run data modify storage bs:ctx _.list append from storage bs:ctx _.ret

function bs.string:replace/recurse/next with storage bs:ctx

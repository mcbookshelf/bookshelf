# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2026 Gunivers
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

function bs.animation:utils/advance with storage bs.animation: stack[-1]._[0]
$$(run)
execute unless data storage bs.animation: stack[-1]._[0].w run return 0
execute store result score #w bs.ctx store result storage bs.animation: stack[-1]._[0].w int 1 run function bs.animation:utils/process/schedule with storage bs.animation: stack[-1]._[0]
execute unless score @s bs.anim < #w bs.ctx run scoreboard players operation @s bs.anim = #w bs.ctx

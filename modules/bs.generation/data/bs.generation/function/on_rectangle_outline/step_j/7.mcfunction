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

$$(run)
scoreboard players remove #generation.j bs.data 1
$execute positioned $(j_pre)1$(j_post) run $(run)
scoreboard players remove #generation.j bs.data 1
$execute positioned $(j_pre)2$(j_post) run $(run)
scoreboard players remove #generation.j bs.data 1
$execute positioned $(j_pre)3$(j_post) run $(run)
scoreboard players remove #generation.j bs.data 1
$execute positioned $(j_pre)4$(j_post) run $(run)
scoreboard players remove #generation.j bs.data 1
$execute positioned $(j_pre)5$(j_post) run $(run)
scoreboard players remove #generation.j bs.data 1
$execute positioned $(j_pre)6$(j_post) run $(run)
scoreboard players remove #generation.j bs.data 1
scoreboard players remove #generation.batch bs.data 7
$execute if score #generation.j bs.data matches 2.. positioned $(j_pre)7$(j_post) run return run function bs.generation:on_rectangle_outline/pause

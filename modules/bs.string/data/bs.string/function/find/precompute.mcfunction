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

execute if score #e bs.ctx matches 1 run return 1
execute store result storage bs:ctx z int 1 run scoreboard players remove #e bs.ctx 1
$data modify storage bs:ctx _.patern.$(ltr) set from storage bs:ctx z

data modify storage bs:ctx _.ltr set string storage bs:ctx _.needle 0 1
data modify storage bs:ctx _.needle set string storage bs:ctx _.needle 1
function bs.string:find/precompute with storage bs:ctx _

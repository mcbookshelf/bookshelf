# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2024 Gunivers
#
# This file is part of the Bookshelf project (https://github.com/Gunivers/Bookshelf).
#
# This source code is subject to the terms of the Mozilla Public License, v. 2.0.
# If a copy of the MPL was not distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# Conditions:
# - You may use this file in compliance with the MPL v2.0
# - Any modifications must be documented and disclosed under the same license
#
# For more details, refer to the MPL v2.0.
#
# Documentation of the feature: https://bookshelf.docs.gunivers.net/en/latest/modules/string.html#lower-case
# ------------------------------------------------------------------------------------------------------------

data remove storage bs:ctx _.lt
$data modify storage bs:ctx _.lt set from storage bs:data string.CharMap.Fast[{u:"$(ch)"}].l
data modify storage bs:ctx _.l append from storage bs:ctx _.lt
execute unless data storage bs:ctx _.lt run data modify storage bs:ctx _.l append from storage bs:ctx _.ch

#loop
execute if score #c bs.ctx matches 1 run return 0
scoreboard players remove #c bs.ctx 1
data modify storage bs:ctx _.st set string storage bs:ctx _.st 1
data modify storage bs:ctx _.ch set string storage bs:ctx _.st 0 1
function bs.string:lower_case/fast/loop with storage bs:ctx _

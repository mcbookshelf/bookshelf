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

$execute store success score #s bs.ctx run data modify storage bs:ctx _.list append from storage bs:const string.upper."$(ch)"
execute if score #s bs.ctx matches 0 run data modify storage bs:ctx _.list append from storage bs:ctx _.ch

scoreboard players remove #c bs.ctx 1
data modify storage bs:ctx _.str set string storage bs:ctx _.str 1
data modify storage bs:ctx _.ch set string storage bs:ctx _.str 0 1
execute if score #c bs.ctx matches 1.. run function bs.string:upper/loop with storage bs:ctx _

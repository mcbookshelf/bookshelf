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
# Documentation of the feature: https://bookshelf.docs.gunivers.net/en/latest/modules/string.html#find
# ------------------------------------------------------------------------------------------------------------

$execute store success score #t bs.ctx run data modify storage bs:ctx _.test set string storage bs:ctx _.str 0 $(y)
execute if score #t bs.ctx matches 0 run data modify storage bs:out string.find append from storage bs:ctx x

execute if score #string.lenth bs.data = #i bs.ctx run return run data get storage bs:out string.find

execute store result storage bs:ctx x int 1 run scoreboard players add #i bs.ctx 1
data modify storage bs:ctx _.test set from storage bs:in string.find.pat
data modify storage bs:ctx _.str set string storage bs:ctx _.str 1

function bs.string:find/normal_search with storage bs:ctx

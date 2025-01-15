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

$scoreboard players set #bs.string.occurrence bs.data $(occurrence)
data modify storage bs:out string.find set value []
scoreboard players set #c bs.ctx 0
execute store result storage bs:ctx x int 1 run scoreboard players set #i bs.ctx 0
data modify storage bs:ctx _.str set from storage bs:in string.find.str
execute store result score #l bs.ctx run data get storage bs:in string.find.str
execute store result score #p bs.ctx store result storage bs:ctx y int 1 run data get storage bs:in string.find.needle

execute if score #p bs.ctx > #l bs.ctx run return 0
scoreboard players operation #l bs.ctx -= #p bs.ctx

execute if score #bs.string.occurrence bs.data matches 0 run return run function bs.string:find/normal_search with storage bs:ctx
execute if score #bs.string.occurrence bs.data matches 1.. run return run function bs.string:find/count_search with storage bs:ctx
execute store result storage bs:ctx x int 1 store result score #i bs.ctx run scoreboard players get #l bs.ctx
return run function bs.string:find/inverse_search with storage bs:ctx

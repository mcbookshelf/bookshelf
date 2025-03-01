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

#reset
data modify storage bs:ctx _.l set value []
execute store result score #c bs.ctx store result storage bs:ctx x int 1 run scoreboard players set #i bs.ctx 0
scoreboard players set #d bs.ctx -1

#size check
execute store result score #l bs.ctx run data get storage bs:in string.replace.str
execute store result score #p bs.ctx store result score #e bs.ctx store result storage bs:ctx y int 1 run data get storage bs:in string.replace.old

#moving values
data modify storage bs:ctx _ set from storage bs:in string.replace
data modify storage bs:ctx _.rep set from storage bs:in string.replace.str

execute if score #p bs.ctx > #l bs.ctx run return 0
scoreboard players operation #l bs.ctx -= #p bs.ctx

#precompute
data modify storage bs:ctx _.ltr set string storage bs:ctx _.old 0 1
data modify storage bs:ctx _.old set string storage bs:ctx _.old 1
data remove storage bs:ctx _.patern
function bs.string:replace/precompute with storage bs:ctx _

function bs.string:replace/loop with storage bs:ctx

function bs.string:concat/run

data modify storage bs:out string.replace set from storage bs:ctx _.s.1

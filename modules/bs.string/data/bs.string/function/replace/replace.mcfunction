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
execute store result storage bs:ctx x int 1 store result storage bs:ctx z int 1 run scoreboard players set #i bs.ctx 0

#size check
execute store result score #l bs.ctx run data get storage bs:in string.replace.str
execute store result score #p bs.ctx store result storage bs:ctx y int 1 run data get storage bs:in string.replace.old
execute if score #p bs.ctx > #l bs.ctx run return 0

#moving values
data modify storage bs:ctx _.str set from storage bs:in string.replace.str

scoreboard players add #l bs.ctx 1
scoreboard players operation #l bs.ctx -= #p bs.ctx

#check values
function bs.string:replace/loop with storage bs:ctx

#tellraw @a [{"storage": "bs:ctx","nbt": "_.l"}]
#concat
#tellraw @a [{"storage": "bs:ctx","nbt": "_.s"}," ",{"storage": "bs:ctx","nbt": "x"}]
function bs.string:concat/run

data modify storage bs:out string.replace set from storage bs:ctx _.s.1

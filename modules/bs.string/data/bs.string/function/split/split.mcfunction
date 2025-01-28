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
$scoreboard players set #o bs.ctx $(maxsplit)

#reset
data modify storage bs:out string.split set value []
execute store result score #c bs.ctx run scoreboard players set #i bs.ctx 0
scoreboard players set #d bs.ctx -1

#size check
execute store result score #l bs.ctx run data get storage bs:in string.split.str
execute store result score #p bs.ctx store result storage bs:ctx y int 1 run data get storage bs:in string.split.separator

execute if score #p bs.ctx > #l bs.ctx run return 0
scoreboard players add #l bs.ctx 1

#moving values
data modify storage bs:ctx _ set from storage bs:in string.split
data modify storage bs:ctx _.cut set from storage bs:in string.split.str
scoreboard players operation #l bs.ctx -= #p bs.ctx

#precompute
data modify storage bs:ctx _.ltr set string storage bs:ctx _.separator 0 1
data modify storage bs:ctx _.separator set string storage bs:ctx _.separator 1
data remove storage bs:ctx _.patern
function bs.string:split/precompute with storage bs:ctx _

#check values
execute if score #o bs.ctx matches 0 run return run function bs.string:split/normal/normal with storage bs:ctx
execute if score #o bs.ctx matches 1.. run return run function bs.string:split/count/count with storage bs:ctx
tellraw @a [{"text":"[Bookshelf] ","color":"gold"},{"text":"Error: ","color":"red"},{"text":"Doesn't support reversed split","color":"red"}]

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

function bs.block:fill/utils/resolve_from_pos with storage bs:in block.fill_type
execute store result score #x bs.ctx run data get storage bs:ctx _[0]
execute store result score #y bs.ctx run data get storage bs:ctx _[1]
execute store result score #z bs.ctx run data get storage bs:ctx _[2]

function bs.block:fill/utils/resolve_to_pos with storage bs:in block.fill_type
execute store result score #i bs.ctx run data get storage bs:ctx _[0]
execute store result score #j bs.ctx run data get storage bs:ctx _[1]
execute store result score #k bs.ctx run data get storage bs:ctx _[2]

execute if score #i bs.ctx < #x bs.ctx run scoreboard players operation #i bs.ctx >< #x bs.ctx
execute if score #j bs.ctx < #y bs.ctx run scoreboard players operation #j bs.ctx >< #y bs.ctx
execute if score #k bs.ctx < #z bs.ctx run scoreboard players operation #k bs.ctx >< #z bs.ctx
execute store result storage bs:ctx _[0] double 1 run scoreboard players get #x bs.ctx
execute store result storage bs:ctx _[1] double 1 run scoreboard players get #y bs.ctx
execute store result storage bs:ctx _[2] double 1 run scoreboard players get #z bs.ctx
data modify entity @s Pos set from storage bs:ctx _

execute store result score #x bs.ctx run scoreboard players operation #i bs.ctx -= #x bs.ctx
execute store result score #y bs.ctx run scoreboard players operation #j bs.ctx -= #y bs.ctx
execute store result score #z bs.ctx run scoreboard players operation #k bs.ctx -= #z bs.ctx

data modify storage bs:in block.fill_type._ set from storage bs:in block.fill_type.mode
execute if data storage bs:in block.fill_type.filter run data modify storage bs:in block.fill_type._ set value "filter"
execute positioned as @s run function bs.block:fill/type/x
tp @s ~ -100000 ~
kill @s

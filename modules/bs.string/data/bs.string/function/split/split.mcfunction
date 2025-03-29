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

data modify storage bs:ctx _ set from storage bs:in string.split
data modify storage bs:ctx _.substr set from storage bs:ctx _.separator
data modify storage bs:ctx _.ret set from storage bs:ctx _.str

execute store result score #l bs.ctx run data get storage bs:ctx _.str
execute store result score #p bs.ctx store result score #y bs.ctx store result storage bs:ctx y int 1 run data get storage bs:ctx _.separator

# edge cases: empty string, empty separator, separator longer than string
execute if score #l bs.ctx matches 0 run return run data modify storage bs:out string.split append value ""
execute if score #p bs.ctx matches 0 run function bs.string:type/to_list/loop
execute if score #p bs.ctx matches 0 run return run data modify storage bs:out string.split set from storage bs:ctx _.l
execute if score #p bs.ctx > #l bs.ctx run return run data modify storage bs:out string.split set from storage bs:ctx _.ret

data modify storage bs:out string.split set value []
execute store result score #c bs.ctx run scoreboard players set #d bs.ctx 0
execute store result score #o bs.ctx run data get storage bs:ctx _.maxsplit

scoreboard players operation #l bs.ctx -= #p bs.ctx
execute unless score #p bs.ctx matches 1 run function bs.string:utils/skip_table/compute

function bs.string:split/recurse/next with storage bs:ctx

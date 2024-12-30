# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2024 Gunivers
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

# get all attributes that belongs to the type input
$data modify storage bs:ctx _.attrs append from storage bs:ctx _.sets[{type:"$(type)"}].attrs[]
execute unless data storage bs:ctx _.attrs[-1] run return fail

# keep only the set that has the bs:out block type
function bs.block:transform/type_mappings/filter_type with storage bs:out block
execute unless data storage bs:ctx _.filter run return fail

# find entries that match the attributes
scoreboard players set #a bs.ctx 0
data modify storage bs:ctx _.attrs append from storage bs:ctx _.filter.attrs[]
data modify storage bs:ctx _.entry set from storage bs:ctx _.sets[-1]
function bs.block:transform/type_mappings/find_match with storage bs:ctx _.entry

# filter out entries that have more attributes
execute store result storage bs:ctx y byte 1 run scoreboard players get #a bs.ctx
function bs.block:transform/type_mappings/keep_best with storage bs:ctx

# filter out entries that are different from the input / output
$execute if data storage bs:ctx _.found[1] run data remove storage bs:ctx _.found[{type:"$(type)"}]
execute if data storage bs:ctx _.found[1] run function bs.block:transform/type_mappings/remove_type with storage bs:ctx _.filter

# replace the type in bs:out block
data modify storage bs:ctx _.type set from storage bs:ctx _.found[0].type
return run function #bs.block:replace_type with storage bs:ctx _

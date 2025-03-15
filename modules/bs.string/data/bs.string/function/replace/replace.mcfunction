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

# reset
execute store result score #c bs.ctx run scoreboard players set #d bs.ctx 0

data modify storage bs:ctx _ set from storage bs:in string.replace
data modify storage bs:ctx _.substr set from storage bs:in string.replace.old
data modify storage bs:ctx _.cut set from storage bs:in string.replace.str

execute store result score #o bs.ctx run data get storage bs:ctx _.maxreplace
execute store result score #l bs.ctx run data get storage bs:in string.replace.str
execute store result score #p bs.ctx store result score #y bs.ctx store result storage bs:ctx y int 1 run data get storage bs:ctx _.old

# corner case
execute if score #l bs.ctx matches 0 run return run data modify storage bs:out string.replace set value ""
execute if score #p bs.ctx matches 0 run return run function #bs.log:error { namespace: "bs.string", path: "bs.string:replace", tag: "replace", message: '"empty string find not implemented"' }
execute if score #p bs.ctx > #l bs.ctx run return run data modify storage bs:out string.replace set from storage bs:ctx _.cut

scoreboard players operation #l bs.ctx -= #p bs.ctx

execute unless score #p bs.ctx matches 1 run function bs.string:char_table/compute

function bs.string:replace/loop with storage bs:ctx

function bs.string:concat/run

data modify storage bs:out string.replace set from storage bs:ctx _.s.1

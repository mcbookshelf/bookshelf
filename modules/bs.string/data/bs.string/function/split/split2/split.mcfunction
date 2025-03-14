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

# #l = (taille_str - taille_pattern); #s = taille_pattern; x|#x = min = (taille - max)*-1 ; y|#y = max >= taille; z|#z = minCut ; #t = result test ; #a = jump size

data modify storage bs:out string.split set value []
data modify storage bs:ctx _ set from storage bs:in string.split
data modify storage bs:ctx _.substr set from storage bs:in string.split.separator

execute store result score #o bs.ctx run data get storage bs:ctx _.maxsplit
execute store result score #l bs.ctx run data get storage bs:ctx _.str
execute store result storage bs:ctx y int 1 store result score #y bs.ctx store result score #s bs.ctx run data get storage bs:ctx _.separator
execute store result storage bs:ctx x int 1 store result storage bs:ctx z int 1 store result score #x bs.ctx run scoreboard players set #z bs.ctx 0

# corner case
execute if score #l bs.ctx matches 0 run return run data modify storage bs:out string.split append value ""
execute if score #s bs.ctx matches 0 run function bs.string:type/to_list/run
execute if score #s bs.ctx matches 0 run return run data modify storage bs:out string.split set from storage bs:ctx _.l
execute if score #s bs.ctx > #l bs.ctx run return run data modify storage bs:out string.split set from storage bs:ctx _.str

scoreboard players operation #l bs.ctx -= #s bs.ctx
scoreboard players add #l bs.ctx 1
#need to differentiate the 0 from the rest
execute if score #o bs.ctx matches 1.. run scoreboard players add #o bs.ctx 1

execute unless score #s bs.ctx matches 1 run function bs.string:char_table/compute

execute if score #o bs.ctx matches 0.. run function bs.string:split/split2/count with storage bs:ctx

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

#tellraw @a [{"text":"x: "},{"score": {"name":"#x","objective":"bs.ctx"}},{"text":" y: "},{"score": {"name":"#y","objective":"bs.ctx"}},{"text":"; z: "},{"score": {"name":"#z","objective":"bs.ctx"}}]

$data modify storage bs:ctx _.test set string storage bs:ctx _.str $(x) $(y)
data modify storage bs:ctx _.ltr set string storage bs:ctx _.test -1
execute store success score #t bs.ctx run data modify storage bs:ctx _.test set from storage bs:in string.split.separator

execute if score #t bs.ctx matches 0 run function bs.string:split/split2/cut with storage bs:ctx

execute if score #t bs.ctx matches 1 run function bs.string:char_table/score_match_pat with storage bs:ctx _
execute if score #a bs.ctx matches 0 run scoreboard players operation #a bs.ctx = #s bs.ctx

execute store result storage bs:ctx x int 1 run scoreboard players operation #x bs.ctx += #a bs.ctx
execute store result storage bs:ctx y int 1 run scoreboard players operation #y bs.ctx += #a bs.ctx

execute if score #o bs.ctx matches 1 run return run function bs.string:split/split2/last with storage bs:ctx
execute if score #y bs.ctx > #l bs.ctx run return run function bs.string:split/split2/last with storage bs:ctx

function bs.string:split/split2/count with storage bs:ctx

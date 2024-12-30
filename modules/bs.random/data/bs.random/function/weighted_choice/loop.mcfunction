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

data modify storage bs:ctx _.pools[0].entries append value {type:"item",name:"cod",weight:1,functions:[{function:"set_custom_data",tag:{}}]}
data modify storage bs:ctx _.pools[0].entries[-1].weight set from storage bs:ctx _.weights[0]
data modify storage bs:ctx _.pools[0].entries[-1].functions[0].tag.v set from storage bs:ctx _.options[0]
execute store result storage bs:ctx _.pools[0].entries[-1].functions[0].tag.i int 1 run scoreboard players add #i bs.ctx 1
data remove storage bs:ctx _.options[0]
data remove storage bs:ctx _.weights[0]
execute if data storage bs:ctx _.options[-1] run function bs.random:weighted_choice/loop

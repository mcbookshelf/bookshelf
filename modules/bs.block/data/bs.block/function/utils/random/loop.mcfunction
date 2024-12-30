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

data modify storage bs:ctx _.pools[0].entries[-1].weight set from storage bs:data block._.entries[-1].weight
data modify storage bs:ctx _.pools[0].entries[-1].functions[0].tag.block set from storage bs:data block._.entries[-1].block
data modify storage bs:ctx _.pools[0].entries[-1].functions[0].tag.type set from storage bs:data block._.entries[-1].type

data remove storage bs:data block._.entries[-1]
execute if data storage bs:data block._.entries[-1] run function bs.block:utils/random/loop

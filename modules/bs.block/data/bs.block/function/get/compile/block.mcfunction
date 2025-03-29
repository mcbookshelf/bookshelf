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

execute store success score #s bs.ctx if data storage bs:out block._
execute store success score #n bs.ctx if data storage bs:out block.nbt

# return the block string: {type}
execute if score #s bs.ctx matches 0 if score #n bs.ctx matches 0 run return run data modify storage bs:out block.block set from storage bs:out block.type

# generate the state string
execute if score #s bs.ctx matches 1 run function bs.block:get/compile/state
data modify storage bs:ctx _ set from storage bs:out block

# return the block string: {type}{state}
execute if score #n bs.ctx matches 0 run return run function bs.block:get/compile/concat/block/state with storage bs:ctx _

# return the block string: {type}{state}{nbt}
execute as B5-0-0-0-2 run return run function bs.block:get/compile/nbt

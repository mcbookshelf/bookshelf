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

# return the type if there are no properties or NBT
execute unless data storage bs:out block._ \
  unless data storage bs:out block.nbt \
  run return run data modify storage bs:out block.block set from storage bs:out block.type

# compile the state string
execute if data storage bs:out block._ run function bs.block:get/compile/state

# generate the full block string representation
data modify storage bs:ctx _ set from storage bs:out block
execute unless data storage bs:ctx _.state run data modify storage bs:ctx _.state set value ""
execute if data storage bs:out block.nbt{} as B5-0-0-0-2 run return run function bs.block:get/compile/nbt
return run function bs.block:get/compile/concat/block/state with storage bs:ctx _

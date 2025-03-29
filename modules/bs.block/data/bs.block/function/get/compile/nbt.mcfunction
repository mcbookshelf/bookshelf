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

# convert the NBT to an escaped string
data modify storage bs:out block.nbt."'" set value ""
data modify entity @s text set value {storage:"bs:out",nbt:"block.nbt"}
data modify storage bs:data block.nbt._ set from entity @s text
data modify entity @s text set value {storage:"bs:data",nbt:"block.nbt"}
data modify storage bs:ctx _.nbt set string entity @s text 13 -3

# generate the full block string representation
execute unless data storage bs:ctx _.state run data modify storage bs:ctx _.state set value ""
return run function bs.block:get/compile/concat/block/nbt with storage bs:ctx _

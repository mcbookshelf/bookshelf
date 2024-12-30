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

# compile the state string or default to an empty one
execute if data storage bs:out block._ run function bs.block:get/compile/state
execute unless data storage bs:out block.state run data modify storage bs:out block.state set value ""
execute unless data storage bs:out block.properties run data modify storage bs:out block.properties set value {}

# escape the nbt or default to an empty string
execute store success score #s bs.ctx if data storage bs:out block.nbt{}
execute if score #s bs.ctx matches 0 run data modify storage bs:out block.nbt set value ""
execute if score #s bs.ctx matches 1 run data modify entity B5-0-0-0-2 text set value '{"storage":"bs:out","nbt":"block.nbt"}'

# generate the full block string representation
data modify storage bs:ctx _ set from storage bs:out block
execute if score #s bs.ctx matches 1 run data modify storage bs:ctx _.nbt set string entity B5-0-0-0-2 text 1 -1
return run function bs.block:get/compile/concat/block with storage bs:ctx _
